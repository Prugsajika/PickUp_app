import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grubngo_app/pages/addproduct_page.dart';

import '../models/products_model.dart';

class ProductServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('products');
  final user = FirebaseAuth.instance.currentUser!;
  Future<List<Product>> get() async {
    QuerySnapshot snapshot = await _collection.get();

    AllProducts snap = AllProducts.fromSnapshot(snapshot);

    print('QuerySnapshot ${snap.products.length}');
    return snap.products;
  }

  Future<List<Product>> getbyuser() async {
    QuerySnapshot snapshot =
        await _collection.where('email', isEqualTo: user.email!).get();

    AllProducts snap = AllProducts.fromSnapshot(snapshot);

    print('QuerySnapshot ${snap.products.length}');
    return snap.products;
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
    FirebaseFirestore.instance.collection('products').add({
      // 'id': "",
      'name': name,
      'description': description,
      'UrlPd': UrlPd,
      'deliveryLocation': deliveryLocation,
      'email': email,
      'typeOfFood': typeOfFood,
      'sentDate': sentDate,
      'sentTime': sentTime,
      'price': price,
      'stock': stock,
      'deliveryFee': deliveryFee,
      'productStatus': true,
      'UrlQr': UrlQr,
      'availableDate': availableDate,
      'availableTime': availableTime,
    }).then((value) =>
        FirebaseFirestore.instance.collection('products').doc(value.id).update({
          'Productid': value.id,
        }));
  }

  // void update(Product item) async {
  //   print("update");
  //   print(item.id);
  //   await _collection.doc(item.id).update({
  //     "name": item.name,
  //     "description": item.description,
  //     "price": item.price,
  //     "stock": item.stock,
  //     "productStatus": item.productStatus,
  //     "deliveryLocation": item.deliveryLocation,
  //   });
  // }

  // void insert(Product item) async {
  //   await _collection.doc().set({
  //     "name": item.name,
  //     "description": item.description,
  //     "price": item.price,
  //     "stock": item.stock,
  //     "productStatus": item.productStatus,
  //     "deliveryLocation": item.deliveryLocation,
  //   });
  // }
}
