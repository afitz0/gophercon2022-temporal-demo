"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.payloadConverter = void 0;
const protobufs_1 = require("@temporalio/common/lib/protobufs");
const root_1 = __importDefault(require("./root"));
exports.payloadConverter = new protobufs_1.DefaultPayloadConverterWithProtobufs({ protobufRoot: root_1.default });
//export const payloadConverter = new ProtobufJsonPayloadConverter();
/* OLD, when I was hand writting. How silly of me.

import {CompositePayloadConverter, UndefinedPayloadConverter} from '@temporalio/common';
import {PizzaOrderStatusPayloadConverter} from './pbConverter';

export const payloadConverter = new CompositePayloadConverter(
    new UndefinedPayloadConverter(),
    new PizzaOrderStatusPayloadConverter(),
);
*/
