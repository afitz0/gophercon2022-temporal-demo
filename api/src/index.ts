"use strict";

import express, {Request, Response} from 'express';
import bodyParser from 'body-parser';
import fs from 'fs';
import {v4 as uuidv4} from 'uuid';

import {Connection, WorkflowClient} from "@temporalio/client";
import {defineQuery} from "@temporalio/workflow";

//import {PizzaOrderInfo, PizzaOrderStatus, OrderStatus} from './root';
import gopherpizza from './protos/root';
import p = gopherpizza.gopherpizza.pizza.api.v1;

//import * as pizza from './gen/proto/pizza/v1/message';

const ID_DELIM = '--';

const certPath = '/Users/fitz/src/andr-fitzgibbon.pem';
const keyPath = '/Users/fitz/src/andr-fitzgibbon.key';

const statusQuery = defineQuery('getOrderStatus');

const CLOUD_CONNECTION_OPTS = {
    address: "andr-fitzgibbon.temporal-dev.tmprl.cloud",
    tls: {
        clientCertPair: {
            crt: fs.readFileSync(certPath),
            key: fs.readFileSync(keyPath),
        },
    },
};

const LOCAL_CONNECTION_OPTS = {
    address: "127.0.0.1:7233"
};

const CONNECTION_OPTS = LOCAL_CONNECTION_OPTS;
const NAMESPACE = CONNECTION_OPTS === CLOUD_CONNECTION_OPTS ? "andr-fitzgibbon.temporal-dev" : "default";

const app = express();
app.use(bodyParser.json());

app.post('/orderPizza', async (req: Request, res: Response) => {
    const order: p.PizzaOrderInfo = p.PizzaOrderInfo.create(req.body);
    //const order = pizza.PizzaOrderInfo.fromJSON(req.body);
    let response = await orderPizza(order);
    res.json(response.toJSON());
});

app.post('/orderStatus', async (req: Request, res: Response) => {
    const order: p.PizzaOrderStatus = p.PizzaOrderStatus.create(req.body);
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

    // TODO: input validation of given order status
    const wf = client.getHandle(order.order!.id as string, order.runId);
    const status = await wf.query<p.PizzaOrderStatus>(statusQuery);

    return status;
}

const PORT = process.env.PORT || 8000;
app.listen(PORT);
