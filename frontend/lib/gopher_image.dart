import 'package:flutter/material.dart';
import 'package:frontend/status_dialog.dart';
import 'package:frontend/gopheria_order.dart';

class GopherImage extends StatefulWidget {
  final GopheriaOrder pizzaOrder;

  const GopherImage({Key? key, required this.pizzaOrder}) : super(key: key);

  @override
  State<GopherImage> createState() => _GopherImageState();
}

class _GopherImageState extends State<GopherImage> {
  // All pizza orders are assumed to be in progress at first.
  final ValueNotifier<bool> _inProgressNotifier = ValueNotifier<bool>(true);

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
              return OrderStatusDialog(
                  status: widget.pizzaOrder.orderStatus,
                  progressNotifier: _inProgressNotifier);
            },
          );
        },
        child: ValueListenableBuilder<bool>(
          valueListenable: _inProgressNotifier,
          builder: (BuildContext context, bool inProgress, Widget? child) {
            return Image.asset(
                inProgress
                    ? 'assets/gopher-sleeping.png'
                    : 'assets/gopher-2.png',
                height: 100.0);
          },
        ),
      ),
    );
  }
}
