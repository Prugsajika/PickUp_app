import 'dart:async';

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

  Future<List<Product>> fetchProductInfo(String Productid) async {
    onSyncController.add(true);
    products = await services.getProductInfo(Productid);
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
      String UrlQr,
      availableDate,
      availableTime) async {
    services.addProduct(
        name,
        description,
        UrlPd,
        deliveryLocation,
        email,
        typeOfFood,
        sentDate,
        sentTime,
        price,
        stock,
        deliveryFee,
        UrlQr,
        availableDate,
        availableTime);
  }

  void updateProduct(
      String UrlPd,
      name,
      typeOfFood,
      description,
      int price,
      stock,
      deliveryFee,
      String sentDate,
      sentTime,
      deliveryLocation,
      availableDate,
      availableTime,
      Productid) async {
    services.updateProduct(
        UrlPd,
        name,
        typeOfFood,
        description,
        price,
        stock,
        deliveryFee,
        sentDate,
        sentTime,
        deliveryLocation,
        availableDate,
        availableTime,
        Productid);
  }

  void deleteProduct(String Productid) async {
    services.deleteProduct(Productid);
  }
}
