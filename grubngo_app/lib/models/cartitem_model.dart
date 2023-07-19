import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartItem {
  late String cartId;
  late String image;
  late String nameProduct;
  late int quantity;
  late int cost;
  late int price;
  late String Productid;
  late String customerId;
  late int deliveryFee;
  late int totalCost;
  late String UrlQr;
  late String confirmPayimg;
  late String paydate;
  late String paytime;
  late String email;
  late String buildName;
  late String roomNo;
  late String status;
  late String availableDate;
  late String availableTime;
  late String emailRider;
  late String sentDate;
  late String sentTime;
  bool productStatus;
  late String orderDate;

  // late String rejectStatus;

  CartItem(
      this.cartId,
      this.image,
      this.nameProduct,
      this.quantity,
      this.cost,
      this.price,
      this.Productid,
      this.customerId,
      this.deliveryFee,
      this.totalCost,
      this.UrlQr,
      this.confirmPayimg,
      this.paydate,
      this.paytime,
      this.email,
      this.buildName,
      this.roomNo,
      this.status,
      this.availableDate,
      this.availableTime,
      this.emailRider,
      this.sentDate,
      this.sentTime,
      this.productStatus,
      this.orderDate
      // this.rejectStatus
      );

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
      json['confirmPayimg'] as String,
      json['paydate'] as String,
      json['paytime'] as String,
      json['email'] as String,
      json['buildName'] as String,
      json['roomNo'] as String,
      json['status'] as String,
      json['availableDate'] as String,
      json['availableTime'] as String,
      json['emailRider'] as String,
      json['sentDate'] as String,
      json['sentTime'] as String,
      json['productStatus'] as bool,
      json['orderDate'] as String,
      // json['rejectStatus'] as String,
    );
  }
}

class AllCartItems extends ChangeNotifier {
  final List<CartItem> cartitems;

  AllCartItems(this.cartitems);
  factory AllCartItems.fromJson(List<dynamic> json) {
    List<CartItem> cartitems;
    cartitems = json.map((index) => CartItem.fromJson(index)).toList();
    return AllCartItems(cartitems);
  }

  factory AllCartItems.fromSnapshot(QuerySnapshot s) {
    List<CartItem> cartitems = s.docs.map((DocumentSnapshot ds) {
      print("documentsnapshot : cartitems ${ds.data()}");
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
  String nameProduct = '';
  int quantity = 0;
  int cost = 0;
  int price = 0;
  String Productid = '';
  String customerId = '';
  int deliveryFee = 0;
  int totalCost = 0;
  String UrlQr = '';
  String confirmPayimg = '';
  String paydate = '';
  String paytime = '';
  String email = '';
  String buildName = '';
  String roomNo = '';
  String status = '';
  String availableDate = '';
  String availableTime = '';
  String emailRider = '';
  String sentDate = '';
  String sentTime = '';
  late bool productStatus;
  String orderDate = '';

  // String rejectStatus = '';

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

  get getnameProduct => this.nameProduct;
  set setnameProduct(value) {
    this.nameProduct = value;
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

  get getconfirmPayimg => this.confirmPayimg;
  set setconfirmPayimg(value) {
    this.confirmPayimg = value;
    notifyListeners();
  }

  get getpaydate => this.paydate;
  set setpaydate(value) {
    this.paydate = value;
    notifyListeners();
  }

  get getpaytime => this.paytime;
  set setpaytime(value) {
    this.paytime = value;
    notifyListeners();
  }

  get getemail => this.email;
  set setemail(value) {
    this.email = value;
    notifyListeners();
  }

  get getbuildName => this.buildName;
  set setbuildName(value) {
    this.buildName = value;
    notifyListeners();
  }

  get getroomNo => this.roomNo;
  set setroomNo(value) {
    this.roomNo = value;
    notifyListeners();
  }

  get getstatus => this.status;
  set setstatus(value) {
    this.status = value;
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

  get getemailRider => this.emailRider;
  set setemailRider(value) {
    this.emailRider = value;
    notifyListeners();
  }

  get getSentDate => this.sentDate;

  set setSentDate(sentDate) => this.sentDate = sentDate;

  get getSentTime => this.sentTime;

  set setSentTime(sentTime) => this.sentTime = sentTime;

  get getProductStatus => this.productStatus;

  set setProductStatus(productStatus) => this.productStatus = productStatus;

  get getOrderDate => this.orderDate;

  set setOrderDate(orderDate) => this.orderDate = orderDate;

  // get getrejectStatus => this.rejectStatus;
  // set setrejectStatus(value) {
  //   this.rejectStatus = value;
  //   notifyListeners();
  // }

  List<CartItem> _listCartItem = List.empty();
  List<CartItem> get getListCartItem => this._listCartItem;

  set getListCartItem(List<CartItem> value) {
    this._listCartItem = value;
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

class CategoriesProduct {
  final String productID;
  late String emailRider;
  late int Sumquantity;
  late String nameProduct;
  late int price;
  CategoriesProduct(this.productID, this.emailRider, this.Sumquantity,
      this.nameProduct, this.price);

  factory CategoriesProduct.fromJson(Map<String, dynamic> json) {
    return CategoriesProduct(
      json['productID'],
      json['emailRider'],
      json['quantity'],
      json['name'],
      json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = productID;
    data['emailRider'] = emailRider;
    data['quantity'] = Sumquantity;
    data['name'] = nameProduct;
    data['price'] = price;
    return data;
  }

  static List<CategoriesProduct> parseApplList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<CategoriesProduct> listData = parsed
        .map<CategoriesProduct>((json) => CategoriesProduct.fromJson(json))
        .toList();
    return listData;
  }
}

class CountCartItem {
  late String cartId;
  late String image;
  late String nameProduct;
  late int quantity;
  late int cost;
  late int price;
  late String Productid;
  late String customerId;
  late int deliveryFee;
  late int totalCost;
  late String UrlQr;
  late String confirmPayimg;
  late String paydate;
  late String paytime;
  late String email;
  late String buildName;
  late String roomNo;
  late String status;
  late String availableDate;
  late String availableTime;
  late String emailRider;
  // late String rejectStatus;

  CountCartItem(
    this.cartId,
    this.image,
    this.nameProduct,
    this.quantity,
    this.cost,
    this.price,
    this.Productid,
    this.customerId,
    this.deliveryFee,
    this.totalCost,
    this.UrlQr,
    this.confirmPayimg,
    this.paydate,
    this.paytime,
    this.email,
    this.buildName,
    this.roomNo,
    this.status,
    this.availableDate,
    this.availableTime,
    this.emailRider,
    // this.rejectStatus
  );

  factory CountCartItem.fromJson(Map<String, dynamic> json) {
    return CountCartItem(
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
      json['confirmPayimg'] as String,
      json['paydate'] as String,
      json['paytime'] as String,
      json['email'] as String,
      json['buildName'] as String,
      json['roomNo'] as String,
      json['status'] as String,
      json['availableDate'] as String,
      json['availableTime'] as String,
      json['emailRider'] as String,
      // json['rejectStatus'] as String,
    );
  }
}

class AllCountCartItem extends ChangeNotifier {
  final List<CountCartItem> countcartitems;

  AllCountCartItem(this.countcartitems);
  factory AllCountCartItem.fromJson(List<dynamic> json) {
    List<CountCartItem> countcartitems;
    countcartitems =
        json.map((index) => CountCartItem.fromJson(index)).toList();
    return AllCountCartItem(countcartitems);
  }

  factory AllCountCartItem.fromSnapshot(QuerySnapshot s) {
    List<CountCartItem> countcartitems = s.docs.map((DocumentSnapshot ds) {
      print("documentsnapshot : cartitems ${ds.data()}");
      CountCartItem cartitem =
          CountCartItem.fromJson(ds.data() as Map<String, dynamic>);
      cartitem.cartId = ds
          .id; //after mapping from firevase can insert or replace value before return list
      return cartitem;
    }).toList();
    return AllCountCartItem(countcartitems);
  }
}

class CountCartItemModel extends ChangeNotifier {
  String cartId = '';
  String image = '';
  String nameProduct = '';
  int quantity = 0;
  int cost = 0;
  int price = 0;
  String Productid = '';
  String customerId = '';
  int deliveryFee = 0;
  int totalCost = 0;
  String UrlQr = '';
  String confirmPayimg = '';
  String paydate = '';
  String paytime = '';
  String email = '';
  String buildName = '';
  String roomNo = '';
  String status = '';
  String availableDate = '';
  String availableTime = '';
  String emailRider = '';
  // String rejectStatus = '';

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

  get getnameProduct => this.nameProduct;
  set setnameProduct(value) {
    this.nameProduct = value;
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

  get getconfirmPayimg => this.confirmPayimg;
  set setconfirmPayimg(value) {
    this.confirmPayimg = value;
    notifyListeners();
  }

  get getpaydate => this.paydate;
  set setpaydate(value) {
    this.paydate = value;
    notifyListeners();
  }

  get getpaytime => this.paytime;
  set setpaytime(value) {
    this.paytime = value;
    notifyListeners();
  }

  get getemail => this.email;
  set setemail(value) {
    this.email = value;
    notifyListeners();
  }

  get getbuildName => this.buildName;
  set setbuildName(value) {
    this.buildName = value;
    notifyListeners();
  }

  get getroomNo => this.roomNo;
  set setroomNo(value) {
    this.roomNo = value;
    notifyListeners();
  }

  get getstatus => this.status;
  set setstatus(value) {
    this.status = value;
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

  get getemailRider => this.emailRider;
  set setemailRider(value) {
    this.emailRider = value;
    notifyListeners();
  }

  // get getrejectStatus => this.rejectStatus;
  // set setrejectStatus(value) {
  //   this.rejectStatus = value;
  //   notifyListeners();
  // }

  List<CountCartItem> _listCountCartItem = List.empty();
  List<CountCartItem> get getListCountCartItem => this._listCountCartItem;

  set getListCountCartItem(List<CountCartItem> value) {
    this._listCountCartItem = value;
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

class SumCartItemAllModel with ChangeNotifier {
  int statusNotComplete = 0;
  int statusComplete = 0;
  int totalCost = 0;
  get getStatusNotComplete => this.statusNotComplete;

  set setStatusNotComplete(statusNotComplete) =>
      this.statusNotComplete = statusNotComplete;

  get getStatusComplete => this.statusComplete;

  set setStatusComplete(statusComplete) => this.statusComplete = statusComplete;

  get getTotalCost => this.totalCost;

  set setTotalCost(totalCost) => this.totalCost = totalCost;
}
