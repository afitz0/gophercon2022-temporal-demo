/* eslint-disable */
import * as _m0 from "protobufjs/minimal";

export const protobufPackage = "gopherpizza.pizza.api.v1";

export enum Crust {
  CRUST_NORMAL = 0,
  CRUST_THIN = 1,
  CRUST_GARLIC = 2,
  CRUST_STUFFED = 3,
  CRUST_GLUTEN_FREE = 4,
  CRUST_PRETZEL = 5,
  UNRECOGNIZED = -1,
}

export function crustFromJSON(object: any): Crust {
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

export function crustToJSON(object: Crust): string {
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

export enum Cheese {
  CHEESE_MOZZARELLA = 0,
  CHEESE_CHEDDAR = 1,
  CHEESE_NONE = 2,
  CHEESE_ALL = 3,
  UNRECOGNIZED = -1,
}

export function cheeseFromJSON(object: any): Cheese {
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

export function cheeseToJSON(object: Cheese): string {
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

export enum OrderStatus {
  ORDER_RECEIVED = 0,
  ORDER_PREPARING = 1,
  ORDER_BAKING = 2,
  ORDER_PENDING_PICKUP = 3,
  ORDER_OUT_FOR_DELIVERY = 4,
  ORDER_DELIVERED = 5,
  UNRECOGNIZED = -1,
}

export function orderStatusFromJSON(object: any): OrderStatus {
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

export function orderStatusToJSON(object: OrderStatus): string {
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

export interface PizzaOrderInfo {
  id: string;
  crust: Crust;
  cheese: Cheese;
  toppings: string[];
}

export interface PizzaOrderStatus {
  status: OrderStatus;
  order: PizzaOrderInfo | undefined;
  runId: string;
}

function createBasePizzaOrderInfo(): PizzaOrderInfo {
  return { id: "", crust: 0, cheese: 0, toppings: [] };
}

export const PizzaOrderInfo = {
  encode(message: PizzaOrderInfo, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
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
      writer.uint32(34).string(v!);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): PizzaOrderInfo {
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
          message.crust = reader.int32() as any;
          break;
        case 3:
          message.cheese = reader.int32() as any;
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

  fromJSON(object: any): PizzaOrderInfo {
    return {
      id: isSet(object.id) ? String(object.id) : "",
      crust: isSet(object.crust) ? crustFromJSON(object.crust) : 0,
      cheese: isSet(object.cheese) ? cheeseFromJSON(object.cheese) : 0,
      toppings: Array.isArray(object?.toppings) ? object.toppings.map((e: any) => String(e)) : [],
    };
  },

  toJSON(message: PizzaOrderInfo): unknown {
    const obj: any = {};
    message.id !== undefined && (obj.id = message.id);
    message.crust !== undefined && (obj.crust = crustToJSON(message.crust));
    message.cheese !== undefined && (obj.cheese = cheeseToJSON(message.cheese));
    if (message.toppings) {
      obj.toppings = message.toppings.map((e) => e);
    } else {
      obj.toppings = [];
    }
    return obj;
  },

  fromPartial<I extends Exact<DeepPartial<PizzaOrderInfo>, I>>(object: I): PizzaOrderInfo {
    const message = createBasePizzaOrderInfo();
    message.id = object.id ?? "";
    message.crust = object.crust ?? 0;
    message.cheese = object.cheese ?? 0;
    message.toppings = object.toppings?.map((e) => e) || [];
    return message;
  },
};

function createBasePizzaOrderStatus(): PizzaOrderStatus {
  return { status: 0, order: undefined, runId: "" };
}

export const PizzaOrderStatus = {
  encode(message: PizzaOrderStatus, writer: _m0.Writer = _m0.Writer.create()): _m0.Writer {
    if (message.status !== 0) {
      writer.uint32(8).int32(message.status);
    }
    if (message.order !== undefined) {
      PizzaOrderInfo.encode(message.order, writer.uint32(18).fork()).ldelim();
    }
    if (message.runId !== "") {
      writer.uint32(26).string(message.runId);
    }
    return writer;
  },

  decode(input: _m0.Reader | Uint8Array, length?: number): PizzaOrderStatus {
    const reader = input instanceof _m0.Reader ? input : new _m0.Reader(input);
    let end = length === undefined ? reader.len : reader.pos + length;
    const message = createBasePizzaOrderStatus();
    while (reader.pos < end) {
      const tag = reader.uint32();
      switch (tag >>> 3) {
        case 1:
          message.status = reader.int32() as any;
          break;
        case 2:
          message.order = PizzaOrderInfo.decode(reader, reader.uint32());
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

  fromJSON(object: any): PizzaOrderStatus {
    return {
      status: isSet(object.status) ? orderStatusFromJSON(object.status) : 0,
      order: isSet(object.order) ? PizzaOrderInfo.fromJSON(object.order) : undefined,
      runId: isSet(object.runId) ? String(object.runId) : "",
    };
  },

  toJSON(message: PizzaOrderStatus): unknown {
    const obj: any = {};
    message.status !== undefined && (obj.status = orderStatusToJSON(message.status));
    message.order !== undefined && (obj.order = message.order ? PizzaOrderInfo.toJSON(message.order) : undefined);
    message.runId !== undefined && (obj.runId = message.runId);
    return obj;
  },

  fromPartial<I extends Exact<DeepPartial<PizzaOrderStatus>, I>>(object: I): PizzaOrderStatus {
    const message = createBasePizzaOrderStatus();
    message.status = object.status ?? 0;
    message.order = (object.order !== undefined && object.order !== null)
      ? PizzaOrderInfo.fromPartial(object.order)
      : undefined;
    message.runId = object.runId ?? "";
    return message;
  },
};

type Builtin = Date | Function | Uint8Array | string | number | boolean | undefined;

export type DeepPartial<T> = T extends Builtin ? T
  : T extends Array<infer U> ? Array<DeepPartial<U>> : T extends ReadonlyArray<infer U> ? ReadonlyArray<DeepPartial<U>>
  : T extends {} ? { [K in keyof T]?: DeepPartial<T[K]> }
  : Partial<T>;

type KeysOfUnion<T> = T extends T ? keyof T : never;
export type Exact<P, I extends P> = P extends Builtin ? P
  : P & { [K in keyof P]: Exact<P[K], I[K]> } & { [K in Exclude<keyof I, KeysOfUnion<P>>]: never };

function isSet(value: any): boolean {
  return value !== null && value !== undefined;
}
