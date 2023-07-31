import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cartitem_model.dart';
import 'products_model.dart';
import 'riderinfo_model.dart';

class AdminReportRider extends ChangeNotifier {
  String Riderid = '';

  String FirstName = '';
  String LastName = '';
  String Gender = '';
  String TelNo = '';
  String email = '';
  String Password = '';
  late String idCard;
  String UrlQr = '';
  late bool statusBL;
  String UrlCf = '';
  String role = '';
  String statusApprove = '';

  get getRiderid => this.Riderid;

  set setRiderid(Riderid) => this.Riderid = Riderid;

  get getFirstName => this.FirstName;

  set setFirstName(FirstName) => this.FirstName = FirstName;

  get getLastName => this.LastName;

  set setLastName(LastName) => this.LastName = LastName;

  get getGender => this.Gender;

  set setGender(Gender) => this.Gender = Gender;

  get getTelNo => this.TelNo;

  set setTelNo(TelNo) => this.TelNo = TelNo;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getPassword => this.Password;

  set setPassword(Password) => this.Password = Password;

  get getIdCard => this.idCard;

  set setIdCard(idCard) => this.idCard = idCard;

  get getUrlQr => this.UrlQr;

  set setUrlQr(UrlQr) => this.UrlQr = UrlQr;

  get getStatusBL => this.statusBL;

  set setStatusBL(statusBL) => this.statusBL = statusBL;

  get getUrlCf => this.UrlCf;

  set setUrlCf(UrlCf) => this.UrlCf = UrlCf;

  get getRole => this.role;

  set setRole(role) => this.role = role;

  get getStatusApprove => this.statusApprove;

  set setStatusApprove(statusApprove) => this.statusApprove = statusApprove;

  List<Rider> _listAdminReportRider = List.empty();
  List<Rider> get getListAdminReportRider => this._listAdminReportRider;

  set getListAdminReportRider(List<Rider> value) {
    this._listAdminReportRider = value;
    notifyListeners();
  }
}

class ReportCustomer {
  late String customerId;
  // late String id;
  late String name;
  late String lastName;
  late String Gender;
  late String profilePicture;
  late String password;
  late String idCard;
  late String telNo;
  late String email;
  late bool status;
  late String role;

  ReportCustomer(
      this.customerId,
      this.name,
      this.lastName,
      this.Gender,
      this.password,
      this.idCard,
      this.telNo,
      this.email,
      this.status,
      this.role);

  factory ReportCustomer.fromJson(Map<String, dynamic> json) {
    return ReportCustomer(
      json['customerId'] as String,
      // json['id'] as String,
      json['name'] as String,
      json['lastName'] as String,
      json['Gender'] as String,
      json['password'] as String,
      json['idCard'] as String,
      json['telNo'] as String,
      json['email'] as String,
      json['status'] as bool,
      json['role'] as String,
    );
  }
}

class AllCustomers {
  final List<ReportCustomer> customers;

  AllCustomers(this.customers);

  factory AllCustomers.fromJson(List<dynamic> json) {
    List<ReportCustomer> customers;

    customers = json.map((index) => ReportCustomer.fromJson(index)).toList();

    return AllCustomers(customers);
  }

  factory AllCustomers.fromSnapshot(QuerySnapshot s) {
    List<ReportCustomer> customers = s.docs.map((DocumentSnapshot ds) {
      ReportCustomer customer =
          ReportCustomer.fromJson(ds.data() as Map<String, dynamic>);
      customer.customerId = ds
          .id; //after mapping from firevase can insert or replace value before return list
      return customer;
    }).toList();
    return AllCustomers(customers);
  }
}

class AdminReportCustomer with ChangeNotifier {
  late String customerId = '';
  // late String id = '';
  String name = '';
  String lastName = '';
  String birthDay = '';
  String email = '';
  String profilePicture = '';
  String password = '';
  String idCard = '';
  String telNo = '';
  late bool status = false;
  String role = '';
  String Gender = '';

  // get getId => this.id;
  // set setId(value) {
  //   this.id = value;
  //   notifyListeners();
  // }

  get getCustomerId => this.customerId;
  set setCustomerId(value) {
    this.customerId = value;
    notifyListeners();
  }

  get getStatus => this.status;
  set setStatus(value) {
    this.status = value;
    notifyListeners();
  }

  get getName => this.name;
  set setName(value) {
    this.name = value;
    notifyListeners();
  }

  get getLastName => this.lastName;
  set setLastName(value) {
    this.lastName = value;
    notifyListeners();
  }

  get getBirthDay => this.birthDay;
  set setbirthDay(value) {
    this.birthDay = value;
    notifyListeners();
  }

  get getEmail => this.email;
  set setEmail(value) {
    this.email = value;
    notifyListeners();
  }

  // get getProfilePicture => this.profilePicture;
  // set setProfilePicture(value) {
  //   this.profilePicture = value;
  //   notifyListeners();
  // }

  get getPassword => this.password;
  set setPassword(value) {
    this.password = value;
    notifyListeners();
  }

  get getIDCard => this.idCard;
  set setDCard(value) {
    this.idCard = value;
    notifyListeners();
  }

  get getTelNo => this.telNo;
  set setTelNo(value) {
    this.telNo = value;
    notifyListeners();
  }

  get getrole => this.role;
  set setrole(value) {
    this.role = value;
    notifyListeners();
  }

  get getGender => this.Gender;
  set setGender(value) {
    this.Gender = value;
    notifyListeners();
  }

  List<ReportCustomer> _listAdminReportCustomer = List.empty();
  List<ReportCustomer> get getListAdminReportCustomer =>
      this._listAdminReportCustomer;

  set getListAdminReportCustomer(List<ReportCustomer> value) {
    this._listAdminReportCustomer = value;
    notifyListeners();
  }
}

class AdminReportProductActive extends ChangeNotifier {
  String Productid = '';
  String UrlPd = '';
  String name = '';
  String description = '';
  String deliveryLocation = '';
  String email = '';
  String typeOfFood = '';
  String sentDate = '';
  String sentTime = '';
  late int price;
  late int stock;
  late int deliveryFee;
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

  get getUrlQr => this.UrlQr;
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

  List<Product> _listAdminReportProductActive = List.empty();
  List<Product> get getListAdminReportProductActive =>
      this._listAdminReportProductActive;

  set getListAdminReportProductActive(List<Product> value) {
    this._listAdminReportProductActive = value;
    notifyListeners();
  }
}

class AdminReportProductNotActive extends ChangeNotifier {
  String Productid = '';
  String UrlPd = '';
  String name = '';
  String description = '';
  String deliveryLocation = '';
  String email = '';
  String typeOfFood = '';
  String sentDate = '';
  String sentTime = '';
  late int price;
  late int stock;
  late int deliveryFee;
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

  get getUrlQr => this.UrlQr;
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

  List<Product> _listAdminReportProductNotActive = List.empty();
  List<Product> get getListAdminReportProductNotActive =>
      this._listAdminReportProductNotActive;

  set getListAdminReportProductNotActive(List<Product> value) {
    this._listAdminReportProductNotActive = value;
    notifyListeners();
  }
}

class AdminReportProductAll extends ChangeNotifier {
  String Productid = '';
  String UrlPd = '';
  String name = '';
  String description = '';
  String deliveryLocation = '';
  String email = '';
  String typeOfFood = '';
  String sentDate = '';
  String sentTime = '';
  late int price;
  late int stock;
  late int deliveryFee;
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

  get getUrlQr => this.UrlQr;
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

  List<Product> _listAdminReportProductAll = List.empty();
  List<Product> get getListAdminReportProductAll =>
      this._listAdminReportProductAll;

  set getListAdminReportProductAll(List<Product> value) {
    this._listAdminReportProductAll = value;
    notifyListeners();
  }
}

class ReportCartItem extends ChangeNotifier {
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

  String deliveryLocation = '';
  String promtPay = '';
  get getPromtPay => this.promtPay;

  set setPromtPay(promtPay) => this.promtPay = promtPay;

  String refundStatus = '';
  get getRefundStatus => this.refundStatus;

  set setRefundStatus(refundStatus) => this.refundStatus = refundStatus;

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

  get getdeliveryLocation => this.deliveryLocation;
  set setdeliveryLocation(value) {
    this.deliveryLocation = value;
    notifyListeners();
  }

  List<CartItem> _listReportCartItem = List.empty();
  List<CartItem> get getListReportCartItem => this._listReportCartItem;

  set getListReportCartItem(List<CartItem> value) {
    this._listReportCartItem = value;
    notifyListeners();
  }
}

class AdminReportCartItem extends ChangeNotifier {
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

  String deliveryLocation = '';
  String promtPay = '';
  get getPromtPay => this.promtPay;

  set setPromtPay(promtPay) => this.promtPay = promtPay;

  String refundStatus = '';
  get getRefundStatus => this.refundStatus;

  set setRefundStatus(refundStatus) => this.refundStatus = refundStatus;

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

  get getdeliveryLocation => this.deliveryLocation;
  set setdeliveryLocation(value) {
    this.deliveryLocation = value;
    notifyListeners();
  }

  List<CartItem> _listAdminReportCartItem = List.empty();
  List<CartItem> get getListAdminReportCartItem =>
      this._listAdminReportCartItem;

  set getListAdminReportCartItem(List<CartItem> value) {
    this._listAdminReportCartItem = value;
    notifyListeners();
  }
}

class AdminOrderSuccessSentStatus extends ChangeNotifier {
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
  String deliveryLocation = '';

  String promtPay = '';
  get getPromtPay => this.promtPay;

  set setPromtPay(promtPay) => this.promtPay = promtPay;

  String refundStatus = '';
  get getRefundStatus => this.refundStatus;

  set setRefundStatus(refundStatus) => this.refundStatus = refundStatus;

  get getCartId => this.cartId;

  set setCartId(cartId) => this.cartId = cartId;

  get getImage => this.image;

  set setImage(image) => this.image = image;

  get getNameProduct => this.nameProduct;

  set setNameProduct(nameProduct) => this.nameProduct = nameProduct;

  get getQuantity => this.quantity;

  set setQuantity(quantity) => this.quantity = quantity;

  get getCost => this.cost;

  set setCost(cost) => this.cost = cost;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getProductid => this.Productid;

  set setProductid(Productid) => this.Productid = Productid;

  get getCustomerId => this.customerId;

  set setCustomerId(customerId) => this.customerId = customerId;

  get getDeliveryFee => this.deliveryFee;

  set setDeliveryFee(deliveryFee) => this.deliveryFee = deliveryFee;

  get getTotalCost => this.totalCost;

  set setTotalCost(totalCost) => this.totalCost = totalCost;

  get getUrlQr => this.UrlQr;

  set setUrlQr(UrlQr) => this.UrlQr = UrlQr;

  get getConfirmPayimg => this.confirmPayimg;

  set setConfirmPayimg(confirmPayimg) => this.confirmPayimg = confirmPayimg;

  get getPaydate => this.paydate;

  set setPaydate(paydate) => this.paydate = paydate;

  get getPaytime => this.paytime;

  set setPaytime(paytime) => this.paytime = paytime;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getBuildName => this.buildName;

  set setBuildName(buildName) => this.buildName = buildName;

  get getRoomNo => this.roomNo;

  set setRoomNo(roomNo) => this.roomNo = roomNo;

  get getStatus => this.status;

  set setStatus(status) => this.status = status;

  get getAvailableDate => this.availableDate;

  set setAvailableDate(availableDate) => this.availableDate = availableDate;

  get getAvailableTime => this.availableTime;

  set setAvailableTime(availableTime) => this.availableTime = availableTime;

  get getEmailRider => this.emailRider;

  set setEmailRider(emailRider) => this.emailRider = emailRider;

  get getSentDate => this.sentDate;

  set setSentDate(sentDate) => this.sentDate = sentDate;

  get getSentTime => this.sentTime;

  set setSentTime(sentTime) => this.sentTime = sentTime;

  get getProductStatus => this.productStatus;

  set setProductStatus(productStatus) => this.productStatus = productStatus;

  get getOrderDate => this.orderDate;

  set setOrderDate(orderDate) => this.orderDate = orderDate;

  get getdeliveryLocation => this.deliveryLocation;
  set setdeliveryLocation(value) {
    this.deliveryLocation = value;
    notifyListeners();
  }

  List<CartItem> _listAdminOrderSuccessSentStatus = List.empty();
  List<CartItem> get getListAdminOrderSuccessSentStatus =>
      this._listAdminOrderSuccessSentStatus;

  set getListAdminOrderSuccessSentStatus(List<CartItem> value) {
    this._listAdminOrderSuccessSentStatus = value;
    notifyListeners();
  }
}

class AdminOrderRefundStatus extends ChangeNotifier {
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
  String deliveryLocation = '';

  String promtPay = '';
  get getPromtPay => this.promtPay;

  set setPromtPay(promtPay) => this.promtPay = promtPay;

  String refundStatus = '';
  get getRefundStatus => this.refundStatus;

  set setRefundStatus(refundStatus) => this.refundStatus = refundStatus;

  get getCartId => this.cartId;

  set setCartId(cartId) => this.cartId = cartId;

  get getImage => this.image;

  set setImage(image) => this.image = image;

  get getNameProduct => this.nameProduct;

  set setNameProduct(nameProduct) => this.nameProduct = nameProduct;

  get getQuantity => this.quantity;

  set setQuantity(quantity) => this.quantity = quantity;

  get getCost => this.cost;

  set setCost(cost) => this.cost = cost;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getProductid => this.Productid;

  set setProductid(Productid) => this.Productid = Productid;

  get getCustomerId => this.customerId;

  set setCustomerId(customerId) => this.customerId = customerId;

  get getDeliveryFee => this.deliveryFee;

  set setDeliveryFee(deliveryFee) => this.deliveryFee = deliveryFee;

  get getTotalCost => this.totalCost;

  set setTotalCost(totalCost) => this.totalCost = totalCost;

  get getUrlQr => this.UrlQr;

  set setUrlQr(UrlQr) => this.UrlQr = UrlQr;

  get getConfirmPayimg => this.confirmPayimg;

  set setConfirmPayimg(confirmPayimg) => this.confirmPayimg = confirmPayimg;

  get getPaydate => this.paydate;

  set setPaydate(paydate) => this.paydate = paydate;

  get getPaytime => this.paytime;

  set setPaytime(paytime) => this.paytime = paytime;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getBuildName => this.buildName;

  set setBuildName(buildName) => this.buildName = buildName;

  get getRoomNo => this.roomNo;

  set setRoomNo(roomNo) => this.roomNo = roomNo;

  get getStatus => this.status;

  set setStatus(status) => this.status = status;

  get getAvailableDate => this.availableDate;

  set setAvailableDate(availableDate) => this.availableDate = availableDate;

  get getAvailableTime => this.availableTime;

  set setAvailableTime(availableTime) => this.availableTime = availableTime;

  get getEmailRider => this.emailRider;

  set setEmailRider(emailRider) => this.emailRider = emailRider;

  get getSentDate => this.sentDate;

  set setSentDate(sentDate) => this.sentDate = sentDate;

  get getSentTime => this.sentTime;

  set setSentTime(sentTime) => this.sentTime = sentTime;

  get getProductStatus => this.productStatus;

  set setProductStatus(productStatus) => this.productStatus = productStatus;

  get getOrderDate => this.orderDate;

  set setOrderDate(orderDate) => this.orderDate = orderDate;

  get getdeliveryLocation => this.deliveryLocation;
  set setdeliveryLocation(value) {
    this.deliveryLocation = value;
    notifyListeners();
  }

  List<CartItem> _listAdminOrderRefundStatus = List.empty();
  List<CartItem> get getListAdminOrderRefundStatus =>
      this._listAdminOrderRefundStatus;

  set getListAdminOrderRefundStatus(List<CartItem> value) {
    this._listAdminOrderRefundStatus = value;
    notifyListeners();
  }
}

class CountAdminModel with ChangeNotifier {
  int customerCount = 0;
  int productactiveCount = 0;
  int productnotactiveCount = 0;
  int productallCount = 0;

  get getCustomerCount => this.customerCount;

  set setCustomerCount(customerCount) => this.customerCount = customerCount;

  get getProductactiveCount => this.productactiveCount;

  set setProductactiveCount(productactiveCount) =>
      this.productactiveCount = productactiveCount;

  get getProductnotactiveCount => this.productnotactiveCount;

  set setProductnotactiveCount(productnotactiveCount) =>
      this.productnotactiveCount = productnotactiveCount;

  get getProductallCount => this.productallCount;

  set setProductallCount(productallCount) =>
      this.productallCount = productallCount;
}
