import {DefaultPayloadConverterWithProtobufs} from '@temporalio/common/lib/protobufs';
import root from './root';

export const payloadConverter = new DefaultPayloadConverterWithProtobufs({protobufRoot: root});
//export const payloadConverter = new ProtobufJsonPayloadConverter();

/* OLD, when I was hand writting. How silly of me. 

import {CompositePayloadConverter, UndefinedPayloadConverter} from '@temporalio/common';
import {PizzaOrderStatusPayloadConverter} from './pbConverter';

export const payloadConverter = new CompositePayloadConverter(
    new UndefinedPayloadConverter(),
    new PizzaOrderStatusPayloadConverter(),
);
*/
