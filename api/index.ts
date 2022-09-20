"use strict";

import express, {Request, Response} from 'express';
import bodyParser from 'body-parser';
import fs from 'fs';
import {v4 as uuidv4} from 'uuid';

import {Connection, WorkflowClient} from "@temporalio/client";
import { defineQuery } from "@temporalio/workflow";

const certPath = '/Users/fitz/src/andr-fitzgibbon.pem';
const keyPath = '/Users/fitz/src/andr-fitzgibbon.key';

const statusQuery = defineQuery('getBuildStatus');

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

interface StatusQueryResult {
    currentStage: string,
    isDone: boolean,
}

const app = express();
app.use(bodyParser.json());

app.get('/listWorkflows', async (req: Request, res: Response) => {
    let response = await checkWorkflows();
    res.json(response)
});

app.post('/startBuild', async (req: Request, res: Response) => {
    const params = req.body;

    const run = await startBuild();
    res.json({
        'runId': run.firstExecutionRunId,
        'workflowId': run.workflowId,
    });
});

app.get('/workflowStatus/:workflowId/:runId', async (req: Request, res: Response) => {
    const runId = req.params['runId'];
    const workflowId = req.params['workflowId'];
    const status = await workflowStatus(workflowId, runId);

    res.json(status);
});

const checkWorkflows = async () => {
    const connection = await Connection.connect(CONNECTION_OPTS);
    const client = new WorkflowClient({connection, namespace: NAMESPACE});

    let r = new Promise((resolve, reject) => {
        client.workflowService.listOpenWorkflowExecutions({
            namespace: NAMESPACE,
        }, (err, resp) => {
            if (err === null) {
                resolve(resp);
            } else {
                reject(err);
            }
        });
    });

    return r;
};

const startBuild = async () => {
    const connection = await Connection.connect(CONNECTION_OPTS);
    const client = new WorkflowClient({connection, namespace: NAMESPACE});
    const id = uuidv4();

    return client.start('BuildFullCar', {
        taskQueue: 'CAR_FACTORY_QUEUE',
        workflowId: 'build-car-' + id,
    });
};

const workflowStatus = async (workflowId: string, runId: string): Promise<StatusQueryResult> => {
    const connection = await Connection.connect(CONNECTION_OPTS);
    const client = new WorkflowClient({connection, namespace: NAMESPACE});

    const wf = client.getHandle(workflowId, runId);
    const status = await wf.query<StatusQueryResult>(statusQuery);

    return status;
};

const PORT = process.env.PORT || 8000;
app.listen(PORT);
