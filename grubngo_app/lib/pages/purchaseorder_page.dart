import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grubngo_app/models/products_model.dart';
import 'package:grubngo_app/pages/purchaseorder_list_product_page.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../models/cartitem_model.dart';
import '../services/cart_services.dart';
import '../services/product_services.dart';
import '../widgets/drawerappbar.dart';
import 'color.dart';

class PurchaseOrderPage extends StatefulWidget {
  @override
  State<PurchaseOrderPage> createState() => _PurchaseOrderPageState();
}

class _PurchaseOrderPageState extends State<PurchaseOrderPage> {
  // CartController controller = CartController(CartServices());
  List<Product> products = List.empty();
  List<CartItemPerProduct> cart = List.empty();
  ProductController controller = ProductController(ProductServices());
  CartController controllerCart = CartController(CartServices());
  List<CategoriesProduct> CategoriesChilds = List.empty();
  List<OrderByProduct> OrderList = List.empty();

  @override
  void initState() {
    super.initState();

    String Productid =
        Provider.of<CartItemModel>(context, listen: false).Productid;
    // _getProduct(context);
    _getOrderByProduct(context);
    // print('productid $Productid');
    setState(() {});
  }

//   void _getProduct(BuildContext context) async {
//     var newProduct = await controller.fetchbyuser();
//     print('chk ${newProduct}');

//     context.read<FetchProductModel>().getListProduct = newProduct;
//     print('provider ${context.read<FetchProductModel>().Productid}');

//     List<CategoriesProduct> ad = [];
//     newProduct.forEach((element) {
//       ad.add(CategoriesProduct(
//           element.Productid, element.email, 0, element.name, element.price));
//     });
//     // print(jsonEncode(ad));

// //  int.parse(element.payamount)
// // convert each item to a string by using JSON encoding
//     final jsonList = ad.map((item) => jsonEncode(item)).toList();
//     // print(jsonList);
//     // using toSet - toList strategy
//     final uniqueJsonList = jsonList.toSet().toList();
//     // print(uniqueJsonList);

//     // convert each item back to the original form using JSON decoding
//     final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();
//     // print(jsonEncode(result));

//     // VerifyModel.parseApplList(jsonEncode(result));

//     List<CategoriesProduct> ddd =
//         CategoriesProduct.parseApplList(jsonEncode(result));

//     ddd.forEach((a) {
//       newProduct.forEach((b) {
//         if (a.productID == b.Productid) {
//           a.Sumquantity += b.Productid.substring(1, 2).length as int;
//           // if (b.Productid == ) {
//           //   a.amountApprove += b.id.substring(1, 2).length as int;
//           // } else if (b.status == "ร้องขอ") {
//           //   a.amountRequest += b.id.substring(1, 2).length as int;
//           // } else {
//           //   a.amountReject += b.id.substring(1, 2).length as int;
//           // }
//         }
//       });
//     });
//     print('category');
//     print(jsonEncode(ddd));

//     setState(() {
//       CategoriesChilds = ddd;
//     });
//   }

  void _getOrderByProduct(BuildContext context) async {
    var newcart = await controllerCart.fetchOrderByProductWithCFPay();
    print('chk ${newcart.length}');

    context.read<CartItemPerProductModel>().getListCartItemPerProduct = newcart;
    print('provider ${context.read<CartItemPerProductModel>().Productid}');

    List<OrderByProduct> ad = [];
    newcart.forEach((element) {
      ad.add(OrderByProduct(
          element.nameProduct,
          element.price,
          element.Productid,
          element.sentDate,
          element.sentTime,
          element.image,
          element.deliveryLocation));
    });
    // print(jsonEncode(ad));

//  int.parse(element.payamount)
// convert each item to a string by using JSON encoding
    final jsonList = ad.map((item) => jsonEncode(item)).toList();
    // print(jsonList);
    // using toSet - toList strategy
    final uniqueJsonList = jsonList.toSet().toList();
    // print(uniqueJsonList);

    // convert each item back to the original form using JSON decoding
    final result = uniqueJsonList.map((item) => jsonDecode(item)).toList();
    print(jsonEncode(result));

    // VerifyModel.parseApplList(jsonEncode(result));

    List<OrderByProduct> ddd = OrderByProduct.parseApplList(jsonEncode(result));

    // ddd.forEach((a) {
    //   newcart.forEach((b) {
    //     if (a.Productid == b.Productid) {
    //       // a.Sumquantity += b.Productid.substring(1, 2).length as int;
    //       // if (b.Productid == ) {
    //       //   a.amountApprove += b.id.substring(1, 2).length as int;
    //       // } else if (b.status == "ร้องขอ") {
    //       //   a.amountRequest += b.id.substring(1, 2).length as int;
    //       // } else {
    //       //   a.amountReject += b.id.substring(1, 2).length as int;
    //       // }
    //     }
    //   });
    // });
    print('category');
    print(jsonEncode(ddd));

    setState(() {
      context.read<OrderByProductModel>()._listOrderByProduct = ddd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('รายการคำสั่งซื้อ'),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              icon: Icon(Icons.home),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OrderByProductModel>(
            builder: (context, OrderByProductModel data, child) {
          return data.getListOrderByProduct.length != 0
              ? ListView.builder(
                  itemCount: data.getListOrderByProduct.length,
                  itemBuilder: (context, index) {
                    print('data');
                    print(data.getListOrderByProduct.length);

                    return CardList(data.getListOrderByProduct[index], index);
                  })
              : GestureDetector(
                  child: Center(
                      child: Text(
                  "ไม่มีรายการสินค้า",
                  style: TextStyle(
                    color: iBlueColor,
                  ),
                )));
        }),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  final OrderByProduct products;
  int index;
  CardList(this.products, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )),
        child: ListTile(
          shape: RoundedRectangleBorder(
            //<-- SEE HERE
            side: BorderSide(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ชื่อสินค้า ${products.nameProduct}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'ราคา ${products.price.toString()} บาท',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'ต้องจัดส่งภายใน ${products.sentDate}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'เวลา ${products.sentTime}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'สถานที่จัดส่ง ${products.deliveryLocation}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // subtitle: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'จำนวนที่สั่ง ${carts.quantity.toString()}',
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         'จำนวนเงินที่จ่าย ${carts.totalCost.toString()} บาท',
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         'วันที่ต้องจัดส่ง ${carts.availableDate.toString()}',
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         'เวลา ${carts.availableTime.toString()} น.',
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       Text(
          //         'สถานะ >> ${carts.status.toString()} ',
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //         style: TextStyle(
          //             color: Colors.blue,
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold),
          //       )
          //     ],
          //   ),
          // ),

          leading: CircleAvatar(
            backgroundImage: NetworkImage(products.image),
          ),
          // // trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // print('#######################carts ID ${carts.cartId}');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PurchaseOrderListPage(
                          Products: products,
                          Indexs: index,
                        )));
          },
        ),
      ),
    );
  }
}

class CategoriesProduct {
  final String productID;
  late String emailRider;
  late int Sumquantity;
  late String name;
  late int price;
  CategoriesProduct(
      this.productID, this.emailRider, this.Sumquantity, this.name, this.price);

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
    data['name'] = name;
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

class OrderByProduct {
  late String nameProduct;
  late int price;
  late String Productid;
  late String sentDate;
  late String sentTime;
  late String image;
  late String deliveryLocation;

  OrderByProduct(this.nameProduct, this.price, this.Productid, this.sentDate,
      this.sentTime, this.image, this.deliveryLocation);

  factory OrderByProduct.fromJson(Map<String, dynamic> json) {
    return OrderByProduct(
      json['nameProduct'],
      json['price'],
      json['Productid'],
      json['sentDate'],
      json['sentTime'],
      json['image'],
      json['deliveryLocation'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameProduct'] = nameProduct;
    data['price'] = price;
    data['Productid'] = Productid;
    data['sentDate'] = sentDate;
    data['sentTime'] = sentTime;
    data['image'] = image;
    data['deliveryLocation'] = deliveryLocation;
    return data;
  }

  static List<OrderByProduct> parseApplList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<OrderByProduct> listData = parsed
        .map<OrderByProduct>((json) => OrderByProduct.fromJson(json))
        .toList();
    return listData;
  }
}

class OrderByProductModel extends ChangeNotifier {
  String nameProduct = '';
  int price = 0;
  String Productid = '';
  String sentDate = '';
  String sentTime = '';
  String image = '';
  String deliveryLocation = '';

  get getNameProduct => this.nameProduct;

  set setNameProduct(nameProduct) => this.nameProduct = nameProduct;

  get getPrice => this.price;

  set setPrice(price) => this.price = price;

  get getProductid => this.Productid;

  set setProductid(Productid) => this.Productid = Productid;

  get getSentDate => this.sentDate;

  set setSentDate(sentDate) => this.sentDate = sentDate;

  get getSentTime => this.sentTime;

  set setSentTime(sentTime) => this.sentTime = sentTime;

  get getimage => this.image;

  set setimage(image) => this.image = image;

  get getdeliveryLocation => this.deliveryLocation;
  set setdeliveryLocation(value) {
    this.deliveryLocation = value;
    notifyListeners();
  }

  List<OrderByProduct> _listOrderByProduct = List.empty();
  List<OrderByProduct> get getListOrderByProduct => this._listOrderByProduct;

  set getListOrderByProduct(List<OrderByProduct> value) {
    this._listOrderByProduct = value;
    notifyListeners();
  }
}
