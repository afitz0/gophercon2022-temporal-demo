const {patchProtobufRoot} = require('@temporalio/proto/lib/patch-protobuf-root');
const unpatchedRoot = require('./json-module');
module.exports = patchProtobufRoot(unpatchedRoot);