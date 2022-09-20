import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:async';

/// Number of orders to emit before closing. Set to -1 for infinite.
const int _maxOrders = -1;

/// Number of milliseconds randomly in interval [min, max) between generated orders
const int _newOrderIntervalMin = 2000;
const int _newOrderIntervalMax = 5000;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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
            GopheriaOrder order = GopheriaOrder(
              id: i,
              xAlign: math.Random().nextDouble() * 2 - 1,
              yAlign: math.Random().nextDouble() * 2 - 1,
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
        child: Flexible(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _orderPizza,
        tooltip: 'New Pizza',
        child: const Icon(Icons.local_pizza),
      ),
    );
  }

  void _orderPizza() {
    // TODO dialog for ordering a pizza
    setState(() {
      GopheriaOrder order = GopheriaOrder(
        id: math.Random().nextInt(-1 * _maxOrders),
        xAlign: math.Random().nextDouble() * 2 - 1,
        yAlign: math.Random().nextDouble() * 2 - 1,
      );
      _openOrders.add(GopherImage(pizzaOrder: order));
    });
  }
}

class GopheriaOrder {
  final double xAlign;
  final double yAlign;
  final int id;

  const GopheriaOrder(
      {required this.id, required this.xAlign, required this.yAlign});
}

class GopherImage extends StatelessWidget {
  final GopheriaOrder pizzaOrder;

  const GopherImage({Key? key, required this.pizzaOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(pizzaOrder.xAlign, pizzaOrder.yAlign),
      child: GestureDetector(
          onTap: () async {
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text('Gopher Order Information'),
                    content: Text("Order id: ${pizzaOrder.id}"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ]);
              },
            );
          },
          child: Image.asset('assets/gopher-2.png', height: 50.0)),
    );
  }
}
