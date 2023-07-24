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
  late String deliveryLocation;
  late String promtPay;
  late String refundStatus;

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
      this.orderDate,
      this.deliveryLocation,
      this.promtPay,
      this.refundStatus);

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
      json['deliveryLocation'] as String,
      json['promtPay'] as String,
      json['refundStatus'] as String,
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

  List<CartItem> _listCartItem = List.empty();
  List<CartItem> get getListCartItem => this._listCartItem;

  set getListCartItem(List<CartItem> value) {
    this._listCartItem = value;
    notifyListeners();
  }
}

class OrderWaitSentStatus extends ChangeNotifier {
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

  List<CartItem> _listOrderWaitSentStatus = List.empty();
  List<CartItem> get getListOrderWaitSentStatus =>
      this._listOrderWaitSentStatus;

  set getListOrderWaitSentStatus(List<CartItem> value) {
    this._listOrderWaitSentStatus = value;
    notifyListeners();
  }
}

class OrderSuccessSentStatus extends ChangeNotifier {
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

  List<CartItem> _listOrderSuccessSentStatus = List.empty();
  List<CartItem> get getListOrderSuccessSentStatus =>
      this._listOrderSuccessSentStatus;

  set getListOrderSuccessSentStatus(List<CartItem> value) {
    this._listOrderSuccessSentStatus = value;
    notifyListeners();
  }
}

class OrderRefundStatus extends ChangeNotifier {
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

  List<CartItem> _listOrderRefundStatus = List.empty();
  List<CartItem> get getListOrderRefundStatus => this._listOrderRefundStatus;

  set getListOrderRefundStatus(List<CartItem> value) {
    this._listOrderRefundStatus = value;
    notifyListeners();
  }
}

class OrderWaitConfirmStatus extends ChangeNotifier {
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

  List<CartItem> _listOrderWaitConfirmStatus = List.empty();
  List<CartItem> get getListOrderWaitConfirmStatus =>
      this._listOrderWaitConfirmStatus;

  set getListOrderWaitConfirmStatus(List<CartItem> value) {
    this._listOrderWaitConfirmStatus = value;
    notifyListeners();
  }
}

class CartItemWaitConfirm extends ChangeNotifier {
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

  List<CartItem> _listCartItemWaitConfirm = List.empty();
  List<CartItem> get getListCartItemWaitConfirm =>
      this._listCartItemWaitConfirm;

  set getListCartItemWaitConfirm(List<CartItem> value) {
    this._listCartItemWaitConfirm = value;
    notifyListeners();
  }
}
