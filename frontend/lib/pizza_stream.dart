import 'dart:math' as math;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:frontend/constants.dart';
import 'package:frontend/pizza_toppings.dart';
import 'package:frontend/gopheria_order.dart';

import './gen/proto/pizza/v1/message.pb.dart' as pizza;

class PizzaStream {
  late StreamController<GopheriaOrder> _controller;

  PizzaStream() {
    _controller = StreamController<GopheriaOrder>(
      onListen: () async {
        for (int i = 0; maxOrders == -1 || i < maxOrders; i++) {
          await Future.delayed(Duration(
              milliseconds: math.Random().nextInt(newOrderIntervalMax) +
                  newOrderIntervalMin));

          final order = pizza.PizzaOrderInfo(
            id: 'auto-${math.Random().nextInt(10000)}',
            crust: pizza
                .Crust.values[math.Random().nextInt(pizza.Crust.values.length)],
            cheese: pizza.Cheese
                .values[math.Random().nextInt(pizza.Cheese.values.length)],
            toppings: List<String>.generate(
                numRandomToppings,
                (_) =>
                    pizzaToppings[math.Random().nextInt(pizzaToppings.length)]),
          );

          // Initiates Temporal Workflow
          GopheriaOrder newPizza = await orderPizza(order);
          _controller.add(newPizza);
        }
        await _controller.close();
      },
    );
  }

  Stream<GopheriaOrder> getStream() => _controller.stream;

  void insertOrder(GopheriaOrder o) => _controller.add(o);

  Future<GopheriaOrder> orderPizza(pizza.PizzaOrderInfo order) async {
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
      pizza.PizzaOrderStatus newOrder = pizza.PizzaOrderStatus.create()
        ..mergeFromProto3Json(jsonObj);
      return GopheriaOrder(
        id: newOrder.order.id,
        xAlign: math.Random().nextDouble() * 2 - 1,
        yAlign: math.Random().nextDouble() * 2 - 1,
        orderStatus: newOrder,
      );
    } else {
      throw Exception('Failed to call order pizza');
    }
  }
}
