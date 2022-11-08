import './gen/proto/pizza/v1/message.pb.dart' as pizza;

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
