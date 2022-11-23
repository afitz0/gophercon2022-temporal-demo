import {DefaultPayloadConverterWithProtobufs} from '@temporalio/common/lib/protobufs';
import root from '../../lib/protos/root';

export const payloadConverter = new DefaultPayloadConverterWithProtobufs({protobufRoot: root});
