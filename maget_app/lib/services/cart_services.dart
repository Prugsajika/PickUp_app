import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cartitem_model.dart';

class CartServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('cart');

  Future<List<CartItem>> get() async {
    QuerySnapshot snapshot = await _collection.get();

    AllCartItems snap = AllCartItems.fromJason(snapshot);

    print('QuerySnapshot ${snap.cartitems.length}');
    return snap.cartitems;
  }

  void addCart(String image, name, Productid, customerId, int quantity, cost,
      price, deliveryFee, totalCost, _paydate, _paytime, confirmPayimg) async {
    FirebaseFirestore.instance.collection('cart').add({
      'cartId': '',
      'image': image,
      'name': name,
      'quantity': quantity,
      'cost': cost,
      'price': price,
      'Productid': Productid,
      'deliveryFee': deliveryFee,
      'totalCost': totalCost,
      'customerId': customerId,
      'paydate': _paydate,
      'paytime': _paytime,
      'confirmPayimg': confirmPayimg,
    }).then((value) =>
        FirebaseFirestore.instance.collection('cart').doc(value.id).update({
          // 'id': value.id,
          'cartId': value.id,
        }));
  }
}
