import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:grubngo_app/models/products_model.dart';
import 'package:grubngo_app/models/riderinfo_model.dart';

import '../models/cartitem_model.dart';
import '../models/report_model.dart';

class ReportServices {
  final CollectionReference _collectionCart =
      FirebaseFirestore.instance.collection('cart');

  final CollectionReference _collectionRider =
      FirebaseFirestore.instance.collection('rider');

  final CollectionReference _collectionProduct =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference _collectionCustomer =
      FirebaseFirestore.instance.collection('customer');

  final user = FirebaseAuth.instance.currentUser!;

  DateFormat dateFormat = DateFormat("dd/MM/yyy");

  Future<List<CartItem>> getReportCartItem() async {
    QuerySnapshot snapshot = await _collectionCart.get();

    AllCartItems snap = AllCartItems.fromSnapshot(snapshot);

    return snap.cartitems;
  }

  Future<List<CartItem>> getReportCartItemByEmail(String emailRider) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('emailRider', isEqualTo: emailRider.toLowerCase().toString())
        .get();

    AllCartItems cartitems = AllCartItems.fromSnapshot(snapshot);

    return cartitems.cartitems;
  }

  Future<List<Rider>> getReportRider() async {
    QuerySnapshot snapshot = await _collectionRider.get();

    AllRiders snap = AllRiders.fromSnapshot(snapshot);

    return snap.riders;
  }

  Future<List<ReportCustomer>> getReportCustomer() async {
    QuerySnapshot snapshot = await _collectionCustomer.get();

    AllCustomers snap = AllCustomers.fromSnapshot(snapshot);

    return snap.customers;
  }

  Future<List<Product>> getReportProductActivate() async {
    QuerySnapshot snapshot = await _collectionProduct
        .where('availableDate',
            isGreaterThanOrEqualTo: dateFormat.format(DateTime.now()))
        .get();

    AllProducts snap = AllProducts.fromSnapshot(snapshot);

    return snap.products;
  }

  Future<List<Product>> getReportProductNotActivate() async {
    QuerySnapshot snapshot = await _collectionProduct
        .where('availableDate', isLessThan: dateFormat.format(DateTime.now()))
        .get();

    AllProducts snap = AllProducts.fromSnapshot(snapshot);

    return snap.products;
  }

  Future<List<Product>> getReportProductAll() async {
    QuerySnapshot snapshot = await _collectionProduct.get();

    AllProducts snap = AllProducts.fromSnapshot(snapshot);

    return snap.products;
  }
}
