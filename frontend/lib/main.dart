import 'package:flutter/material.dart';
import 'package:frontend/pizza_stream.dart';
import 'package:frontend/gopheria_order.dart';
import 'package:frontend/gopher_image.dart';
import 'package:frontend/create_order.dart';
import 'package:frontend/single_order.dart';

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
      //home: const MyHomePage(),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.25 * width),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SingleOrder(),
                  ),
                );
              },
              child: const Text('Single Order'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Auto Orders'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PizzaStream _gopherPizzaStream;
  final List<GopherImage> _openOrders = [];

  @override
  void initState() {
    _gopherPizzaStream = PizzaStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<GopheriaOrder>(
          stream: _gopherPizzaStream.getStream(),
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
        onPressed: () => _manualOrderPizza(context),
        tooltip: 'New Pizza',
        child: const Icon(Icons.local_pizza),
      ),
    );
  }

  void _manualOrderPizza(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateOrder(pizzaStream: _gopherPizzaStream),
      ),
    );

/*
    // TODO dialog for ordering a pizza
    setState(() {
      final int id =
          math.Random().nextInt(maxOrders > 0 ? maxOrders : -1 * maxOrders);
      GopheriaOrder order = GopheriaOrder(
        id: id.toString(),
        xAlign: math.Random().nextDouble() * 2 - 1,
        yAlign: math.Random().nextDouble() * 2 - 1,
        orderStatus: pizza.PizzaOrderStatus(),
      );
      _openOrders.add(GopherImage(pizzaOrder: order));
    });
*/
  }
}
