import {
    EncodingType,
    errorMessage,
    METADATA_ENCODING_KEY,
    Payload,
    PayloadConverterWithEncoding,
    u8,
} from '@temporalio/common';
import {PayloadConverterError} from '@temporalio/internal-workflow-common';
import * as pizza from './gen/proto/pizza/v1/message';

/**
 * Converts between values and PizzaOrderStatus (protobuf) Payloads.
 */
export class PizzaOrderStatusPayloadConverter implements PayloadConverterWithEncoding {
    public encodingType = 'json/protobuf' as EncodingType;

    public toPayload(value: unknown): Payload | undefined {
        if (value === undefined) return undefined;
        let data;
        try {
            let json = pizza.PizzaOrderStatus.toJSON(value as pizza.PizzaOrderStatus);
            data = JSON.stringify(json);
        } catch (e) {
            throw new UnsupportedPizzaOrderStatusTypeError(
                `Can't run stringify on this value: ${value}. Either convert it (or its properties) to JSON-serializable values, or create a custom data converter. JSON.stringify error message: ${errorMessage(
                    e
                )}`,
                e as Error
            );
        }
        console.log('Converter sending payload: ' + data);

        return {
            metadata: {
                [METADATA_ENCODING_KEY]: u8('json/protobuf'),
                format: u8('extended'),
            },
            data: u8(data),
        };
    }

    public fromPayload<T>(content: Payload): T {
        console.log('Converter got payload: ' + content.data);
        let d = pizza.PizzaOrderStatus.fromJSON(content.data);
        return content.data ? d as any : content.data;
    }
}

export class UnsupportedPizzaOrderStatusTypeError extends PayloadConverterError {
    public readonly name: string = 'UnsupportedPizzaOrderStatusTypeError';

    constructor(message: string | undefined, public readonly cause?: Error) {
        super(message ?? undefined);
    }
}
