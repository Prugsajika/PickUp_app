import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:grubngo_app/pages/productdetail_page.dart';
import 'package:grubngo_app/pages/products_page.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

import '../controllers/product_controller.dart';
import '../controllers/rider_controller.dart';
import '../models/products_model.dart';
import '../models/riderinfo_model.dart';
import '../services/product_services.dart';
import '../services/rider_service.dart';
import '../widgets/drawerappbar.dart';
import 'productadd_success_page.dart';

class EditProductPage extends StatefulWidget {
  // const EditProductPage(
  //     {super.key, required this.products, required this.indexs});
  // // final Product Products;
  // // const AddProduct({Key? key, required this.email}) : super(key: key);
  // final Product products;
  // final int indexs;
  @override
  State<EditProductPage> createState() => _EditProductPage();
}

class _EditProductPage extends State<EditProductPage> {
  // String Productid = '';
  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateSent = TextEditingController();
  TextEditingController _dateAvailable = TextEditingController();
  TextEditingController _timeSent = TextEditingController();
  TextEditingController _timeAvailable = TextEditingController();
  TextEditingController _typeOfFoodController = TextEditingController();
  // TextEditingController __UrlPdController = TextEditingController();
  // TextEditingController _deliveryLocationController = TextEditingController();
  // TextEditingController _priceController = TextEditingController();
  // TextEditingController _stockController = TextEditingController();
  // TextEditingController _deliveryFeeController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  String? typeOfFood = null;
  // List<DropdownMenuItem<String>> _listtypeOfFood = [];

  late String _name = "";
  late String _description = "";
  late String _sentDate = "";
  late String _sentTime = "";
  late String _availableDate = "";
  late String _availableTime = "";
  late String _typeOfFood = "";

  late String _UrlPd = "";
  late String _deliveryLocation = "";
  late int _price = 0;
  late int _stock = 0;
  late int _deliveryFee = 0;
  late int _Indexs;
  late String UrlQr = "";
  ProductController controller = ProductController(ProductServices());
  RiderController controllerR = RiderController(RiderServices());
  List<Product> productinfo = List.empty();

  TimeOfDay timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');
    _getuserRider(UserEmail);
    print("widget");
    // print(widget.indexs.toInt());

    String Productid =
        Provider.of<EditProductModel>(context, listen: false).Productid;
    // String _Productid = context.read<EditProductModel>().Productid;
    _getProductinfo(Productid);
    print('productid $Productid');
    setState(() {});
  }

  void _getuserRider(String userEmail) async {
    print('_getuserRider : $userEmail');
    List<Rider> rider = List.empty();
    var userRider = await controllerR.fetchRidersByEmail(userEmail);
    print("userRider  $userRider");
    setState(() => rider = userRider);
    print('_getuserRider UrlQr : ${rider.first.UrlQr}');
    UrlQr = rider.first.UrlQr;
  }

  void _getProductinfo(String Productid) async {
    var newproductinfo = await controller.fetchProductInfo(Productid);

    // newproductinfo.forEach(
    //   (e) {
    //     _listtypeOfFood.add(
    //       DropdownMenuItem(child: Text("ของคาว"), value: "ของคาว"),

    //     );
    //   },
    // );
    // context.read<EditProductModel>().;
    setState(() {
      productinfo = newproductinfo;
      //   _nameController.text = '${productinfo[0].name}';
      //   _descriptionController.text = '${productinfo[0].description}';
      _dateSent.text = '${productinfo[0].sentDate}';
      _dateAvailable.text = '${productinfo[0].availableDate}';
      _timeSent.text = '${productinfo[0].sentTime}';
      _timeAvailable.text = '${productinfo[0].availableTime}';
      _typeOfFoodController.text = '${productinfo[0].typeOfFood}';
      //   __UrlPdController.text = '${productinfo[0].UrlPd}';
      //   _deliveryLocationController.text = '${productinfo[0].deliveryLocation}';
      //   _priceController.text = '${productinfo[0].price}';
      //   _stockController.text = '${productinfo[0].stock}';
      //   _deliveryFeeController.text = '${productinfo[0].deliveryFee}';
      //   _Productid = '${productinfo[0].Productid}';
      //   print('getproductinfo ${_Productid}${_nameController} ');
    });
  }

  void _updateProduct(
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
    // _Indexs = widget.indexs.toInt();
    // int pricess = price;

    // Provider.of<EditProductModel>(context, listen: false)
    //     .modify(_Indexs, pricess);
    // print("done");

    // print("index $_Indexs");
    // print("index $pricess");
    controller.updateProduct(
        UrlPd,
        name,
        typeOfFood,
        description,
        price,
        stock,
        deliveryFee,
        sentDate,
        sentTime,
        deliveryLocation,
        availableDate,
        availableTime,
        Productid);

    print('price $price');
  }

  File? _imagePD;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGalleryPd() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imagePD = File(pickedFile.path);
        uploadFileQR();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCameraPd() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imagePD = File(pickedFile.path);
        uploadFileQR();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFileQR() async {
    if (_imagePD == null) return;
    final fileName = Path.basename(_imagePD!.path);
    final destination = 'imagePD/$fileName';
    String UrlPd = '';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('imagePD/');
      await ref.putFile(_imagePD!);
      UrlPd = await ref.getDownloadURL();
      setState(() {
        _UrlPd = UrlPd;
      });
      print("UrlPd*************** ${UrlPd}");
    } catch (e) {
      print('error occured');
    }
  }

  void _showPickerPd(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGalleryPd();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCameraPd();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขสินค้า'),
      ),
      body: Consumer<EditProductModel>(
        builder: (context, EditProductModel product, child) {
          var typeOfFood = product.typeOfFood;
          return Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 300,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6.0,
                          spreadRadius: 2.0,
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                    ),
                    child: _imagePD != null
                        ? Image.file(
                            _imagePD!,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            _UrlPd = product.UrlPd,
                            fit: BoxFit.cover,
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showPickerPd(context);
                    },
                    child: Text("เปลี่ยนรูป"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: product.name,
                      decoration: InputDecoration(
                        labelText: 'ชื่อสินค้า',
                        border: OutlineInputBorder(),
                        hintText: 'เช่น หมูปิ้ง',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่ชื่อสินค้า';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _name = newValue;
                      },
                      onSaved: (String? value) {
                        _name = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'ประเภทสินค้า',
                        // enabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                      ),
                      value: typeOfFood,
                      validator: (value) {
                        if (value == null) {
                          return 'กรุณาใส่ประเภทสินค้า';
                        }
                        return null;
                      },
                      items: [
                        DropdownMenuItem(
                            child: Text("ของคาว"), value: "ของคาว"),
                        DropdownMenuItem(
                            child: Text("ของหวาน"), value: "ของหวาน"),
                        DropdownMenuItem(child: Text("ผลไม้"), value: "ผลไม้"),
                      ],
                      onSaved: (value) {
                        _typeOfFood = value.toString();
                      },
                      onChanged: (newVal) {
                        setState(() {
                          _typeOfFood = newVal.toString();
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: product.description,
                      decoration: InputDecoration(
                          labelText: 'รายละเอียดสินค้า',
                          border: OutlineInputBorder(),
                          hintText: 'เช่น ร้าน... ถุงละ 10 ไม้'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่รายละเอียดสินค้า';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _description = newValue;
                      },
                      onSaved: (String? value) {
                        _description = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: product.price.toString(),
                      decoration: InputDecoration(
                          labelText: 'ราคาสินค้าต่อชิ้น',
                          border: OutlineInputBorder(),
                          hintText: 'จำนวนเงิน (บาท)'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่ราคาสินค้า';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _price = int.parse(newValue);
                        // _price = int.parse(newValue!);
                      },
                      onSaved: (String? value) {
                        _price = int.parse(value!);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: product.stock.toString(),
                      decoration: InputDecoration(
                          labelText: 'จำนวนสินค้า',
                          border: OutlineInputBorder(),
                          hintText: 'จำนวนสินค้าทั้งหมด (ชิ้น)'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่จำนวนสินค้า';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _stock = int.parse(newValue);
                      },
                      onSaved: (String? value) {
                        _stock = int.parse(value!);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: product.deliveryFee.toString(),
                      decoration: InputDecoration(
                          labelText: 'ค่าหิ้วต่อชิ้น',
                          border: OutlineInputBorder(),
                          hintText: 'จำนวนเงิน (บาท)'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่ค่าหิ้ว';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _deliveryFee = int.parse(newValue);
                      },
                      onSaved: (String? value) {
                        _deliveryFee = int.parse(value!);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      // initialValue: product.sentDate,
                      controller: _dateSent,
                      // _dateSent..text = '${product.sentDate}',
                      decoration: InputDecoration(
                        labelText: 'วันที่จัดส่ง',
                        border: OutlineInputBorder(),
                        hintText: 'วันที่จัดส่ง',
                        suffixIcon: IconButton(
                          onPressed: () async {
                            DateTime? pickedate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));
                            if (pickedate != null) {
                              setState(
                                () {
                                  _dateSent.text = DateFormat('dd/MM/yyyy')
                                      .format(pickedate);
                                },
                              );
                            }
                          },
                          icon: Icon(Icons.calendar_today_rounded),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่วันที่จัดส่ง';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _sentDate = newValue;
                      },
                      onSaved: (String? value) {
                        _sentDate = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _timeSent,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'เวลาที่จัดส่ง',
                          border: OutlineInputBorder(),
                          hintText: 'เช่น 18:00',
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var _time = await showTimePicker(
                                context: context,
                                initialTime: timeOfDay,
                              );

                              if (_time != null) {
                                print(_time.format(context));
                                DateTime parsedTime = DateFormat.jm()
                                    .parse(_time.format(context).toString());
                                print(parsedTime);
                                String formattedTime =
                                    DateFormat('HH:mm').format(parsedTime);
                                print(formattedTime);
                                setState(() {
                                  _timeSent.text = formattedTime;
                                });
                              } else {
                                print("กรุณาเลือกเวลา");
                              }
                            },
                            icon: Icon(Icons.access_time),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่เวลาที่จัดส่ง';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _sentTime = newValue;
                      },
                      onSaved: (String? value) {
                        _sentTime = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: product.deliveryLocation,
                      decoration: InputDecoration(
                          labelText: 'สถานที่จัดส่ง',
                          border: OutlineInputBorder(),
                          hintText: 'เช่น คอนโด... / หมู่บ้าน...'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่รายละเอียดสถานที่จัดส่ง';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _deliveryLocation = newValue;
                      },
                      onSaved: (String? value) {
                        _deliveryLocation = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _dateAvailable,
                      decoration: InputDecoration(
                        labelText: 'วันที่สั่งได้ถึง',
                        border: OutlineInputBorder(),
                        hintText: 'วันที่สั่งได้ถึง',
                        suffixIcon: IconButton(
                          onPressed: () async {
                            DateTime? pickedate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));
                            if (pickedate != null) {
                              setState(
                                () {
                                  _dateAvailable.text = DateFormat('dd/MM/yyyy')
                                      .format(pickedate);
                                },
                              );
                            }
                          },
                          icon: Icon(Icons.calendar_today_rounded),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่วันที่สั่งได้ถึง';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _availableDate = newValue;
                      },
                      onSaved: (String? value) {
                        _availableDate = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _timeAvailable,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'เวลาที่สั่งได้ถึง',
                        border: OutlineInputBorder(),
                        hintText: 'เช่น 18:00',
                        suffixIcon: IconButton(
                          onPressed: () async {
                            var _time = await showTimePicker(
                              context: context,
                              initialTime: timeOfDay,
                            );

                            if (_time != null) {
                              print(_time.format(context));
                              DateTime parsedTime = DateFormat.jm()
                                  .parse(_time.format(context).toString());
                              print(parsedTime);
                              String formattedTime =
                                  DateFormat('HH:mm').format(parsedTime);
                              print(formattedTime);
                              setState(() {
                                _timeAvailable.text = formattedTime;
                              });
                            } else {
                              print("กรุณาเลือกเวลา");
                            }
                          },
                          icon: Icon(Icons.access_time),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่เวลาที่สั่งได้ถึง';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _availableTime = newValue;
                      },
                      onSaved: (String? value) {
                        _availableTime = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();

                              _updateProduct(
                                  _UrlPd,
                                  _name,
                                  _typeOfFood,
                                  _description,
                                  _price,
                                  _stock,
                                  _deliveryFee,
                                  _sentDate,
                                  _sentTime,
                                  _deliveryLocation,
                                  _availableDate,
                                  _availableTime,
                                  product.Productid);
                              print('_name $_name');

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => ProductDetailPage(
                              //         Products: widget.products,
                              //         Indexs: widget.indexs),
                              //   ),
                              // );

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductsPage()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                'บันทึกข้อมูลเรียบร้อย',
                                style: TextStyle(fontSize: 16),
                              )));
                            }
                            context.read<ProductModel>()
                              ..name = _name
                              ..description = _description
                              ..UrlPd = _UrlPd
                              ..deliveryLocation = _deliveryLocation
                              ..typeOfFood = _typeOfFood
                              ..sentDate = _sentDate
                              ..sentTime = _sentTime
                              ..price = _price
                              ..stock = _stock
                              ..deliveryFee = _deliveryFee
                              ..availableDate = _availableDate
                              ..availableTime = _availableTime;
                          },
                          child: Text('บันทึก'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('ยกเลิก'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
