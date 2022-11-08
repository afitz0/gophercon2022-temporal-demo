import 'package:flutter/material.dart';

import 'package:frontend/gopheria_order.dart';
import 'package:frontend/pizza_stream.dart';
import 'package:frontend/pizza_toppings.dart';

import './gen/proto/pizza/v1/message.pb.dart' as pizza;

final _staticOrder = pizza.PizzaOrderInfo(
  id: 'manual-1234abc',
  crust: pizza.Crust.values[0],
  cheese: pizza.Cheese.values[0],
  toppings: [pizzaToppings[0]],
);

class CreateOrder extends StatefulWidget {
  final PizzaStream pizzaStream;
  const CreateOrder({super.key, required this.pizzaStream});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  final ValueNotifier<pizza.PizzaOrderInfo?> orderNotifier =
      ValueNotifier<pizza.PizzaOrderInfo?>(null);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('New Order Creation Form')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.2 * width,
            vertical: 12.0,
          ),
          child: ValueListenableBuilder<pizza.PizzaOrderInfo?>(
            valueListenable: orderNotifier,
            builder: (_, pizza.PizzaOrderInfo? order, Widget? child) {
              if (order == null) {
                return CreateOrderForm(notifier: orderNotifier);
              } else {
                return SubmitPizza(
                    pizzaStream: widget.pizzaStream, order: order);
              }
            },
          ),
        ),
      ),
    );
  }
}

class CreateOrderForm extends StatefulWidget {
  final ValueNotifier<pizza.PizzaOrderInfo?> notifier;
  const CreateOrderForm({super.key, required this.notifier});

  @override
  State<CreateOrderForm> createState() => _CreateOrderFormState();
}

class _CreateOrderFormState extends State<CreateOrderForm> {
  final _formKey = GlobalKey<FormState>();

  final crustCtrl = TextEditingController();
  final toppingCtrl = TextEditingController();
  final cheeseCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a Type of Crust';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a Type of Crust',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // TODO grab the actual fields.
                widget.notifier.value = _staticOrder;
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class SubmitPizza extends StatelessWidget {
  final PizzaStream pizzaStream;
  final pizza.PizzaOrderInfo order;

  const SubmitPizza({
    super.key,
    required this.pizzaStream,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: makeOrder(),
      builder: (_, AsyncSnapshot<GopheriaOrder> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const Text('Submitted order!'),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Return to home'),
              )
            ],
          );
        } else {
          return const SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<GopheriaOrder> makeOrder() async {
/*
    final order = pizza.PizzaOrderInfo(
      id: 'auto-${math.Random().nextInt(10000)}',
      crust:
          pizza.Crust.values[math.Random().nextInt(pizza.Crust.values.length)],
      cheese: pizza
          .Cheese.values[math.Random().nextInt(pizza.Cheese.values.length)],
      toppings: List<String>.generate(numRandomToppings,
          (_) => pizzaToppings[math.Random().nextInt(pizzaToppings.length)]),
    );
*/

    return pizzaStream.orderPizza(order);
  }
}
