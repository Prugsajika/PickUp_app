import 'dart:async';

import '../models/cartitem_model.dart';
import '../services/cart_services.dart';

class CartController {
  final CartServices services;
  List<CartItem> cartitems = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  CartController(this.services);

  Future<List<CartItem>> fetchCart() async {
    // controller status => Start
    onSyncController.add(true);
    cartitems = await services.getCart();
    // controller status => End
    onSyncController.add(false);

    return cartitems;
  }

  Future<List<CartItem>> fetchCartItemsByEmail(String email) async {
    // controller status => Start
    onSyncController.add(true);
    cartitems = await services.getCartItemsByEmail(email);
    // controller status => End
    onSyncController.add(false);

    return cartitems;
  }

  void addCart(
      String image,
      name,
      Productid,
      customerId,
      int quantity,
      cost,
      price,
      deliveryFee,
      totalCost,
      String _paydate,
      _paytime,
      confirmPayimg,
      email,
      UrlQr,
      buildName,
      roomNo,
      status,
      availableDate,
      availableTime,
      emailRider) async {
    services.addCart(
        image,
        name,
        Productid,
        customerId,
        quantity,
        cost,
        price,
        deliveryFee,
        totalCost,
        _paydate,
        _paytime,
        confirmPayimg,
        email,
        UrlQr,
        buildName,
        roomNo,
        status,
        availableDate,
        availableTime,
        emailRider);
  }
}
