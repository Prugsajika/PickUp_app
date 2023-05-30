import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cartitem_model.dart';

class CartServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('cart');

  Future<List<CartItem>> getCart() async {
    QuerySnapshot snapshot = await _collection.get();

    AllCartItems snap = AllCartItems.fromSnapshot(snapshot);

    print('QuerySnapshot ${snap.cartitems.length}');
    return snap.cartitems;
  }

  Future<List<CartItem>> getCartItemsByEmail(String emailRider) async {
    String emaillowC = emailRider.toLowerCase().toString();
    print(" getCartItemsByEmail $emaillowC");
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('emailRider', isEqualTo: emailRider.toLowerCase().toString())
        .get();

    AllCartItems cartitems = AllCartItems.fromSnapshot(snapshot);
    print("cartitems  $cartitems");
    return cartitems.cartitems;
  }

  void updatePaystatus(String cartId, status) async {
    FirebaseFirestore.instance.collection('cart').doc(cartId).update({
      'cartId': cartId,
      'status': status,
    });
    print('cartId for service$cartId');
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
  //     _paydate,
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
  //   FirebaseFirestore.instance.collection('cart').add({
  //     'cartId': '',
  //     'image': image,
  //     'name': name,
  //     'quantity': quantity,
  //     'cost': cost,
  //     'price': price,
  //     'Productid': Productid,
  //     'deliveryFee': deliveryFee,
  //     'totalCost': totalCost,
  //     'customerId': customerId,
  //     'paydate': _paydate,
  //     'paytime': _paytime,
  //     'confirmPayimg': confirmPayimg,
  //     'email': email,
  //     'UrlQr': UrlQr,
  //     'buildName': buildName,
  //     'roomNo': roomNo,
  //     'status': status,
  //     'availableDate': availableDate,
  //     'availableTime': availableTime,
  //     'emailRider': emailRider,
  //   }).then((value) =>
  //       FirebaseFirestore.instance.collection('cart').doc(value.id).update({
  //         // 'id': value.id,
  //         'cartId': value.id,
  //       }));
  // }
}
