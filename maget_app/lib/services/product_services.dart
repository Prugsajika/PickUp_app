import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/products_model.dart';

class ProductServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('products');

  DateFormat dateFormat = DateFormat('yyyy/MM/dd');

  Future<List<Product>> get() async {
    QuerySnapshot snapshot = await _collection
        .where('availableDate',
            isGreaterThanOrEqualTo: dateFormat.format(DateTime.now()))
        .get();

    print('active product${snapshot.docs.length}');
    print('active product${dateFormat.format(DateTime.now())}');

    AllProducts snap = AllProducts.fromSnapshot(snapshot);

    print('QuerySnapshot ${snap.products.length}');
    return snap.products;
  }

  Future<List<Product>> getproductModelInfo(
      String name, description, deliveryLocation, typeOfFood) async {
    QuerySnapshot snapshot =
        await _collection.where('name', isEqualTo: name).get();
    AllProducts snap = AllProducts.fromSnapshot(snapshot);
    return snap.products;
  }
}
