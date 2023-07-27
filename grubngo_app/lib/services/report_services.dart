import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/cartitem_model.dart';

class ReportServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('cart');
  final user = FirebaseAuth.instance.currentUser!;

  Future<List<CartItem>> getReport() async {
    QuerySnapshot snapshot = await _collection.get();

    AllCartItems snap = AllCartItems.fromSnapshot(snapshot);

    print('QuerySnapshot ${snap.cartitems.length}');
    return snap.cartitems;
  }

  Future<List<CartItem>> getReportByEmail(String emailRider) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('emailRider', isEqualTo: emailRider.toLowerCase().toString())
        .get();

    AllCartItems cartitems = AllCartItems.fromSnapshot(snapshot);
    print("cartitems  $cartitems");
    return cartitems.cartitems;
  }

  // void updatePaystatus(String cartId, status) async {
  //   FirebaseFirestore.instance.collection('cart').doc(cartId).update({
  //     'cartId': cartId,
  //     'status': status,
  //   });
  //   print('cartId for service$cartId');
  // }

  // Future<List<CartItem>> getOrderByProductWithCFPay() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('cart')
  //       .where('emailRider', isEqualTo: user.email)
  //       .where('status', isEqualTo: 'ยืนยันสลิปแล้ว')
  //       .get();

  //   AllCartItems cartitems = AllCartItems.fromSnapshot(snapshot);
  //   print("cartitems  $cartitems");
  //   return cartitems.cartitems;
  // }

  // Future<List<CartItem>> getCartItemsAll() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('cart')
  //       .where('emailRider', isEqualTo: user.email)
  //       .get();

  //   AllCartItems cartitems = AllCartItems.fromSnapshot(snapshot);
  //   print("cartitems  $cartitems");
  //   return cartitems.cartitems;
  // }

  // Future<List<CartItem>> getOrderByProductid(Productid) async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('cart')
  //       .where('Productid', isEqualTo: Productid)
  //       .where('status', isEqualTo: 'ยืนยันสลิปแล้ว')
  //       .get();

  //   AllCartItems cartitems = AllCartItems.fromSnapshot(snapshot);
  //   print("cartitems  $cartitems");
  //   return cartitems.cartitems;
  // }

  // // รอเปลี่ยน status to "สำเร็จ"
  // Future<List<CartItem>> getCartItemsSuccessByEmail(String emailRider) async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('cart')
  //       .where('emailRider', isEqualTo: emailRider.toLowerCase().toString())
  //       .where('status', isEqualTo: "จัดส่งสำเร็จ")
  //       .get();

  //   AllCartItems cartitems = AllCartItems.fromSnapshot(snapshot);
  //   print("cartitems  $cartitems");
  //   return cartitems.cartitems;
  // }

  // // รอเปลี่ยน status to "รอจัดส่ง"
  // Future<List<CartItem>> getCartItemsWaitByEmail(String emailRider) async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('cart')
  //       .where('emailRider', isEqualTo: emailRider.toLowerCase().toString())
  //       .where('status', isEqualTo: "รอจัดส่ง")
  //       .get();

  //   AllCartItems cartitems = AllCartItems.fromSnapshot(snapshot);
  //   print("cartitems  $cartitems");
  //   return cartitems.cartitems;
  // }

  // void updateRefundPayment(
  //   String cartId,
  //   refundStatus,
  //   _refunddate,
  //   _refundtime,
  //   refundPayimg,
  // ) async {
  //   FirebaseFirestore.instance.collection('cart').doc(cartId).update({
  //     'cartId': cartId,
  //     'refundStatus': refundStatus,
  //     'paydate': _refunddate,
  //     'paytime': _refundtime,
  //     'confirmPayimg': refundPayimg,
  //   });
  //   print('cartId for service$cartId');
  // }
}
