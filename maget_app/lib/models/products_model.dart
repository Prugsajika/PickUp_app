import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String Productid;
  late String name;
  late String description;
  late int price;
  late String UrlPd;
  late int stock;
  late DateTime endDate;
  late TimeOfDay endTime;
  late DateTime currentDate;
  late TimeOfDay currentTime;
  late String deliveryLocation;
  late int deliveryFee;
  // bool includeFeeInPrice;
  late String sentDate;
  late String sentTime;
  late String typeOfFood;
  bool productStatus;
  late String email;
  late String UrlQr;
  late String availableDate;
  late String availableTime;

  Product(
      this.Productid,
      this.UrlPd,
      this.name,
      this.description,
      this.price,
      this.productStatus,
      this.typeOfFood,
      this.deliveryFee,
      // this.includeFeeInPrice,
      // this.currentDate,
      this.deliveryLocation,
      // this.currentTime,
      this.sentDate,
      this.sentTime,
      // this.endDate,
      // this.endTime,
      this.stock,
      this.email,
      this.UrlQr,
      this.availableDate,
      this.availableTime);

  factory Product.fromJason(Map<String, dynamic> json) {
    return Product(
      json['Productid'] as String,
      json['UrlPd'] as String,
      json['name'] as String,
      json['description'] as String,
      json['price'] as int,
      json['productStatus'] as bool,
      json['typeOfFood'] as String,
      json['deliveryFee'] as int,
      // json['includeFeeInPrice'] as bool,
      // json['currentDate'] as DateTime,
      json['deliveryLocation'] as String,
      // json['currentTime'] as TimeOfDay,
      json['sentDate'] as String,
      json['sentTime'] as String,
      // json['endDate'] as DateTime,
      // json['endTime'] as TimeOfDay,
      json['stock'] as int,
      json['email'] as String,
      json['UrlQr'] as String, json['availableDate'] as String,
      json['availableTime'] as String,
    );
  }
}

class AllProducts {
  final List<Product> products;

  AllProducts(this.products);
  factory AllProducts.fromSnapshot(QuerySnapshot s) {
    List<Product> products = s.docs.map((DocumentSnapshot ds) {
      Product product = Product.fromJason(ds.data() as Map<String, dynamic>);
      product.Productid = ds.id;
      print(product.Productid);
      return product;
    }).toList();
    print(products.length);
    return AllProducts(products);
  }
}

class ProductModel extends ChangeNotifier {
  String Productid = '';
  String UrlPd = '';
  String name = '';
  String description = '';
  String deliveryLocation = '';
  String email = '';
  String typeOfFood = '';
  String sentDate = '';
  String sentTime = '';
  late int price = 0;
  late int stock = 0;
  late int deliveryFee = 0;
  String UrlQr = '';
  String availableDate = '';
  String availableTime = '';

  get getProductid => this.Productid;
  set setProductid(value) {
    this.Productid = value;
    notifyListeners();
  }

  get getUrlPd => this.UrlPd;
  set setUrlPd(value) {
    this.UrlPd = value;
    notifyListeners();
  }

  get getname => this.name;
  set setname(value) {
    this.name = value;
    notifyListeners();
  }

  get getdescription => this.description;
  set setdescription(value) {
    this.description = value;
    notifyListeners();
  }

  get getdeliveryLocation => this.deliveryLocation;
  set setdeliveryLocation(value) {
    this.deliveryLocation = value;
    notifyListeners();
  }

  get getemail => this.email;
  set setemail(value) {
    this.email = value;
    notifyListeners();
  }

  get gettypeOfFood => this.typeOfFood;
  set settypeOfFood(value) {
    this.typeOfFood = value;
    notifyListeners();
  }

  get getsentDate => this.sentDate;
  set setsentDate(value) {
    this.sentDate = value;
    notifyListeners();
  }

  get getsentTime => this.sentTime;
  set setsentTime(value) {
    this.sentTime = value;
    notifyListeners();
  }

  get getprice => this.price;
  set setprice(value) {
    this.price = value;
    notifyListeners();
  }

  get getstock => this.stock;
  set setstock(value) {
    this.stock = value;
    notifyListeners();
  }

  get getdeliveryFee => this.deliveryFee;
  set setdeliveryFee(value) {
    this.deliveryFee = value;
    notifyListeners();
  }

  get getdUrlQr => this.UrlQr;
  set setUrlQr(value) {
    this.UrlQr = value;
    notifyListeners();
  }

  get getavailableDate => this.availableDate;
  set setavailableDate(value) {
    this.availableDate = value;
    notifyListeners();
  }

  get getavailableTime => this.availableTime;
  set setavailableTime(value) {
    this.availableTime = value;
    notifyListeners();
  }

  List<Product> _listProduct = List.empty();
  List<Product> get getListProduct => this._listProduct;

  set getListProduct(List<Product> value) {
    this._listProduct = value;
    notifyListeners();
  }

  // get getPassword => this.Password;
  // set setPassword(value) {
  //   this.Password = value;
  //   notifyListeners();
  // }
}

// class ListProduct extends ChangeNotifier {
//   List<Product> _listProduct = List.empty();
//   List<Product> get getListProduct => this._listProduct;

//   set getListProduct(List<Product> value) {
//     this._listProduct = value;
//     notifyListeners();
//   }

//   // void setListProduct(List<Product> value) {
//   //   _listProduct = value;
//   //   notifyListeners();
//   // }
// }

// class emailProvider extends ChangeNotifier {
//   String email = "";
//   get getemail => this.email;
//   set setemail(value) {
//     this.email = value;
//     notifyListeners();
//   }
// }

class UrlPdProvider extends ChangeNotifier {
  String UrlPd = "";
  get getUrlPd => this.UrlPd;
  set setUrlPd(value) {
    this.UrlPd = value;
    notifyListeners();
  }
}
