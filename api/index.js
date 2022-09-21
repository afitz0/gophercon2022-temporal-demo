"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const body_parser_1 = __importDefault(require("body-parser"));
const fs_1 = __importDefault(require("fs"));
const uuid_1 = require("uuid");
const client_1 = require("@temporalio/client");
const workflow_1 = require("@temporalio/workflow");
//import {PizzaOrderInfo, PizzaOrderStatus, OrderStatus} from './root';
const root_1 = __importDefault(require("./root"));
var p = root_1.default.gopherpizza.pizza.api.v1;
//import * as pizza from './gen/proto/pizza/v1/message';
const ID_DELIM = '--';
const certPath = '/Users/fitz/src/andr-fitzgibbon.pem';
const keyPath = '/Users/fitz/src/andr-fitzgibbon.key';
const statusQuery = (0, workflow_1.defineQuery)('getOrderStatus');
const CLOUD_CONNECTION_OPTS = {
    address: "andr-fitzgibbon.temporal-dev.tmprl.cloud",
    tls: {
        clientCertPair: {
            crt: fs_1.default.readFileSync(certPath),
            key: fs_1.default.readFileSync(keyPath),
        },
    },
};
const LOCAL_CONNECTION_OPTS = {
    address: "127.0.0.1:7233"
};
const CONNECTION_OPTS = LOCAL_CONNECTION_OPTS;
const NAMESPACE = CONNECTION_OPTS === CLOUD_CONNECTION_OPTS ? "andr-fitzgibbon.temporal-dev" : "default";
const app = (0, express_1.default)();
app.use(body_parser_1.default.json());
app.post('/orderPizza', async (req, res) => {
    console.log('Got body request: ' + JSON.stringify(req.body));
    const order = p.PizzaOrderInfo.create(req.body);
    //const order = pizza.PizzaOrderInfo.fromJSON(req.body);
    let response = await orderPizza(order);
    res.json(response.toJSON());
});
app.post('/orderStatus', async (req, res) => {
    const order = p.PizzaOrderStatus.create(req.body);
    let response = await orderStatus(order);
    console.log('Returning order status: ' + response);
    res.json(response.toJSON());
});
const orderPizza = async (order) => {
    console.log('Got order: ' + JSON.stringify(order.toJSON()));
    const connection = await client_1.Connection.connect(CONNECTION_OPTS);
    const client = new client_1.WorkflowClient({ connection, namespace: NAMESPACE });
    // append uuid to client-requested id to ensure unique workflow
    const id = order.id + ID_DELIM + (0, uuid_1.v4)();
    order.id = id;
    let wf = await client.start('PizzaWorkflow', {
        args: [order],
        taskQueue: 'gopherpizza',
        workflowId: id,
    });
    const stat = p.PizzaOrderStatus.create({
        status: p.OrderStatus.ORDER_RECEIVED,
        order: order,
        runId: wf.firstExecutionRunId
    });
    return stat;
};
const orderStatus = async (order) => {
    console.log('Checking status for order: ' + JSON.stringify(order));
    const connection = await client_1.Connection.connect(CONNECTION_OPTS);
    const client = new client_1.WorkflowClient({
        connection, namespace: NAMESPACE, dataConverter: {
            payloadConverterPath: require.resolve('./payload-converter')
        }
    });
    // TODO: input validation of given order status
    const wf = client.getHandle(order.order.id, order.runId);
    const status = await wf.query(statusQuery);
    console.log('Got status back from workflow: ' + status);
    console.log('(stringified): ' + JSON.stringify(status));
    return status;
};
const PORT = process.env.PORT || 8000;
app.listen(PORT);
