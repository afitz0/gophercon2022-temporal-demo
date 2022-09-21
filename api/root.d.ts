import * as $protobuf from "protobufjs";
/** Namespace gopherpizza. */
export namespace gopherpizza {

    /** Namespace pizza. */
    namespace pizza {

        /** Namespace api. */
        namespace api {

            /** Namespace v1. */
            namespace v1 {

                /** Crust enum. */
                enum Crust {
                    CRUST_NORMAL = 0,
                    CRUST_THIN = 1,
                    CRUST_GARLIC = 2,
                    CRUST_STUFFED = 3,
                    CRUST_GLUTEN_FREE = 4,
                    CRUST_PRETZEL = 5
                }

                /** Cheese enum. */
                enum Cheese {
                    CHEESE_MOZZARELLA = 0,
                    CHEESE_CHEDDAR = 1,
                    CHEESE_NONE = 2,
                    CHEESE_ALL = 3
                }

                /** OrderStatus enum. */
                enum OrderStatus {
                    ORDER_RECEIVED = 0,
                    ORDER_PREPARING = 1,
                    ORDER_BAKING = 2,
                    ORDER_PENDING_PICKUP = 3,
                    ORDER_OUT_FOR_DELIVERY = 4,
                    ORDER_DELIVERED = 5
                }

                /** Properties of a PizzaOrderInfo. */
                interface IPizzaOrderInfo {

                    /** PizzaOrderInfo id */
                    id?: (string|null);

                    /** PizzaOrderInfo crust */
                    crust?: (gopherpizza.pizza.api.v1.Crust|null);

                    /** PizzaOrderInfo cheese */
                    cheese?: (gopherpizza.pizza.api.v1.Cheese|null);

                    /** PizzaOrderInfo toppings */
                    toppings?: (string[]|null);
                }

                /** Represents a PizzaOrderInfo. */
                class PizzaOrderInfo implements IPizzaOrderInfo {

                    /**
                     * Constructs a new PizzaOrderInfo.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: gopherpizza.pizza.api.v1.IPizzaOrderInfo);

                    /** PizzaOrderInfo id. */
                    public id: string;

                    /** PizzaOrderInfo crust. */
                    public crust: gopherpizza.pizza.api.v1.Crust;

                    /** PizzaOrderInfo cheese. */
                    public cheese: gopherpizza.pizza.api.v1.Cheese;

                    /** PizzaOrderInfo toppings. */
                    public toppings: string[];

                    /**
                     * Creates a new PizzaOrderInfo instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns PizzaOrderInfo instance
                     */
                    public static create(properties?: gopherpizza.pizza.api.v1.IPizzaOrderInfo): gopherpizza.pizza.api.v1.PizzaOrderInfo;

                    /**
                     * Encodes the specified PizzaOrderInfo message. Does not implicitly {@link gopherpizza.pizza.api.v1.PizzaOrderInfo.verify|verify} messages.
                     * @param message PizzaOrderInfo message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: gopherpizza.pizza.api.v1.IPizzaOrderInfo, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified PizzaOrderInfo message, length delimited. Does not implicitly {@link gopherpizza.pizza.api.v1.PizzaOrderInfo.verify|verify} messages.
                     * @param message PizzaOrderInfo message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: gopherpizza.pizza.api.v1.IPizzaOrderInfo, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes a PizzaOrderInfo message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns PizzaOrderInfo
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): gopherpizza.pizza.api.v1.PizzaOrderInfo;

                    /**
                     * Decodes a PizzaOrderInfo message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns PizzaOrderInfo
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): gopherpizza.pizza.api.v1.PizzaOrderInfo;

                    /**
                     * Verifies a PizzaOrderInfo message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates a PizzaOrderInfo message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns PizzaOrderInfo
                     */
                    public static fromObject(object: { [k: string]: any }): gopherpizza.pizza.api.v1.PizzaOrderInfo;

                    /**
                     * Creates a plain object from a PizzaOrderInfo message. Also converts values to other types if specified.
                     * @param message PizzaOrderInfo
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: gopherpizza.pizza.api.v1.PizzaOrderInfo, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this PizzaOrderInfo to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }

                /** Properties of a PizzaOrderStatus. */
                interface IPizzaOrderStatus {

                    /** PizzaOrderStatus status */
                    status?: (gopherpizza.pizza.api.v1.OrderStatus|null);

                    /** PizzaOrderStatus order */
                    order?: (gopherpizza.pizza.api.v1.IPizzaOrderInfo|null);

                    /** PizzaOrderStatus runId */
                    runId?: (string|null);
                }

                /** Represents a PizzaOrderStatus. */
                class PizzaOrderStatus implements IPizzaOrderStatus {

                    /**
                     * Constructs a new PizzaOrderStatus.
                     * @param [properties] Properties to set
                     */
                    constructor(properties?: gopherpizza.pizza.api.v1.IPizzaOrderStatus);

                    /** PizzaOrderStatus status. */
                    public status: gopherpizza.pizza.api.v1.OrderStatus;

                    /** PizzaOrderStatus order. */
                    public order?: (gopherpizza.pizza.api.v1.IPizzaOrderInfo|null);

                    /** PizzaOrderStatus runId. */
                    public runId: string;

                    /**
                     * Creates a new PizzaOrderStatus instance using the specified properties.
                     * @param [properties] Properties to set
                     * @returns PizzaOrderStatus instance
                     */
                    public static create(properties?: gopherpizza.pizza.api.v1.IPizzaOrderStatus): gopherpizza.pizza.api.v1.PizzaOrderStatus;

                    /**
                     * Encodes the specified PizzaOrderStatus message. Does not implicitly {@link gopherpizza.pizza.api.v1.PizzaOrderStatus.verify|verify} messages.
                     * @param message PizzaOrderStatus message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encode(message: gopherpizza.pizza.api.v1.IPizzaOrderStatus, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Encodes the specified PizzaOrderStatus message, length delimited. Does not implicitly {@link gopherpizza.pizza.api.v1.PizzaOrderStatus.verify|verify} messages.
                     * @param message PizzaOrderStatus message or plain object to encode
                     * @param [writer] Writer to encode to
                     * @returns Writer
                     */
                    public static encodeDelimited(message: gopherpizza.pizza.api.v1.IPizzaOrderStatus, writer?: $protobuf.Writer): $protobuf.Writer;

                    /**
                     * Decodes a PizzaOrderStatus message from the specified reader or buffer.
                     * @param reader Reader or buffer to decode from
                     * @param [length] Message length if known beforehand
                     * @returns PizzaOrderStatus
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decode(reader: ($protobuf.Reader|Uint8Array), length?: number): gopherpizza.pizza.api.v1.PizzaOrderStatus;

                    /**
                     * Decodes a PizzaOrderStatus message from the specified reader or buffer, length delimited.
                     * @param reader Reader or buffer to decode from
                     * @returns PizzaOrderStatus
                     * @throws {Error} If the payload is not a reader or valid buffer
                     * @throws {$protobuf.util.ProtocolError} If required fields are missing
                     */
                    public static decodeDelimited(reader: ($protobuf.Reader|Uint8Array)): gopherpizza.pizza.api.v1.PizzaOrderStatus;

                    /**
                     * Verifies a PizzaOrderStatus message.
                     * @param message Plain object to verify
                     * @returns `null` if valid, otherwise the reason why it is not
                     */
                    public static verify(message: { [k: string]: any }): (string|null);

                    /**
                     * Creates a PizzaOrderStatus message from a plain object. Also converts values to their respective internal types.
                     * @param object Plain object
                     * @returns PizzaOrderStatus
                     */
                    public static fromObject(object: { [k: string]: any }): gopherpizza.pizza.api.v1.PizzaOrderStatus;

                    /**
                     * Creates a plain object from a PizzaOrderStatus message. Also converts values to other types if specified.
                     * @param message PizzaOrderStatus
                     * @param [options] Conversion options
                     * @returns Plain object
                     */
                    public static toObject(message: gopherpizza.pizza.api.v1.PizzaOrderStatus, options?: $protobuf.IConversionOptions): { [k: string]: any };

                    /**
                     * Converts this PizzaOrderStatus to JSON.
                     * @returns JSON object
                     */
                    public toJSON(): { [k: string]: any };
                }
            }
        }
    }
}
