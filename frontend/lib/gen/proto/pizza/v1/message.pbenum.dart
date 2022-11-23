///
//  Generated code. Do not modify.
//  source: proto/pizza/v1/message.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Crust extends $pb.ProtobufEnum {
  static const Crust CRUST_NORMAL = Crust._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRUST_NORMAL');
  static const Crust CRUST_THIN = Crust._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRUST_THIN');
  static const Crust CRUST_GARLIC = Crust._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRUST_GARLIC');
  static const Crust CRUST_STUFFED = Crust._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRUST_STUFFED');
  static const Crust CRUST_GLUTEN_FREE = Crust._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRUST_GLUTEN_FREE');
  static const Crust CRUST_PRETZEL = Crust._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CRUST_PRETZEL');

  static const $core.List<Crust> values = <Crust> [
    CRUST_NORMAL,
    CRUST_THIN,
    CRUST_GARLIC,
    CRUST_STUFFED,
    CRUST_GLUTEN_FREE,
    CRUST_PRETZEL,
  ];

  static final $core.Map<$core.int, Crust> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Crust? valueOf($core.int value) => _byValue[value];

  const Crust._($core.int v, $core.String n) : super(v, n);
}

class Cheese extends $pb.ProtobufEnum {
  static const Cheese CHEESE_MOZZARELLA = Cheese._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CHEESE_MOZZARELLA');
  static const Cheese CHEESE_CHEDDAR = Cheese._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CHEESE_CHEDDAR');
  static const Cheese CHEESE_NONE = Cheese._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CHEESE_NONE');
  static const Cheese CHEESE_ALL = Cheese._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CHEESE_ALL');

  static const $core.List<Cheese> values = <Cheese> [
    CHEESE_MOZZARELLA,
    CHEESE_CHEDDAR,
    CHEESE_NONE,
    CHEESE_ALL,
  ];

  static final $core.Map<$core.int, Cheese> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Cheese? valueOf($core.int value) => _byValue[value];

  const Cheese._($core.int v, $core.String n) : super(v, n);
}

class OrderStatus extends $pb.ProtobufEnum {
  static const OrderStatus ORDER_RECEIVED = OrderStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORDER_RECEIVED');
  static const OrderStatus ORDER_PREPARING = OrderStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORDER_PREPARING');
  static const OrderStatus ORDER_BAKING = OrderStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORDER_BAKING');
  static const OrderStatus ORDER_PENDING_PICKUP = OrderStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORDER_PENDING_PICKUP');
  static const OrderStatus ORDER_OUT_FOR_DELIVERY = OrderStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORDER_OUT_FOR_DELIVERY');
  static const OrderStatus ORDER_DELIVERED = OrderStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORDER_DELIVERED');
  static const OrderStatus ORDER_UNKNOWN = OrderStatus._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ORDER_UNKNOWN');

  static const $core.List<OrderStatus> values = <OrderStatus> [
    ORDER_RECEIVED,
    ORDER_PREPARING,
    ORDER_BAKING,
    ORDER_PENDING_PICKUP,
    ORDER_OUT_FOR_DELIVERY,
    ORDER_DELIVERED,
    ORDER_UNKNOWN,
  ];

  static final $core.Map<$core.int, OrderStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OrderStatus? valueOf($core.int value) => _byValue[value];

  const OrderStatus._($core.int v, $core.String n) : super(v, n);
}

