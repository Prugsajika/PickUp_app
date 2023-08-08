import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_launcher/utils/constants.dart';

import 'package:intl/intl.dart';
import 'package:maget_app/pages/products_page.dart';
import 'package:maget_app/pages/register_page.dart';
import 'package:provider/provider.dart';

import '../components/body.dart';
import '../controllers/customer_controller.dart';
import '../controllers/product_controller.dart';
import '../models/customer_model.dart';
import '../models/products_model.dart';
import '../services/customer_services.dart';
import '../services/product_services.dart';
import '../widgets/drawerappbar.dart';
import 'login_page.dart';
import 'favourite_page.dart';
import 'order_page.dart';
import 'productdetail_page.dart';
import 'profile_page.dart';

class FindProductPage extends StatefulWidget {
  @override
  State<FindProductPage> createState() => _FindProductPageState();
}

class _FindProductPageState extends State<FindProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String _Productid;
  late String _name;
  late String _description;
  late String _deliveryLocation;
  late String _typeOfFood;
  late int _price = 0;
  late String _UrlPd = '';
  late int _stock = 0;

  late String _sentDate;
  late String _sentTime;
  late String _availableDate;
  late String _availableTime;
  late bool _productStatus;
  late String _email;
  late String _UrlQr;

  late int _deliveryFee = 0;

  String searchvalue = "";

  DateFormat dateFormat = DateFormat('yyyy/MM/dd');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'ค้นหาสินค้า',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'ค้นหา...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      searchvalue = newValue;
                      print('searchvalue $searchvalue');
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('availableDate',
                      isGreaterThanOrEqualTo: dateFormat.format(DateTime.now()))
                  .snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var products = snapshots.data!.docs[index].data()
                              as Map<String, dynamic>;
                          print('product $products');

                          if (searchvalue.isEmpty) {
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
                                    side: BorderSide(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          products['name'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'ราคา ${products['price'].toString()} บาท',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          products['description'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          products['deliveryLocation'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(products['UrlPd']),
                                  ),
                                  onTap: () {
                                    print(
                                        'check customerId ${context.read<ProfileDetailModel>().customerId}');
                                    _Productid = products['Productid'];
                                    _name = products['name'];
                                    _UrlPd = products['UrlPd'];
                                    _deliveryLocation =
                                        products['deliveryLocation'];
                                    _description = products['description'];
                                    _price = products['price'];
                                    _stock = products['stock'];
                                    _typeOfFood = products['typeOfFood'];
                                    _productStatus = products['productStatus'];
                                    _deliveryFee = products['deliveryFee'];
                                    _sentDate = products['sentDate'];
                                    _sentTime = products['sentTime'];
                                    _email = products['email'];
                                    _UrlQr = products['UrlQr'];
                                    _availableDate = products['availableDate'];
                                    _availableTime = products['availableTime'];

                                    context.read<ProductModel>()
                                      ..Productid = _Productid
                                      ..name = _name
                                      ..UrlPd = _UrlPd
                                      ..deliveryLocation = _deliveryLocation
                                      ..description = _description
                                      ..price = _price
                                      ..typeOfFood = _typeOfFood
                                      ..stock = _stock
                                      ..deliveryFee = _deliveryFee
                                      ..sentDate = _sentDate
                                      ..sentTime = _sentTime
                                      ..email = _email
                                      ..UrlQr = _UrlQr
                                      ..availableDate = _availableDate
                                      ..availableTime = _availableTime;

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                          Products: Product(
                                              _Productid,
                                              _UrlPd,
                                              _name,
                                              _description,
                                              _price,
                                              _productStatus,
                                              _typeOfFood,
                                              _deliveryFee,
                                              _deliveryLocation,
                                              _sentDate,
                                              _sentTime,
                                              _stock,
                                              _email,
                                              _UrlQr,
                                              _availableDate,
                                              _availableTime),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                          if (products['name']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchvalue.toLowerCase()) ||
                              products['description']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchvalue.toLowerCase()) ||
                              products['price']
                                  .toString()
                                  .toLowerCase()
                                  .startsWith(searchvalue.toLowerCase()) ||
                              products['deliveryLocation']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchvalue.toLowerCase())) {
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
                                    side: BorderSide(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          products['name'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'ราคา ${products['price'].toString()} บาท',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          products['description'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          products['deliveryLocation'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(products['UrlPd']),
                                  ),
                                  onTap: () {
                                    print(
                                        'check customerId ${context.read<ProfileDetailModel>().customerId}');
                                    _Productid = products['Productid'];
                                    _name = products['name'];
                                    _UrlPd = products['UrlPd'];
                                    _deliveryLocation =
                                        products['deliveryLocation'];
                                    _description = products['description'];
                                    _price = products['price'];
                                    _stock = products['stock'];
                                    _typeOfFood = products['typeOfFood'];
                                    _productStatus = products['productStatus'];
                                    _deliveryFee = products['deliveryFee'];
                                    _sentDate = products['sentDate'];
                                    _sentTime = products['sentTime'];
                                    _email = products['email'];
                                    _UrlQr = products['UrlQr'];
                                    _availableDate = products['availableDate'];
                                    _availableTime = products['availableTime'];

                                    context.read<ProductModel>()
                                      ..Productid = _Productid
                                      ..name = _name
                                      ..UrlPd = _UrlPd
                                      ..deliveryLocation = _deliveryLocation
                                      ..description = _description
                                      ..price = _price
                                      ..typeOfFood = _typeOfFood
                                      ..stock = _stock
                                      ..deliveryFee = _deliveryFee
                                      ..sentDate = _sentDate
                                      ..sentTime = _sentTime
                                      ..email = _email
                                      ..UrlQr = _UrlQr
                                      ..availableDate = _availableDate
                                      ..availableTime = _availableTime;

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailPage(
                                          Products: Product(
                                              _Productid,
                                              _UrlPd,
                                              _name,
                                              _description,
                                              _price,
                                              _productStatus,
                                              _typeOfFood,
                                              _deliveryFee,
                                              _deliveryLocation,
                                              _sentDate,
                                              _sentTime,
                                              _stock,
                                              _email,
                                              _UrlQr,
                                              _availableDate,
                                              _availableTime),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
