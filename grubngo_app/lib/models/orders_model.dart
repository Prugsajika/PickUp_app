// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Product {
//   late String orderID;
//   // late String productimagePath;
//   // late String productName;
//   // late String productDetail;
//   // late int productPrice;
//   // late int Qty;
//   // late int Fee;
//   // bool productAvailable;
//   // bool priceTotal;
//   // late String foodType;
//   // late DateTime deliveryDate;
//   // late String deliveryTime;
//   // late DateTime orderDate;
//   // late String orderTime;
//   // late String deliveryLocation;

//   Product(
//     this.orderID,
//     // this.productimagePath,
//     // this.productName,
//     // this.productDetail,
//     // this.productPrice,
//     // this.Qty,
//     // this.productAvailable,
//     // this.foodType,
//     // this.Fee,
//     // this.priceTotal,
//     // this.deliveryDate,
//     // this.deliveryLocation,
//     // this.deliveryTime,
//     // this.orderDate,
//     // this.orderTime,
//   );

//   factory Product.fromJason(Map<String, dynamic> json) {
//     return Product(
//       json['orderID'] as String,
//       // json['productimagePath'] as String,
//       // json['productName'] as String,
//       // json['productDetail'] as String,
//       // json['productPrice'] as int,
//       // json['Qty'] as int,
//       // json['productAvailable'] as bool,
//       // json['foodType'] as String,
//       // json['Fee'] as int,
//       // json['priceTotal'] as bool,
//       // json['deliveryDate'] as DateTime,
//       // json['deliveryLocation'] as String,
//       // json['deliveryTime'] as String,
//       // json['orderDate'] as DateTime,
//       // json['orderTime'] as String,
//     );
//   }
// }

// class AllProducts {
//   final List<Product> products;

//   AllProducts(this.products);
//   factory AllProducts.fromJson(QuerySnapshot s) {
//     List<Product> products = s.docs.map((DocumentSnapshot ds) {
//       Product product = Product.fromJason(ds.data() as Map<String, dynamic>);
//       product.orderID = ds.id;
//       print(product.orderID);
//       return product;
//     }).toList();
//     print(products.length);
//     return AllProducts(products);
//   }
// }

// class OrderModel extends ChangeNotifier {
//   String ProductID = '';
//   // String ProductimagePath = '';
//   // String ProductName = '';
//   // String ProductDetail = '';
//   // String ProductPrice = '';
//   // String Qty = '';
//   // String Password = '';

//   // get getProductID => this.ProductID;
//   // set setProductID(value) {
//   //   this.ProductID = value;
//   //   notifyListeners();
//   // }

//   // get getProductimagePath => this.ProductimagePath;
//   // set setProductimagePath(value) {
//   //   this.ProductimagePath = value;
//   //   notifyListeners();
//   // }

//   // get getProductName => this.ProductName;
//   // set setProductName(value) {
//   //   this.ProductName = value;
//   //   notifyListeners();
//   // }

//   // get getProductDetail => this.ProductDetail;
//   // set setProductDetail(value) {
//   //   this.ProductDetail = value;
//   //   notifyListeners();
//   // }

//   // get getProductPrice => this.ProductPrice;
//   // set setProductPrice(value) {
//   //   this.ProductPrice = value;
//   //   notifyListeners();
//   // }

//   // get getQty => this.Qty;
//   // set setQty(value) {
//   //   this.Qty = value;
//   //   notifyListeners();
//   // }

//   // get getPassword => this.Password;
//   // set setPassword(value) {
//   //   this.Password = value;
//   //   notifyListeners();
//   // }
// }

// class ListProduct extends ChangeNotifier {
//   List<Product> _listProduct = List.empty();
//   List<Product> get getListProduct => _listProduct;

//   void setListProduct(List<Product> value) {
//     _listProduct = value;
//     notifyListeners();
//   }
// }
