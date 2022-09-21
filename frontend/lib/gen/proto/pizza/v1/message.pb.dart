///
//  Generated code. Do not modify.
//  source: proto/pizza/v1/message.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'message.pbenum.dart';

export 'message.pbenum.dart';

class PizzaOrderInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PizzaOrderInfo', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'gopherpizza.pizza.api.v1'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..e<Crust>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'crust', $pb.PbFieldType.OE, defaultOrMaker: Crust.CRUST_NORMAL, valueOf: Crust.valueOf, enumValues: Crust.values)
    ..e<Cheese>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cheese', $pb.PbFieldType.OE, defaultOrMaker: Cheese.CHEESE_MOZZARELLA, valueOf: Cheese.valueOf, enumValues: Cheese.values)
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'toppings')
    ..hasRequiredFields = false
  ;

  PizzaOrderInfo._() : super();
  factory PizzaOrderInfo({
    $core.String? id,
    Crust? crust,
    Cheese? cheese,
    $core.Iterable<$core.String>? toppings,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (crust != null) {
      _result.crust = crust;
    }
    if (cheese != null) {
      _result.cheese = cheese;
    }
    if (toppings != null) {
      _result.toppings.addAll(toppings);
    }
    return _result;
  }
  factory PizzaOrderInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PizzaOrderInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PizzaOrderInfo clone() => PizzaOrderInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PizzaOrderInfo copyWith(void Function(PizzaOrderInfo) updates) => super.copyWith((message) => updates(message as PizzaOrderInfo)) as PizzaOrderInfo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PizzaOrderInfo create() => PizzaOrderInfo._();
  PizzaOrderInfo createEmptyInstance() => create();
  static $pb.PbList<PizzaOrderInfo> createRepeated() => $pb.PbList<PizzaOrderInfo>();
  @$core.pragma('dart2js:noInline')
  static PizzaOrderInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PizzaOrderInfo>(create);
  static PizzaOrderInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  Crust get crust => $_getN(1);
  @$pb.TagNumber(2)
  set crust(Crust v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCrust() => $_has(1);
  @$pb.TagNumber(2)
  void clearCrust() => clearField(2);

  @$pb.TagNumber(3)
  Cheese get cheese => $_getN(2);
  @$pb.TagNumber(3)
  set cheese(Cheese v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCheese() => $_has(2);
  @$pb.TagNumber(3)
  void clearCheese() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get toppings => $_getList(3);
}

class PizzaOrderStatus extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PizzaOrderStatus', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'gopherpizza.pizza.api.v1'), createEmptyInstance: create)
    ..e<OrderStatus>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: OrderStatus.ORDER_RECEIVED, valueOf: OrderStatus.valueOf, enumValues: OrderStatus.values)
    ..aOM<PizzaOrderInfo>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'order', subBuilder: PizzaOrderInfo.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'runId', protoName: 'runId')
    ..hasRequiredFields = false
  ;

  PizzaOrderStatus._() : super();
  factory PizzaOrderStatus({
    OrderStatus? status,
    PizzaOrderInfo? order,
    $core.String? runId,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    if (order != null) {
      _result.order = order;
    }
    if (runId != null) {
      _result.runId = runId;
    }
    return _result;
  }
  factory PizzaOrderStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PizzaOrderStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PizzaOrderStatus clone() => PizzaOrderStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PizzaOrderStatus copyWith(void Function(PizzaOrderStatus) updates) => super.copyWith((message) => updates(message as PizzaOrderStatus)) as PizzaOrderStatus; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PizzaOrderStatus create() => PizzaOrderStatus._();
  PizzaOrderStatus createEmptyInstance() => create();
  static $pb.PbList<PizzaOrderStatus> createRepeated() => $pb.PbList<PizzaOrderStatus>();
  @$core.pragma('dart2js:noInline')
  static PizzaOrderStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PizzaOrderStatus>(create);
  static PizzaOrderStatus? _defaultInstance;

  @$pb.TagNumber(1)
  OrderStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(OrderStatus v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);

  @$pb.TagNumber(2)
  PizzaOrderInfo get order => $_getN(1);
  @$pb.TagNumber(2)
  set order(PizzaOrderInfo v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOrder() => $_has(1);
  @$pb.TagNumber(2)
  void clearOrder() => clearField(2);
  @$pb.TagNumber(2)
  PizzaOrderInfo ensureOrder() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get runId => $_getSZ(2);
  @$pb.TagNumber(3)
  set runId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRunId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRunId() => clearField(3);
}

