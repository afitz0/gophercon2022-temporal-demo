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
const certPath = '/Users/fitz/src/andr-fitzgibbon.pem';
const keyPath = '/Users/fitz/src/andr-fitzgibbon.key';
const statusQuery = (0, workflow_1.defineQuery)('getBuildStatus');
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
app.get('/listWorkflows', async (req, res) => {
    let response = await checkWorkflows();
    res.json(response);
});
app.post('/startBuild', async (req, res) => {
    const params = req.body;
    console.log(JSON.stringify(params));
    const run = await startBuild();
    res.json({
        'runId': run.firstExecutionRunId,
        'workflowId': run.workflowId,
    });
});
app.get('/workflowStatus/:workflowId/:runId', async (req, res) => {
    const runId = req.params['runId'];
    const workflowId = req.params['workflowId'];
    const status = await workflowStatus(workflowId, runId);
    res.json(status);
});
const checkWorkflows = async () => {
    const connection = await client_1.Connection.connect(CONNECTION_OPTS);
    const client = new client_1.WorkflowClient({ connection, namespace: NAMESPACE });
    let r = new Promise((resolve, reject) => {
        client.workflowService.listOpenWorkflowExecutions({
            namespace: NAMESPACE,
        }, (err, resp) => {
            if (err === null) {
                resolve(resp);
            }
            else {
                reject(err);
            }
        });
    });
    return r;
};
const startBuild = async () => {
    const connection = await client_1.Connection.connect(CONNECTION_OPTS);
    const client = new client_1.WorkflowClient({ connection, namespace: NAMESPACE });
    const id = (0, uuid_1.v4)();
    return client.start('BuildFullCar', {
        taskQueue: 'CAR_FACTORY_QUEUE',
        workflowId: 'build-car-' + id,
    });
};
const workflowStatus = async (workflowId, runId) => {
    const connection = await client_1.Connection.connect(CONNECTION_OPTS);
    const client = new client_1.WorkflowClient({ connection, namespace: NAMESPACE });
    const wf = client.getHandle(workflowId, runId);
    const status = await wf.query(statusQuery);
    const rawStatus = JSON.parse(status);
    return rawStatus;
};
const PORT = process.env.PORT || 8000;
app.listen(PORT);
