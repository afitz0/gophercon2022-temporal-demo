///
//  Generated code. Do not modify.
//  source: proto/pizza/v1/message.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use crustDescriptor instead')
const Crust$json = const {
  '1': 'Crust',
  '2': const [
    const {'1': 'CRUST_NORMAL', '2': 0},
    const {'1': 'CRUST_THIN', '2': 1},
    const {'1': 'CRUST_GARLIC', '2': 2},
    const {'1': 'CRUST_STUFFED', '2': 3},
    const {'1': 'CRUST_GLUTEN_FREE', '2': 4},
    const {'1': 'CRUST_PRETZEL', '2': 5},
  ],
};

/// Descriptor for `Crust`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List crustDescriptor = $convert.base64Decode('CgVDcnVzdBIQCgxDUlVTVF9OT1JNQUwQABIOCgpDUlVTVF9USElOEAESEAoMQ1JVU1RfR0FSTElDEAISEQoNQ1JVU1RfU1RVRkZFRBADEhUKEUNSVVNUX0dMVVRFTl9GUkVFEAQSEQoNQ1JVU1RfUFJFVFpFTBAF');
@$core.Deprecated('Use cheeseDescriptor instead')
const Cheese$json = const {
  '1': 'Cheese',
  '2': const [
    const {'1': 'CHEESE_MOZZARELLA', '2': 0},
    const {'1': 'CHEESE_CHEDDAR', '2': 1},
    const {'1': 'CHEESE_NONE', '2': 2},
    const {'1': 'CHEESE_ALL', '2': 3},
  ],
};

/// Descriptor for `Cheese`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cheeseDescriptor = $convert.base64Decode('CgZDaGVlc2USFQoRQ0hFRVNFX01PWlpBUkVMTEEQABISCg5DSEVFU0VfQ0hFRERBUhABEg8KC0NIRUVTRV9OT05FEAISDgoKQ0hFRVNFX0FMTBAD');
@$core.Deprecated('Use orderStatusDescriptor instead')
const OrderStatus$json = const {
  '1': 'OrderStatus',
  '2': const [
    const {'1': 'ORDER_RECEIVED', '2': 0},
    const {'1': 'ORDER_PREPARING', '2': 1},
    const {'1': 'ORDER_BAKING', '2': 2},
    const {'1': 'ORDER_PENDING_PICKUP', '2': 3},
    const {'1': 'ORDER_OUT_FOR_DELIVERY', '2': 4},
    const {'1': 'ORDER_DELIVERED', '2': 5},
  ],
};

/// Descriptor for `OrderStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List orderStatusDescriptor = $convert.base64Decode('CgtPcmRlclN0YXR1cxISCg5PUkRFUl9SRUNFSVZFRBAAEhMKD09SREVSX1BSRVBBUklORxABEhAKDE9SREVSX0JBS0lORxACEhgKFE9SREVSX1BFTkRJTkdfUElDS1VQEAMSGgoWT1JERVJfT1VUX0ZPUl9ERUxJVkVSWRAEEhMKD09SREVSX0RFTElWRVJFRBAF');
@$core.Deprecated('Use pizzaOrderInfoDescriptor instead')
const PizzaOrderInfo$json = const {
  '1': 'PizzaOrderInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'crust', '3': 2, '4': 1, '5': 14, '6': '.gopherpizza.pizza.api.v1.Crust', '10': 'crust'},
    const {'1': 'cheese', '3': 3, '4': 1, '5': 14, '6': '.gopherpizza.pizza.api.v1.Cheese', '10': 'cheese'},
    const {'1': 'toppings', '3': 4, '4': 3, '5': 9, '10': 'toppings'},
  ],
};

/// Descriptor for `PizzaOrderInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pizzaOrderInfoDescriptor = $convert.base64Decode('Cg5QaXp6YU9yZGVySW5mbxIOCgJpZBgBIAEoCVICaWQSNQoFY3J1c3QYAiABKA4yHy5nb3BoZXJwaXp6YS5waXp6YS5hcGkudjEuQ3J1c3RSBWNydXN0EjgKBmNoZWVzZRgDIAEoDjIgLmdvcGhlcnBpenphLnBpenphLmFwaS52MS5DaGVlc2VSBmNoZWVzZRIaCgh0b3BwaW5ncxgEIAMoCVIIdG9wcGluZ3M=');
@$core.Deprecated('Use pizzaOrderStatusDescriptor instead')
const PizzaOrderStatus$json = const {
  '1': 'PizzaOrderStatus',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.gopherpizza.pizza.api.v1.OrderStatus', '10': 'status'},
    const {'1': 'order', '3': 2, '4': 1, '5': 11, '6': '.gopherpizza.pizza.api.v1.PizzaOrderInfo', '10': 'order'},
    const {'1': 'runId', '3': 3, '4': 1, '5': 9, '10': 'runId'},
  ],
};

/// Descriptor for `PizzaOrderStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pizzaOrderStatusDescriptor = $convert.base64Decode('ChBQaXp6YU9yZGVyU3RhdHVzEj0KBnN0YXR1cxgBIAEoDjIlLmdvcGhlcnBpenphLnBpenphLmFwaS52MS5PcmRlclN0YXR1c1IGc3RhdHVzEj4KBW9yZGVyGAIgASgLMiguZ29waGVycGl6emEucGl6emEuYXBpLnYxLlBpenphT3JkZXJJbmZvUgVvcmRlchIUCgVydW5JZBgDIAEoCVIFcnVuSWQ=');
