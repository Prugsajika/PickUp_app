import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/products_model.dart';

class ProductServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('products');
  final user = FirebaseAuth.instance.currentUser!;

  Future<List<Product>> get() async {
    QuerySnapshot snapshot = await _collection
        .where('availableDate',
            isGreaterThanOrEqualTo: DateTime.now().toString())
        .get();

    AllProducts snap = AllProducts.fromSnapshot(snapshot);

    print('QuerySnapshot ${snap.products.length}');
    return snap.products;
  }

  Future<List<Product>> getproductModelInfo(
      String name, description, deliveryLocation, typeOfFood) async {
    QuerySnapshot snapshot = await _collection
        .where('name', isEqualTo: name)
        // .where('description', isEqualTo: description)
        // .where('deliveryLocation', isEqualTo: deliveryLocation)
        // .where('typeOfFood', isEqualTo: typeOfFood)
        .get();
    AllProducts snap = AllProducts.fromSnapshot(snapshot);
    return snap.products;
  }

  // Future<List<Product>> getbyuser() async {
  //   QuerySnapshot snapshot =
  //       await _collection.where('email', isEqualTo: user.email!).get();

  //   AllProducts snap = AllProducts.fromSnapshot(snapshot);

  //   print('QuerySnapshot ${snap.products.length}');
  //   return snap.products;
  // }

  // void addProduct(String name, description, UrlPd, deliveryLocation, email,
  //     typeOfFood, sentDate, sentTime, int price, stock, deliveryFee) async {
  //   FirebaseFirestore.instance.collection('products').add({
  //     // 'id': "",
  //     'name': name,
  //     'description': description,
  //     'UrlPd': UrlPd,
  //     'deliveryLocation': deliveryLocation,
  //     'email': email,
  //     'typeOfFood': typeOfFood,
  //     'sentDate': sentDate,
  //     'sentTime': sentTime,
  //     'price': price,
  //     'stock': stock,
  //     'deliveryFee': deliveryFee,
  //     'productStatus': true,
  //   }).then((value) =>
  //       FirebaseFirestore.instance.collection('products').doc(value.id).update({
  //         'Productid': value.id,
  //       }));
  // }

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
