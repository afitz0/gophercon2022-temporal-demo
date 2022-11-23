import 'dart:async';
import 'dart:math' as math;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:frontend/constants.dart';
import 'package:frontend/create_order.dart';

import './gen/proto/pizza/v1/message.pb.dart' as pizza;

const int _pollBaseMs = 2000;
const int _pollJitterMs = 500;

class SingleOrder extends StatefulWidget {
  const SingleOrder({super.key});

  @override
  State<SingleOrder> createState() => _SingleOrderState();
}

class _SingleOrderState extends State<SingleOrder> {
  final ValueNotifier<pizza.PizzaOrderInfo?> orderNotifier =
      ValueNotifier<pizza.PizzaOrderInfo?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<pizza.PizzaOrderInfo?>(
        valueListenable: orderNotifier,
        builder: (_, pizza.PizzaOrderInfo? order, Widget? child) {
          if (order == null) {
            return CreateOrderForm(notifier: orderNotifier);
          } else {
            return SubmitAndMonitor(order: order);
          }
        },
      ),
    );
  }
}

class SubmitAndMonitor extends StatelessWidget {
  final pizza.PizzaOrderInfo order;

  const SubmitAndMonitor({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(0.2 * width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StatusText(order: order),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('⬅︎ Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusText extends StatefulWidget {
  final pizza.PizzaOrderInfo order;

  const StatusText({super.key, required this.order});

  @override
  State<StatusText> createState() => _StatusTextState();
}

class _StatusTextState extends State<StatusText> {
  late OrderStream _stream;

  @override
  void initState() {
    super.initState();
    _stream = OrderStream(order: widget.order);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<pizza.PizzaOrderStatus>(
      stream: _stream.getStream(),
      builder: (context, snapshot) {
        late Widget infoLabel;
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            infoLabel = statusToLabel(snapshot.data!.status);
            break;
          case ConnectionState.none:
            infoLabel = const Text('Pending connection');
            break;
          case ConnectionState.waiting:
            infoLabel = const Text('... waiting for server');
            break;
          case ConnectionState.done:
            infoLabel = const Text('All Done!');
            break;
        }

        if (snapshot.hasError) {
          infoLabel = Text('Uh-oh! Got an error: ${snapshot.error}');
        }

        return infoLabel;
      },
    );
  }

  Widget statusToLabel(pizza.OrderStatus status) {
    late IconData icon;
    late String text;

    switch (status) {
      case pizza.OrderStatus.ORDER_RECEIVED:
        icon = Icons.local_pizza_outlined;
        text = 'Order received!';
        break;
      case pizza.OrderStatus.ORDER_PREPARING:
        icon = Icons.soup_kitchen;
        text = 'Assembling ingredients!';
        break;
      case pizza.OrderStatus.ORDER_BAKING:
        icon = Icons.fireplace_outlined;
        text = 'Baking pizza!';
        break;
      case pizza.OrderStatus.ORDER_PENDING_PICKUP:
        icon = Icons.countertops;
        text = 'Waiting for delivery driver';
        break;
      case pizza.OrderStatus.ORDER_OUT_FOR_DELIVERY:
        icon = Icons.delivery_dining;
        text = 'Order is out for delivery!';
        break;
      case pizza.OrderStatus.ORDER_DELIVERED:
        icon = Icons.local_pizza;
        text = 'Order delivered!';
        break;
      case pizza.OrderStatus.ORDER_UNKNOWN:
      default:
        icon = Icons.question_mark;
        text = 'Unknown Order Status';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 20.0,
        ),
        Text(text),
      ],
    );
  }
}

class OrderStream {
  late StreamController<pizza.PizzaOrderStatus> _controller;
  final pizza.PizzaOrderInfo order;

  OrderStream({required this.order}) {
    _controller = StreamController<pizza.PizzaOrderStatus>(
      onListen: () async {
        try {
          pizza.PizzaOrderStatus status = await _orderPizza(order);
          _controller.add(status);

          while (status.status != pizza.OrderStatus.ORDER_DELIVERED) {
            final int jitter =
                _pollJitterMs - math.Random().nextInt(_pollJitterMs * 2);
            await Future.delayed(Duration(milliseconds: _pollBaseMs + jitter));

            status = await _updateStatus(status);
            _controller.add(status);
          }
        } catch (e) {
          _controller.addError(e);
        } finally {
          await _controller.close();
        }
      },
    );
  }

  Stream<pizza.PizzaOrderStatus> getStream() => _controller.stream;

  Future<pizza.PizzaOrderStatus> _orderPizza(pizza.PizzaOrderInfo order) async {
    final jsonOrderObj = order.toProto3Json();
    final response = await http.post(
      Uri.parse('$apiPrefix/orderPizza'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(jsonOrderObj),
    );

    if (response.statusCode == 200) {
      final jsonObj = jsonDecode(response.body);
      pizza.PizzaOrderStatus status = pizza.PizzaOrderStatus.create()
        ..mergeFromProto3Json(jsonObj);
      return status;
    } else {
      throw Exception('Failed to call order pizza');
    }
  }

  Future<pizza.PizzaOrderStatus> _updateStatus(
      pizza.PizzaOrderStatus status) async {
    final jsonOrderObj = status.toProto3Json();
    final response = await http.post(
      Uri.parse('$apiPrefix/orderStatus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(jsonOrderObj),
    );

    if (response.statusCode == 200) {
      final jsonObj = jsonDecode(response.body);
      return pizza.PizzaOrderStatus.create()..mergeFromProto3Json(jsonObj);
    } else {
      throw Exception('Failed to get order status');
    }
  }
}
