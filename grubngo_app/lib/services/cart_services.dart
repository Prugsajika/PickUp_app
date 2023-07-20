import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cartitem_model.dart';

class CartServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('cart');
  final user = FirebaseAuth.instance.currentUser!;

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

  Future<List<CartItemPerProduct>> getOrderByProductWithCFPay() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('emailRider', isEqualTo: user.email)
        .where('status', isEqualTo: 'ยืนยันสลิปแล้ว')
        .get();

    AllCartItemPerProduct cartitemperproducts =
        AllCartItemPerProduct.fromSnapshot(snapshot);
    print("cartitems  $cartitemperproducts");
    return cartitemperproducts.cartitemperproducts;
  }

  Future<List<CountCartItem>> getCartItemsAll() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('emailRider', isEqualTo: user.email)
        .get();

    AllCountCartItem countcartitems = AllCountCartItem.fromSnapshot(snapshot);
    print("cartitems  $countcartitems");
    return countcartitems.countcartitems;
  }

  Future<List<CartItemPerProduct>> getOrderByProductid(Productid) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('Productid', isEqualTo: Productid)
        .where('status', isEqualTo: 'ยืนยันสลิปแล้ว')
        .get();

    AllCartItemPerProduct cartitemperproducts =
        AllCartItemPerProduct.fromSnapshot(snapshot);
    print("cartitems  $cartitemperproducts");
    return cartitemperproducts.cartitemperproducts;
  }

  // รอเปลี่ยน status to "สำเร็จ"
  Future<List<CartItem>> getCartItemsSuccessByEmail(String emailRider) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('emailRider', isEqualTo: emailRider.toLowerCase().toString())
        .where('status', isEqualTo: "ยืนยันสลิปแล้ว")
        .get();

    AllCartItems cartitems = AllCartItems.fromSnapshot(snapshot);
    print("cartitems  $cartitems");
    return cartitems.cartitems;
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
