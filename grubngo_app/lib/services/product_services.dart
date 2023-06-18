import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/products_model.dart';

class ProductServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('products');
  final user = FirebaseAuth.instance.currentUser!;
  Future<List<Product>> get() async {
    QuerySnapshot snapshot =
        await _collection.where('email', isEqualTo: user.email).get();

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

  Future<List<Product>> getProductInfo(String Productid) async {
    QuerySnapshot snapshot =
        await _collection.where('Productid', isEqualTo: Productid).get();
    AllProducts products = AllProducts.fromSnapshot(snapshot);
    print('getproductinfo ${products.products.length}');
    return products.products;
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

  void updateProduct(
      String UrlPd,
      name,
      typeOfFood,
      description,
      int price,
      stock,
      deliveryFee,
      String sentDate,
      sentTime,
      deliveryLocation,
      availableDate,
      availableTime,
      Productid) async {
    FirebaseFirestore.instance.collection('products').doc(Productid).update({
      'UrlPd': UrlPd,
      'name': name,
      'typeOfFood': typeOfFood,
      'description': description,
      'price': price,
      'stock': stock,
      'deliveryFee': deliveryFee,
      'sentDate': sentDate,
      'sentTime': sentTime,
      'deliveryLocation': deliveryLocation,
      'availableDate': availableDate,
      'availableTime': availableTime,
      'Productid': Productid,
    });
  }

  void deleteProduct(String Productid) async {
    FirebaseFirestore.instance.collection('products').doc(Productid).delete();
  }
}
