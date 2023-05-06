import 'dart:async';

import 'package:grubngo_app/pages/addproduct_page.dart';

import '../models/products_model.dart';
import '../services/product_services.dart';

class ProductController {
  final ProductServices services;
  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  List<Product> products = List.empty();
  ProductController(this.services);

  Future<List<Product>> fetchProduct() async {
    // controller status => Start
    onSyncController.add(true);
    products = await services.get();
    // controller status => End
    onSyncController.add(false);

    return products;
  }

  Future<List<Product>> fetchbyuser() async {
    // controller status => Start
    onSyncController.add(true);
    products = await services.getbyuser();
    // controller status => End
    onSyncController.add(false);

    return products;
  }

  void addProduct(
      String name,
      description,
      UrlPd,
      deliveryLocation,
      email,
      typeOfFood,
      sentDate,
      sentTime,
      int price,
      stock,
      deliveryFee,
      String UrlQr) async {
    services.addProduct(name, description, UrlPd, deliveryLocation, email,
        typeOfFood, sentDate, sentTime, price, stock, deliveryFee, UrlQr);
  }
}
