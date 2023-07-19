import 'dart:async';

import 'package:grubngo_app/services/cart_services.dart';

import '../models/cartitem_model.dart';

class CartController {
  final CartServices services;
  List<CartItem> cartitems = List.empty();
  List<CountCartItem> countcartitems = List.empty();

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

  Future<List<CartItem>> fetchCartItemsByEmail(String emailRider) async {
    // controller status => Start
    onSyncController.add(true);
    cartitems = await services.getCartItemsByEmail(emailRider);
    // controller status => End
    onSyncController.add(false);

    return cartitems;
  }

  void updatePaystatus(String cartId, status) async {
    services.updatePaystatus(cartId, status);
  }

  Future<List<CartItem>> fetchOrderByProduct() async {
    // controller status => Start
    onSyncController.add(true);
    cartitems = await services.getOrderByProduct();
    // controller status => End
    onSyncController.add(false);

    return cartitems;
  }

  Future<List<CountCartItem>> fetchCartItemsAll() async {
    onSyncController.add(true);
    countcartitems = await services.getCartItemsAll();
    onSyncController.add(false);
    return countcartitems;
  }

  // void addCart(
  //     String image,
  //     name,
  //     Productid,
  //     customerId,
  //     int quantity,
  //     cost,
  //     price,
  //     deliveryFee,
  //     totalCost,
  //     String _paydate,
  //     _paytime,
  //     confirmPayimg,
  //     email,
  //     UrlQr,
  //     buildName,
  //     roomNo,
  //     status,
  //     availableDate,
  //     availableTime,
  //     emailRider) async {
  //   services.addCart(
  //       image,
  //       name,
  //       Productid,
  //       customerId,
  //       quantity,
  //       cost,
  //       price,
  //       deliveryFee,
  //       totalCost,
  //       _paydate,
  //       _paytime,
  //       confirmPayimg,
  //       email,
  //       UrlQr,
  //       buildName,
  //       roomNo,
  //       status,
  //       availableDate,
  //       availableTime,
  //       emailRider);
  // }
}
