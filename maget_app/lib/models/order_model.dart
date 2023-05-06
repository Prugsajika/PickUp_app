import 'package:maget_app/models/products_model.dart';

import 'customer_model.dart';

class OrderModel {
  late int status;
  late String message;
  List<Order> order;

  OrderModel({
    required this.status,
    required this.message,
    required this.order,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        status: json["status"],
        message: json["message"],
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
      );
}

class Order {
  String id;
  DateTime orderDate;
  List<Item> items;
  num totalPrice;
  Customer shop;
  Customer customer;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Order({
    required this.id,
    required this.orderDate,
    required this.items,
    required this.totalPrice,
    required this.shop,
    required this.customer,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        orderDate: DateTime.parse(json["order_date"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        totalPrice: json["total_price"],
        shop: Customer.fromJson(json["shop"]),
        customer: Customer.fromJson(json["customer"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class Item {
  String id;
  Product food;
  int quantity;

  Item({
    required this.id,
    required this.food,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        food: Product.fromJason(json["food"]),
        quantity: json["quantity"],
      );
}
