import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/constants.dart';

import './gen/proto/pizza/v1/message.pb.dart' as pizza;

class OrderStatusDialog extends StatefulWidget {
  final pizza.PizzaOrderStatus status;
  final ValueNotifier<bool> progressNotifier;

  const OrderStatusDialog(
      {super.key, required this.status, required this.progressNotifier});

  @override
  State<OrderStatusDialog> createState() => _OrderStatusDialogState();
}

class _OrderStatusDialogState extends State<OrderStatusDialog> {
  pizza.PizzaOrderStatus? _lastKnownStatus;

  @override
  Widget build(BuildContext context) {
    pizza.PizzaOrderInfo order = widget.status.order;
    return AlertDialog(
      title: const Text('Gopher Order Information'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order id: ${order.id}"),
          Text("Crust type: ${order.crust}"),
          Text("Cheese: ${order.cheese}"),
          Text("Ingredients List: ${order.toppings}"),
          FutureBuilder<pizza.PizzaOrderStatus>(
            future: _getOrderStatus(),
            builder: (_, AsyncSnapshot<pizza.PizzaOrderStatus> snapshot) {
              if (snapshot.hasData) {
                _lastKnownStatus = snapshot.data!;
                if (_lastKnownStatus!.status ==
                    pizza.OrderStatus.ORDER_DELIVERED) {
                  widget.progressNotifier.value = false;
                }
                return Text("Status: ${snapshot.data!.status.toString()}");
              } else {
                return const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Future<pizza.PizzaOrderStatus> _getOrderStatus() async {
    final jsonOrderObj = widget.status.toProto3Json();
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
