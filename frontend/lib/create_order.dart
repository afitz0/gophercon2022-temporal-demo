import 'package:flutter/material.dart';

import 'package:frontend/gopheria_order.dart';
import 'package:frontend/pizza_stream.dart';
import 'package:frontend/pizza_toppings.dart';
import 'package:multiselect/multiselect.dart';

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

  List<String> selectedToppings = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
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
              controller: crustCtrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Cheese Choice';
                }
                return null;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Cheese Choice',
              ),
              controller: cheeseCtrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropDownMultiSelect(
              onChanged: (List<String> x) {
                setState(() {
                  selectedToppings = x;
                });
              },
              selectedValues: selectedToppings,
              options: pizzaToppings,
              whenEmpty: 'Choose toppings',
              childBuilder: (List<String> items) {
                String text = items.reduce((a, b) => "$a, $b");
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 4.0, 20.0, 4.0),
                  child: Text(text.length > 80
                      ? text.replaceRange(80, null, '...')
                      : text),
                );
              },
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

class CrustDropdown extends StatefulWidget {
  const CrustDropdown({super.key});

  @override
  State<CrustDropdown> createState() => _CrustDropdownState();
}

class _CrustDropdownState extends State<CrustDropdown> {
  pizza.Crust _selected = pizza.Crust.CRUST_NORMAL;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selected,
      items: dropdownItems,
      onChanged: (pizza.Crust? newValue) {
        setState(() {
          _selected = newValue!;
        });
      },
    );
  }

  List<DropdownMenuItem<pizza.Crust>> get dropdownItems {
    List<DropdownMenuItem<pizza.Crust>> menuItems = List.generate(
      pizza.Crust.values.length,
      (int index) {
        pizza.Crust value = pizza.Crust.values[index];
        String enumName = value.name;
        enumName.replaceFirst(RegExp(r'CRUST_'), '');
        enumName.replaceAll(RegExp(r'_'), ' ');
        enumName.toLowerCase();
        String textLabel =
            "${enumName[0].toUpperCase()}${enumName.substring(1)}";

        return DropdownMenuItem(
          value: value,
          child: Text(textLabel),
        );
      },
      growable: false,
    );
    return menuItems;
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
