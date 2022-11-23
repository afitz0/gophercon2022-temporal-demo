"use strict";

import cors from 'cors';
import express, {Request, Response} from 'express';
import bodyParser from 'body-parser';
import {v4 as uuidv4} from 'uuid';
import {Logger} from 'tslog';
import type {TLogLevelName} from 'tslog';

import {Connection, WorkflowClient} from "@temporalio/client";
import {defineQuery} from "@temporalio/workflow";

import gopherpizza from '../lib/protos/root';
import p = gopherpizza.gopherpizza.pizza.api.v1;

const log: Logger = new Logger({
    minLevel: process.env.LOG_LEVEL as TLogLevelName,
});
const ID_DELIM = '--';

const statusQuery = defineQuery('getOrderStatus');

// This demo was built to run everything on localhost. If you need or want to
// run it on Cloud, here's a sample connection configuration:
/*
import fs from 'fs';
const certPath = '/Users/fitz/src/andr-fitzgibbon.pem';
const keyPath = '/Users/fitz/src/andr-fitzgibbon.key';
const cloudAddr = 'andr-fitzgibbon.temporal-dev.tmprl.cloud';

const CLOUD_CONNECTION_OPTS = {
    address: cloudAddr,
    tls: {
        clientCertPair: {
            crt: fs.readFileSync(certPath),
            key: fs.readFileSync(keyPath),
        },
    },
};
*/

const tmplHost: string = !process.env.TEMPORAL_HOST ? "localhost" : process.env.TEMPORAL_HOST;
const tmplPort: string = !process.env.TEMPORAL_PORT ? "7233" : process.env.TEMPORAL_PORT;
const LOCAL_CONNECTION_OPTS = {
    address: tmplHost + ":" + tmplPort,
};

const CONNECTION_OPTS = LOCAL_CONNECTION_OPTS;
const NAMESPACE = "default";

log.info(`Sending Temporal requests to ${CONNECTION_OPTS.address} in namespace ${NAMESPACE}`);

const app = express();
app.use(bodyParser.json());
app.use(cors());

app.post('/orderPizza', async (req: Request, res: Response) => {
    const order: p.PizzaOrderInfo = p.PizzaOrderInfo.create(req.body);
    log.info('Got a new order request: ', order);
    let response = await orderPizza(order);
    res.json(response.toJSON());
});

app.post('/orderStatus', async (req: Request, res: Response) => {
    const order: p.PizzaOrderStatus = p.PizzaOrderStatus.create(req.body);
    log.info('Order status request: ', order);
    let response = await orderStatus(order);
    res.json(response.toJSON());
});

const orderPizza = async (order: p.PizzaOrderInfo) => {
    const connection = await Connection.connect(CONNECTION_OPTS);
    const client = new WorkflowClient({connection, namespace: NAMESPACE});

    // append uuid to client-requested id to ensure unique workflow
    const id = order.id + ID_DELIM + uuidv4();
    order.id = id;

    let wf = await client.start('PizzaWorkflow', {
        args: [order],
        taskQueue: 'gopherpizza',
        workflowId: id,
    });

    const stat: p.PizzaOrderStatus = p.PizzaOrderStatus.create({
        status: p.OrderStatus.ORDER_RECEIVED,
        order: order,
        runId: wf.firstExecutionRunId
    });
    return stat;
}

const orderStatus = async (order: p.PizzaOrderStatus) => {
    const connection = await Connection.connect(CONNECTION_OPTS);
    const client = new WorkflowClient({
        connection, namespace: NAMESPACE, dataConverter: {
            payloadConverterPath: require.resolve('./protos/payload-converter')
        }
    });

    if (order.order == null) {
        return p.PizzaOrderStatus.create({
            status: p.OrderStatus.ORDER_UNKNOWN,
        });
    }
    const wf = client.getHandle(order.order!.id as string, order.runId);
    try {
        const status = await wf.query<p.PizzaOrderStatus>(statusQuery);

        return status;
    } catch (e) {
        order.status = p.OrderStatus.ORDER_UNKNOWN;
        return order;
    }
}

const end = (s: NodeJS.Signals) => {
    log.debug(`Caught signal ${s}. Exiting.`);
    process.exit(0);
};

process.once('SIGINT', end);
process.once('SIGTERM', end);

const PORT = process.env.PORT || 8000;
log.debug('Server listening on port', PORT);
app.listen(PORT);
