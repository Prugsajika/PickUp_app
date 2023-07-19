import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maget_app/models/cartitem_model.dart';
import 'package:maget_app/models/customer_model.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import 'color.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.Products});
  final Product Products;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _formkey = GlobalKey<FormState>();
  late int _quantity = 0;
  late String _buildName = '';
  late String _roomNo = '';
  late int _cost = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดสินค้า'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 237, 243),
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.Products.UrlPd,
                        ),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                          width: 1.0,
                          color: Color.fromARGB(255, 232, 237, 243)),
                      borderRadius: BorderRadius.circular(10)),
                  width: 297,
                  height: 288,
                ),
              ),
              Card(
                color: Colors.amber[100],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ชื่อสินค้า : ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.Products.name,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "รายละเอียดสินค้า : ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.Products.description,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "ราคา : ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.Products.price.toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            " บาท",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "ค่ารับหิ้วต่อชิ้น : ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.Products.deliveryFee.toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            " บาท",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "จำนวนสินค้าที่มีทั้งหมด : ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.Products.stock.toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "สถานที่จัดส่ง : ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.Products.deliveryLocation,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "วันที่จัดส่ง : ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.Products.sentDate,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "เวลาที่จัดส่ง : ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.Products.sentTime,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            " น.",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'จำนวนที่ต้องการสั่ง',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่จำนวนที่ต้องการสั่ง';
                          }
                          return null;
                        },
                        // onSaved: (newValue) => _quantity = newValue!,
                        onSaved: (newValue) {
                          _quantity = int.parse(newValue!);
                          // setState(() {
                          //   _quantitys = _quantity;
                          //   print(_quantitys);
                          // });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'สถานที่รับอาหาร',
                          hintText: 'ชื่อตึก/หมู่บ้าน',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่สถานที่รับอาหาร';
                          }
                          return null;
                        },
                        // onSaved: (newValue) => _quantity = newValue!,
                        onSaved: (newValue) {
                          _buildName = newValue!;
                          // setState(() {
                          //   _quantitys = _quantity;
                          //   print(_quantitys);
                          // });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'เลขบ้าน/เลขห้อง',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่เลขบ้าน/เลขห้อง';
                          }
                          return null;
                        },
                        // onSaved: (newValue) => _quantity = newValue!,
                        onSaved: (newValue) {
                          _roomNo = newValue!;
                          // setState(() {
                          //   _quantitys = _quantity;
                          //   print(_quantitys);
                          // });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    Navigator.pushNamed(context, '/5');
                  }

                  context.read<CartItemModel>()
                    ..image = widget.Products.UrlPd
                    ..nameProduct = widget.Products.name
                    ..quantity = _quantity
                    ..price = widget.Products.price
                    ..cost = _quantity * widget.Products.price
                    ..Productid = widget.Products.Productid
                    ..customerId = context.read<ProfileDetailModel>().customerId
                    ..deliveryFee = widget.Products.deliveryFee * _quantity
                    ..totalCost = (_quantity *
                        (widget.Products.price + widget.Products.deliveryFee))
                    ..UrlQr = widget.Products.UrlQr
                    ..buildName = _buildName
                    ..roomNo = _roomNo
                    ..availableDate = widget.Products.availableDate
                    ..availableTime = widget.Products.availableTime
                    ..email = widget.Products.email
                    ..sentDate = widget.Products.sentDate
                    ..sentTime = widget.Products.sentTime
                    ..productStatus = widget.Products.productStatus
                    ..orderDate = DateTime.now().toString();

                  print('check cart ${context.read<CartItemModel>().image}');
                  print('check cost ${context.read<CartItemModel>().cost}');
                  print(
                      'check quantity ${context.read<CartItemModel>().quantity}');
                  print('check price ${widget.Products.price}');
                  print('check quantitys ${_quantity}');
                  print(
                      'check quantitys ${context.read<CartItemModel>().deliveryFee}');
                  print(
                      'check orderDate ${context.read<CartItemModel>().orderDate}');
                },
                child: Text("สั่งซื้อสินค้า"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
