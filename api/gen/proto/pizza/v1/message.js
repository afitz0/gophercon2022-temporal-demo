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
exports.PizzaOrderStatus = exports.PizzaOrderInfo = exports.orderStatusToJSON = exports.orderStatusFromJSON = exports.OrderStatus = exports.cheeseToJSON = exports.cheeseFromJSON = exports.Cheese = exports.crustToJSON = exports.crustFromJSON = exports.Crust = exports.protobufPackage = void 0;
/* eslint-disable */
const _m0 = __importStar(require("protobufjs/minimal"));
exports.protobufPackage = "gopherpizza.pizza.api.v1";
var Crust;
(function (Crust) {
    Crust[Crust["CRUST_NORMAL"] = 0] = "CRUST_NORMAL";
    Crust[Crust["CRUST_THIN"] = 1] = "CRUST_THIN";
    Crust[Crust["CRUST_GARLIC"] = 2] = "CRUST_GARLIC";
    Crust[Crust["CRUST_STUFFED"] = 3] = "CRUST_STUFFED";
    Crust[Crust["CRUST_GLUTEN_FREE"] = 4] = "CRUST_GLUTEN_FREE";
    Crust[Crust["CRUST_PRETZEL"] = 5] = "CRUST_PRETZEL";
    Crust[Crust["UNRECOGNIZED"] = -1] = "UNRECOGNIZED";
})(Crust = exports.Crust || (exports.Crust = {}));
function crustFromJSON(object) {
    switch (object) {
        case 0:
        case "CRUST_NORMAL":
            return Crust.CRUST_NORMAL;
        case 1:
        case "CRUST_THIN":
            return Crust.CRUST_THIN;
        case 2:
        case "CRUST_GARLIC":
            return Crust.CRUST_GARLIC;
        case 3:
        case "CRUST_STUFFED":
            return Crust.CRUST_STUFFED;
        case 4:
        case "CRUST_GLUTEN_FREE":
            return Crust.CRUST_GLUTEN_FREE;
        case 5:
        case "CRUST_PRETZEL":
            return Crust.CRUST_PRETZEL;
        case -1:
        case "UNRECOGNIZED":
        default:
            return Crust.UNRECOGNIZED;
    }
}
exports.crustFromJSON = crustFromJSON;
function crustToJSON(object) {
    switch (object) {
        case Crust.CRUST_NORMAL:
            return "CRUST_NORMAL";
        case Crust.CRUST_THIN:
            return "CRUST_THIN";
        case Crust.CRUST_GARLIC:
            return "CRUST_GARLIC";
        case Crust.CRUST_STUFFED:
            return "CRUST_STUFFED";
        case Crust.CRUST_GLUTEN_FREE:
            return "CRUST_GLUTEN_FREE";
        case Crust.CRUST_PRETZEL:
            return "CRUST_PRETZEL";
        case Crust.UNRECOGNIZED:
        default:
            return "UNRECOGNIZED";
    }
}
exports.crustToJSON = crustToJSON;
var Cheese;
(function (Cheese) {
    Cheese[Cheese["CHEESE_MOZZARELLA"] = 0] = "CHEESE_MOZZARELLA";
    Cheese[Cheese["CHEESE_CHEDDAR"] = 1] = "CHEESE_CHEDDAR";
    Cheese[Cheese["CHEESE_NONE"] = 2] = "CHEESE_NONE";
    Cheese[Cheese["CHEESE_ALL"] = 3] = "CHEESE_ALL";
    Cheese[Cheese["UNRECOGNIZED"] = -1] = "UNRECOGNIZED";
})(Cheese = exports.Cheese || (exports.Cheese = {}));
function cheeseFromJSON(object) {
    switch (object) {
        case 0:
        case "CHEESE_MOZZARELLA":
            return Cheese.CHEESE_MOZZARELLA;
        case 1:
        case "CHEESE_CHEDDAR":
            return Cheese.CHEESE_CHEDDAR;
        case 2:
        case "CHEESE_NONE":
            return Cheese.CHEESE_NONE;
        case 3:
        case "CHEESE_ALL":
            return Cheese.CHEESE_ALL;
        case -1:
        case "UNRECOGNIZED":
        default:
            return Cheese.UNRECOGNIZED;
    }
}
exports.cheeseFromJSON = cheeseFromJSON;
function cheeseToJSON(object) {
    switch (object) {
        case Cheese.CHEESE_MOZZARELLA:
            return "CHEESE_MOZZARELLA";
        case Cheese.CHEESE_CHEDDAR:
            return "CHEESE_CHEDDAR";
        case Cheese.CHEESE_NONE:
            return "CHEESE_NONE";
        case Cheese.CHEESE_ALL:
            return "CHEESE_ALL";
        case Cheese.UNRECOGNIZED:
        default:
            return "UNRECOGNIZED";
    }
}
exports.cheeseToJSON = cheeseToJSON;
var OrderStatus;
(function (OrderStatus) {
    OrderStatus[OrderStatus["ORDER_RECEIVED"] = 0] = "ORDER_RECEIVED";
    OrderStatus[OrderStatus["ORDER_PREPARING"] = 1] = "ORDER_PREPARING";
    OrderStatus[OrderStatus["ORDER_BAKING"] = 2] = "ORDER_BAKING";
    OrderStatus[OrderStatus["ORDER_PENDING_PICKUP"] = 3] = "ORDER_PENDING_PICKUP";
    OrderStatus[OrderStatus["ORDER_OUT_FOR_DELIVERY"] = 4] = "ORDER_OUT_FOR_DELIVERY";
    OrderStatus[OrderStatus["ORDER_DELIVERED"] = 5] = "ORDER_DELIVERED";
    OrderStatus[OrderStatus["UNRECOGNIZED"] = -1] = "UNRECOGNIZED";
})(OrderStatus = exports.OrderStatus || (exports.OrderStatus = {}));
function orderStatusFromJSON(object) {
    switch (object) {
        case 0:
        case "ORDER_RECEIVED":
            return OrderStatus.ORDER_RECEIVED;
        case 1:
        case "ORDER_PREPARING":
            return OrderStatus.ORDER_PREPARING;
        case 2:
        case "ORDER_BAKING":
            return OrderStatus.ORDER_BAKING;
        case 3:
        case "ORDER_PENDING_PICKUP":
            return OrderStatus.ORDER_PENDING_PICKUP;
        case 4:
        case "ORDER_OUT_FOR_DELIVERY":
            return OrderStatus.ORDER_OUT_FOR_DELIVERY;
        case 5:
        case "ORDER_DELIVERED":
            return OrderStatus.ORDER_DELIVERED;
        case -1:
        case "UNRECOGNIZED":
        default:
            return OrderStatus.UNRECOGNIZED;
    }
}
exports.orderStatusFromJSON = orderStatusFromJSON;
function orderStatusToJSON(object) {
    switch (object) {
        case OrderStatus.ORDER_RECEIVED:
            return "ORDER_RECEIVED";
        case OrderStatus.ORDER_PREPARING:
            return "ORDER_PREPARING";
        case OrderStatus.ORDER_BAKING:
            return "ORDER_BAKING";
        case OrderStatus.ORDER_PENDING_PICKUP:
            return "ORDER_PENDING_PICKUP";
        case OrderStatus.ORDER_OUT_FOR_DELIVERY:
            return "ORDER_OUT_FOR_DELIVERY";
        case OrderStatus.ORDER_DELIVERED:
            return "ORDER_DELIVERED";
        case OrderStatus.UNRECOGNIZED:
        default:
            return "UNRECOGNIZED";
    }
}
exports.orderStatusToJSON = orderStatusToJSON;
function createBasePizzaOrderInfo() {
    return { id: "", crust: 0, cheese: 0, toppings: [] };
}
exports.PizzaOrderInfo = {
    encode(message, writer = _m0.Writer.create()) {
        if (message.id !== "") {
            writer.uint32(10).string(message.id);
        }
        if (message.crust !== 0) {
            writer.uint32(16).int32(message.crust);
        }
        if (message.cheese !== 0) {
            writer.uint32(24).int32(message.cheese);
        }
        for (const v of message.toppings) {
            writer.uint32(34).string(v);
        }
        return writer;
    },
    decode(input, length) {
        const reader = input instanceof _m0.Reader ? input : new _m0.Reader(input);
        let end = length === undefined ? reader.len : reader.pos + length;
        const message = createBasePizzaOrderInfo();
        while (reader.pos < end) {
            const tag = reader.uint32();
            switch (tag >>> 3) {
                case 1:
                    message.id = reader.string();
                    break;
                case 2:
                    message.crust = reader.int32();
                    break;
                case 3:
                    message.cheese = reader.int32();
                    break;
                case 4:
                    message.toppings.push(reader.string());
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
            }
        }
        return message;
    },
    fromJSON(object) {
        return {
            id: isSet(object.id) ? String(object.id) : "",
            crust: isSet(object.crust) ? crustFromJSON(object.crust) : 0,
            cheese: isSet(object.cheese) ? cheeseFromJSON(object.cheese) : 0,
            toppings: Array.isArray(object?.toppings) ? object.toppings.map((e) => String(e)) : [],
        };
    },
    toJSON(message) {
        const obj = {};
        message.id !== undefined && (obj.id = message.id);
        message.crust !== undefined && (obj.crust = crustToJSON(message.crust));
        message.cheese !== undefined && (obj.cheese = cheeseToJSON(message.cheese));
        if (message.toppings) {
            obj.toppings = message.toppings.map((e) => e);
        }
        else {
            obj.toppings = [];
        }
        return obj;
    },
    fromPartial(object) {
        const message = createBasePizzaOrderInfo();
        message.id = object.id ?? "";
        message.crust = object.crust ?? 0;
        message.cheese = object.cheese ?? 0;
        message.toppings = object.toppings?.map((e) => e) || [];
        return message;
    },
};
function createBasePizzaOrderStatus() {
    return { status: 0, order: undefined, runId: "" };
}
exports.PizzaOrderStatus = {
    encode(message, writer = _m0.Writer.create()) {
        if (message.status !== 0) {
            writer.uint32(8).int32(message.status);
        }
        if (message.order !== undefined) {
            exports.PizzaOrderInfo.encode(message.order, writer.uint32(18).fork()).ldelim();
        }
        if (message.runId !== "") {
            writer.uint32(26).string(message.runId);
        }
        return writer;
    },
    decode(input, length) {
        const reader = input instanceof _m0.Reader ? input : new _m0.Reader(input);
        let end = length === undefined ? reader.len : reader.pos + length;
        const message = createBasePizzaOrderStatus();
        while (reader.pos < end) {
            const tag = reader.uint32();
            switch (tag >>> 3) {
                case 1:
                    message.status = reader.int32();
                    break;
                case 2:
                    message.order = exports.PizzaOrderInfo.decode(reader, reader.uint32());
                    break;
                case 3:
                    message.runId = reader.string();
                    break;
                default:
                    reader.skipType(tag & 7);
                    break;
            }
        }
        return message;
    },
    fromJSON(object) {
        return {
            status: isSet(object.status) ? orderStatusFromJSON(object.status) : 0,
            order: isSet(object.order) ? exports.PizzaOrderInfo.fromJSON(object.order) : undefined,
            runId: isSet(object.runId) ? String(object.runId) : "",
        };
    },
    toJSON(message) {
        const obj = {};
        message.status !== undefined && (obj.status = orderStatusToJSON(message.status));
        message.order !== undefined && (obj.order = message.order ? exports.PizzaOrderInfo.toJSON(message.order) : undefined);
        message.runId !== undefined && (obj.runId = message.runId);
        return obj;
    },
    fromPartial(object) {
        const message = createBasePizzaOrderStatus();
        message.status = object.status ?? 0;
        message.order = (object.order !== undefined && object.order !== null)
            ? exports.PizzaOrderInfo.fromPartial(object.order)
            : undefined;
        message.runId = object.runId ?? "";
        return message;
    },
};
function isSet(value) {
    return value !== null && value !== undefined;
}
