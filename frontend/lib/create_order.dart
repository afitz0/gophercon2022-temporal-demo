import 'package:flutter/material.dart';

import 'dart:math';

import 'package:frontend/gopheria_order.dart';
import 'package:frontend/pizza_stream.dart';
import 'package:frontend/pizza_toppings.dart';
//import 'package:multiselect/multiselect.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import './gen/proto/pizza/v1/message.pb.dart' as pizza;

//final _staticOrder = pizza.PizzaOrderInfo(
//  id: 'manual-1234abc',
//  crust: pizza.Crust.values[0],
//  cheese: pizza.Cheese.values[0],
//  toppings: [pizzaToppings[0]],
//);

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

  final ValueNotifier<pizza.Crust> crustNotifier =
      ValueNotifier<pizza.Crust>(pizza.Crust.CRUST_NORMAL);
  final ValueNotifier<pizza.Cheese> cheeseNotifier =
      ValueNotifier<pizza.Cheese>(pizza.Cheese.CHEESE_MOZZARELLA);
  final ValueNotifier<List<String>> toppigsNotifier =
      ValueNotifier<List<String>>(<String>[""]);

  List<String> selectedToppings = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CrustDropdown(notifier: crustNotifier),
            // child: TextFormField(
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Enter a Type of Crust';
            //     }
            //     return null;
            //   },
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     hintText: 'Enter a Type of Crust',
            //   ),
            //   controller: crustCtrl,
            // ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CheeseDropdown(notifier: cheeseNotifier),
            // child: TextFormField(
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Enter Cheese Choice';
            //     }
            //     return null;
            //   },
            //   decoration: const InputDecoration(
            //     border: OutlineInputBorder(),
            //     hintText: 'Enter Cheese Choice',
            //   ),
            //   controller: cheeseCtrl,
            // ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSelect(
              items: pizzaToppings,
              label: 'Select Toppings',
              notifier: toppigsNotifier,
            ),
            // child: DropDownMultiSelect(
            //   onChanged: (List<String> x) {
            //     setState(() {
            //       selectedToppings = x;
            //     });
            //   },
            //   selectedValues: selectedToppings,
            //   options: pizzaToppings,
            //   whenEmpty: 'Choose toppings',
            //   childBuilder: (List<String> items) {
            //     if (items.isNotEmpty) {
            //       String text = items.reduce((a, b) => "$a, $b");
            //       return Padding(
            //         padding: const EdgeInsets.fromLTRB(10.0, 4.0, 20.0, 4.0),
            //         child: Text(text.length > 80
            //             ? text.replaceRange(80, null, '...')
            //             : text),
            //       );
            //     } else {
            //       return const Text('');
            //     }
            //   },
            // ),
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                pizza.PizzaOrderInfo order = pizza.PizzaOrderInfo(
                  // ignore: prefer_interpolation_to_compose_strings
                  id: 'manual-' + Random().nextInt(1000).toString(),
                  crust: crustNotifier.value,
                  cheese: cheeseNotifier.value,
                  toppings: toppigsNotifier.value,
                );
                widget.notifier.value = order;
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  String enumNameToTitlecase(dynamic e, String prefix) {
    String enumName = e.name;
    enumName = enumName.replaceFirst(RegExp(prefix), '');
    enumName = enumName.replaceAll(RegExp(r'_'), ' ');
    enumName = enumName.toLowerCase();
    String textLabel = "${enumName[0].toUpperCase()}${enumName.substring(1)}";
    return textLabel;
  }
}

class DropdownSelect extends StatefulWidget {
  final List<String> items;
  final String label;
  final ValueNotifier<List<String>> notifier;

  const DropdownSelect(
      {super.key,
      required this.items,
      required this.label,
      required this.notifier});

  @override
  State<DropdownSelect> createState() => _DropdownSelectState();
}

class _DropdownSelectState extends State<DropdownSelect> {
  @override
  Widget build(BuildContext context) {
    return MultiSelectDialogField(
      items: widget.items.map((e) => MultiSelectItem(e, e)).toList(),
      listType: MultiSelectListType.CHIP,
      title: Text(widget.label),
      buttonText: Text(widget.label),
      onConfirm: (List<String> values) {
        //_selectedAnimals = values;
        widget.notifier.value = values;
      },
    );
  }
}

class CheeseDropdown extends StatefulWidget {
  final ValueNotifier<pizza.Cheese> notifier;
  const CheeseDropdown({super.key, required this.notifier});

  @override
  State<CheeseDropdown> createState() => _CheeseDropdownState();
}

class _CheeseDropdownState extends State<CheeseDropdown> {
  pizza.Cheese _selected = pizza.Cheese.CHEESE_MOZZARELLA;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selected,
      items: dropdownItems,
      onChanged: (pizza.Cheese? newValue) {
        setState(() {
          _selected = newValue!;
          widget.notifier.value = newValue;
        });
      },
    );
  }

  List<DropdownMenuItem<pizza.Cheese>> get dropdownItems {
    List<DropdownMenuItem<pizza.Cheese>> menuItems = List.generate(
      pizza.Cheese.values.length,
      (int index) {
        pizza.Cheese value = pizza.Cheese.values[index];
        String enumName = value.name;
        enumName = enumName.replaceFirst(RegExp(r'CHEESE_'), '');
        enumName = enumName.replaceAll(RegExp(r'_'), ' ');
        enumName = enumName.toLowerCase();
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

class CrustDropdown extends StatefulWidget {
  final ValueNotifier<pizza.Crust> notifier;
  const CrustDropdown({super.key, required this.notifier});

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
          widget.notifier.value = newValue;
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
        enumName = enumName.replaceFirst(RegExp(r'CRUST_'), '');
        enumName = enumName.replaceAll(RegExp(r'_'), ' ');
        enumName = enumName.toLowerCase();
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
