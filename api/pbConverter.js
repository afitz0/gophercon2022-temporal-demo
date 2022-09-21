"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UnsupportedPizzaOrderStatusTypeError = exports.PizzaOrderStatusPayloadConverter = void 0;
const common_1 = require("@temporalio/common");
const internal_workflow_common_1 = require("@temporalio/internal-workflow-common");
const pizza = __importStar(require("./gen/proto/pizza/v1/message"));
/**
 * Converts between values and PizzaOrderStatus (protobuf) Payloads.
 */
class PizzaOrderStatusPayloadConverter {
    constructor() {
        this.encodingType = 'json/protobuf';
    }
    toPayload(value) {
        if (value === undefined)
            return undefined;
        let data;
        try {
            let json = pizza.PizzaOrderStatus.toJSON(value);
            data = JSON.stringify(json);
        }
        catch (e) {
            throw new UnsupportedPizzaOrderStatusTypeError(`Can't run stringify on this value: ${value}. Either convert it (or its properties) to JSON-serializable values, or create a custom data converter. JSON.stringify error message: ${(0, common_1.errorMessage)(e)}`, e);
        }
        console.log('Converter sending payload: ' + data);
        return {
            metadata: {
                [common_1.METADATA_ENCODING_KEY]: (0, common_1.u8)('json/protobuf'),
                format: (0, common_1.u8)('extended'),
            },
            data: (0, common_1.u8)(data),
        };
    }
    fromPayload(content) {
        console.log('Converter got payload: ' + content.data);
        let d = pizza.PizzaOrderStatus.fromJSON(content.data);
        return content.data ? d : content.data;
    }
}
exports.PizzaOrderStatusPayloadConverter = PizzaOrderStatusPayloadConverter;
class UnsupportedPizzaOrderStatusTypeError extends internal_workflow_common_1.PayloadConverterError {
    constructor(message, cause) {
        super(message ?? undefined);
        this.cause = cause;
        this.name = 'UnsupportedPizzaOrderStatusTypeError';
    }
}
exports.UnsupportedPizzaOrderStatusTypeError = UnsupportedPizzaOrderStatusTypeError;
