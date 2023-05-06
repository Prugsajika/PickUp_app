import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartItem {
  // static const CARTID = "cartId";
  // static const IMAGE = "image";
  // static const NAME = "name";
  // static const QUANTITY = "quantity";
  // static const COST = "cost";
  // static const PRICE = "price";
  // static const PRODUCT_ID = "productId";

  late String cartId;
  late String image;
  late String name;
  late int quantity;
  late int cost;
  late int price;
  late String Productid;
  late String customerId;
  late int deliveryFee;
  late int totalCost;
  late String UrlQr;

  CartItem(
      this.cartId,
      this.image,
      this.name,
      this.quantity,
      this.cost,
      this.price,
      this.Productid,
      this.customerId,
      this.deliveryFee,
      this.totalCost,
      this.UrlQr);

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      json['cartId'] as String,
      json['image'] as String,
      json['name'] as String,
      json['quantity'] as int,
      json['cost'] as int,
      json['price'] as int,
      json['Productid'] as String,
      json['customerId'] as String,
      json['deliveryFee'] as int,
      json['totalCost'] as int,
      json['UrlQr'] as String,
    );
  }

  // CartItem.fromMap(Map<String, dynamic> data) {
  //   cartId = data[CARTID];
  //   image = data[IMAGE];
  //   name = data[NAME];
  //   quantity = data[QUANTITY];
  //   cost = data[COST].toDouble();
  //   Productid = data[PRODUCT_ID];
  //   price = data[PRICE].toDouble();
  // }
  // Map toJson() => {
  //       CARTID: cartId,
  //       PRODUCT_ID: Productid,
  //       IMAGE: image,
  //       NAME: name,
  //       QUANTITY: quantity,
  //       COST: price * quantity,
  //       PRICE: price
  //     };
}

class AllCartItems extends ChangeNotifier {
  final List<CartItem> cartitems;

  AllCartItems(this.cartitems);

  factory AllCartItems.fromJason(QuerySnapshot s) {
    List<CartItem> cartitems = s.docs.map((DocumentSnapshot ds) {
      CartItem cartitem = CartItem.fromJson(ds.data() as Map<String, dynamic>);
      cartitem.cartId = ds
          .id; //after mapping from firevase can insert or replace value before return list
      return cartitem;
    }).toList();
    return AllCartItems(cartitems);
  }
}

class CartItemModel extends ChangeNotifier {
  String cartId = '';
  String image = '';
  String name = '';
  int quantity = 0;
  int cost = 0;
  int price = 0;
  String Productid = '';
  String customerId = '';
  int deliveryFee = 0;
  int totalCost = 0;
  String UrlQr = '';

  get getcartId => this.cartId;
  set setcartId(value) {
    this.cartId = value;
    notifyListeners();
  }

  get getimage => this.image;
  set setimage(value) {
    this.image = value;
    notifyListeners();
  }

  get getname => this.name;
  set setname(value) {
    this.name = value;
    notifyListeners();
  }

  get getquantity => this.quantity;
  set setquantity(value) {
    this.quantity = value;
    notifyListeners();
  }

  get getcost => this.cost;
  set setcost(value) {
    this.cost = value;
    notifyListeners();
  }

  get getprice => this.price;
  set setprice(value) {
    this.price = value;
    notifyListeners();
  }

  get getProductid => this.Productid;
  set setProductid(value) {
    this.Productid = value;
    notifyListeners();
  }

  get getcustomerId => this.customerId;
  set setcustomerId(value) {
    this.customerId = value;
    notifyListeners();
  }

  get getdeliveryFee => this.deliveryFee;
  set setdeliveryFee(value) {
    this.deliveryFee = value;
    notifyListeners();
  }

  get gettotalCost => this.totalCost;
  set settotalCost(value) {
    this.totalCost = value;
    notifyListeners();
  }

  get getUrlQr => this.UrlQr;
  set setUrlQr(value) {
    this.UrlQr = value;
    notifyListeners();
  }

  // void decreaseItem(CartItem cartModel) {
  //   if (cartItems[cartItems.indexOf(cartModel)].quantity <= 1) {
  //     return;
  //   }
  //   cartItems[cartItems.indexOf(cartModel)].quantity--;
  //   notifyListeners();
  // }
}
