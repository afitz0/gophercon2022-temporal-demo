import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import './gen/proto/pizza/v1/message.pb.dart' as pizza;
import 'pizza_toppings.dart';

/// Number of orders to emit before closing. Set to -1 for infinite.
const int _maxOrders = -1;

/// Number of milliseconds randomly in interval [min, max) between generated orders
const int _newOrderIntervalMin = 2000;
const int _newOrderIntervalMax = 4000;

const int _numRandomToppings = 4;

const String apiPort =
    String.fromEnvironment('NODE_PORT', defaultValue: '8000');
const String apiPrefix = 'http://127.0.0.1:$apiPort';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gopher Pizza Frontend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Stream<GopheriaOrder> _gopherPizzaStream;
  final List<GopherImage> _openOrders = [];

  @override
  void initState() {
    _gopherPizzaStream = (() {
      late final StreamController<GopheriaOrder> controller;
      controller = StreamController<GopheriaOrder>(
        onListen: () async {
          for (int i = 0; _maxOrders == -1 || i < _maxOrders; i++) {
            await Future.delayed(Duration(
                milliseconds: math.Random().nextInt(_newOrderIntervalMax) +
                    _newOrderIntervalMin));

            // Initiates Temporal Workflow
            pizza.PizzaOrderStatus newPizza = await _autoOrderPizza();

            GopheriaOrder order = GopheriaOrder(
              id: newPizza.order.id,
              xAlign: math.Random().nextDouble() * 2 - 1,
              yAlign: math.Random().nextDouble() * 2 - 1,
              orderStatus: newPizza,
            );
            controller.add(order);
          }
          await controller.close();
        },
      );
      return controller.stream;
    })();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<GopheriaOrder>(
          stream: _gopherPizzaStream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
                _openOrders.add(GopherImage(pizzaOrder: snapshot.data!));
                break;
              case ConnectionState.none:
                // TODO: Handle this case.
                break;
              case ConnectionState.waiting:
                // TODO: Handle this case.
                break;
              case ConnectionState.done:
                // TODO: Handle this case.
                break;
            }
            return Stack(children: _openOrders);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _manualOrderPizza,
        tooltip: 'New Pizza',
        child: const Icon(Icons.local_pizza),
      ),
    );
  }

  void _manualOrderPizza() {
    // TODO dialog for ordering a pizza
    setState(() {
      final int id = math.Random().nextInt(-1 * _maxOrders);
      GopheriaOrder order = GopheriaOrder(
        id: id.toString(),
        xAlign: math.Random().nextDouble() * 2 - 1,
        yAlign: math.Random().nextDouble() * 2 - 1,
        orderStatus: pizza.PizzaOrderStatus(),
      );
      _openOrders.add(GopherImage(pizzaOrder: order));
    });
  }

  Future<pizza.PizzaOrderStatus> _autoOrderPizza() async {
    final order = pizza.PizzaOrderInfo(
      id: 'auto-${math.Random().nextInt(10000)}',
      crust:
          pizza.Crust.values[math.Random().nextInt(pizza.Crust.values.length)],
      cheese: pizza
          .Cheese.values[math.Random().nextInt(pizza.Cheese.values.length)],
      toppings: List<String>.generate(_numRandomToppings,
          (_) => pizzaToppings[math.Random().nextInt(pizzaToppings.length)]),
    );

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
      return pizza.PizzaOrderStatus.create()..mergeFromProto3Json(jsonObj);
    } else {
      throw Exception('Failed to call order pizza');
    }
  }
}

class GopheriaOrder {
  final double xAlign;
  final double yAlign;
  final String id;
  pizza.PizzaOrderStatus orderStatus;

  GopheriaOrder(
      {required this.orderStatus,
      required this.id,
      required this.xAlign,
      required this.yAlign});
}

class GopherImage extends StatefulWidget {
  final GopheriaOrder pizzaOrder;

  const GopherImage({Key? key, required this.pizzaOrder}) : super(key: key);

  @override
  State<GopherImage> createState() => _GopherImageState();
}

class _GopherImageState extends State<GopherImage> {
  bool _inProgress = true;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(widget.pizzaOrder.xAlign, widget.pizzaOrder.yAlign),
      child: GestureDetector(
          onTap: () async {
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                pizza.PizzaOrderInfo orderDetails =
                    widget.pizzaOrder.orderStatus.order;

                return AlertDialog(
                  title: const Text('Gopher Order Information'),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order id: ${widget.pizzaOrder.id}"),
                      Text("Crust type: ${orderDetails.crust}"),
                      Text("Cheese: ${orderDetails.cheese}"),
                      Text("Ingredients List: ${orderDetails.toppings}"),
                      FutureBuilder<pizza.PizzaOrderStatus>(
                        future: _getOrderStatus(),
                        builder: (_,
                            AsyncSnapshot<pizza.PizzaOrderStatus> snapshot) {
                          if (snapshot.hasData) {
                            widget.pizzaOrder.orderStatus = snapshot.data!;
                            if (widget.pizzaOrder.orderStatus.status ==
                                pizza.OrderStatus.ORDER_DELIVERED) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                setState(() {
                                  _inProgress = false;
                                });
                              });
                            }
                            return Text(
                                "Status: ${snapshot.data!.status.toString()}");
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
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Image.asset(
              _inProgress
                  ? 'assets/gopher-sleeping.png'
                  : 'assets/gopher-2.png',
              height: 100.0)),
    );
  }

  Future<pizza.PizzaOrderStatus> _getOrderStatus() async {
    final jsonOrderObj = widget.pizzaOrder.orderStatus.toProto3Json();
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
