import 'dart:async';

import 'package:grubngo_app/services/cart_services.dart';

import '../models/cartitem_model.dart';

class CartController {
  final CartServices services;
  List<CartItem> cartitems = List.empty();
  List<CartItem> countcartitems = List.empty();
  List<CartItem> cartitemperproducts = List.empty();

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

  Future<List<CartItem>> fetchOrderByProductWithCFPay() async {
    // controller status => Start
    onSyncController.add(true);
    cartitemperproducts = await services.getOrderByProductWithCFPay();
    // controller status => End
    onSyncController.add(false);

    return cartitemperproducts;
  }

  Future<List<CartItem>> fetchCartItemsAll() async {
    onSyncController.add(true);
    countcartitems = await services.getCartItemsAll();
    onSyncController.add(false);
    return countcartitems;
  }

  Future<List<CartItem>> fetchOrderByProductid(Productid) async {
    // controller status => Start
    onSyncController.add(true);
    cartitemperproducts = await services.getOrderByProductid(Productid);
    // controller status => End
    onSyncController.add(false);

    return cartitemperproducts;
  }

  Future<List<CartItem>> fetchCartItemsSuccessByEmail(String emailRider) async {
    // controller status => Start
    onSyncController.add(true);
    cartitems = await services.getCartItemsSuccessByEmail(emailRider);
    // controller status => End
    onSyncController.add(false);

    return cartitems;
  }

  Future<List<CartItem>> fetchCartItemsWaitByEmail(String emailRider) async {
    // controller status => Start
    onSyncController.add(true);
    cartitems = await services.getCartItemsWaitByEmail(emailRider);
    // controller status => End
    onSyncController.add(false);

    return cartitems;
  }

  void updateRefundPayment(
    String cartId,
    refundStatus,
    _refunddate,
    _refundtime,
    refundPayimg,
  ) async {
    services.updateRefundPayment(
      cartId,
      refundStatus,
      _refunddate,
      _refundtime,
      refundPayimg,
    );
  }
}
