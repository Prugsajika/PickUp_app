// import 'dart:async';
// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';

// import '../controllers/product_controller.dart';
// import '../controllers/rider_controller.dart';
// import '../models/products_model.dart';
// import '../models/riderinfo_model.dart';
// import '../services/product_services.dart';
// import '../services/rider_service.dart';
// import '../widgets/drawerappbar.dart';
// import 'productadd_success_page.dart';

// class AddProduct extends StatefulWidget {
//   // const AddProduct({Key? key, required this.email}) : super(key: key);
//   @override
//   State<AddProduct> createState() => _AddProduct();
// }

// class _AddProduct extends State<AddProduct> {
//   TextEditingController _dateSent = TextEditingController();
//   TextEditingController _dateAvailable = TextEditingController();
//   TextEditingController _timeSent = TextEditingController();
//   TextEditingController _timeAvailable = TextEditingController();
//   final user = FirebaseAuth.instance.currentUser!;

//   final _formkey = GlobalKey<FormState>();
//   String? typeOfFood;

//   late String _name;
//   late String _description;
//   late String _sentDate;
//   late String _sentTime;
//   late String _availableDate;
//   late String _availableTime;
//   late String _typeOfFood;

//   late String _UrlPd;
//   late String _deliveryLocation;
//   late int _price;
//   late int _stock;
//   late int _deliveryFee;
//   late String _prices;
//   late String _stocks;
//   late String _deliveryFees;
//   late String UrlQr = "";
//   ProductController controller = ProductController(ProductServices());
//   RiderController controllerR = RiderController(RiderServices());

//   TimeOfDay timeOfDay = TimeOfDay.now();

//   void initState() {
//     super.initState();
//     final user = FirebaseAuth.instance.currentUser!;
//     String UserEmail = user.email.toString();
//     print('user $UserEmail');
//     _getuserRider(UserEmail);
//   }

//   void _getuserRider(String userEmail) async {
//     print('_getuserRider : $userEmail');
//     List<Rider> rider = List.empty();
//     var userRider = await controllerR.fetchRidersByEmail(userEmail);
//     print("userRider  $userRider");
//     setState(() => rider = userRider);
//     print('_getuserRider UrlQr : ${rider.first.UrlQr}');
//     UrlQr = rider.first.UrlQr;
//   }

//   void _addProduct(
//       String name,
//       description,
//       UrlPd,
//       deliveryLocation,
//       email,
//       typeOfFood,
//       sentDate,
//       sentTime,
//       int price,
//       stock,
//       deliveryFee,
//       urlQr,
//       availableDate,
//       availableTime) async {
//     controller.addProduct(
//         name,
//         description,
//         UrlPd,
//         deliveryLocation,
//         email,
//         typeOfFood,
//         sentDate,
//         sentTime,
//         price,
//         stock,
//         deliveryFee,
//         urlQr,
//         availableDate,
//         availableTime);
//   }

//   File? _imagePD;
//   final ImagePicker _picker = ImagePicker();

//   Future imgFromGalleryPd() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _imagePD = File(pickedFile.path);
//         uploadFileQR();
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future imgFromCameraPd() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);

//     setState(() {
//       if (pickedFile != null) {
//         _imagePD = File(pickedFile.path);
//         uploadFileQR();
//       } else {
//         print('No image selected.');
//       }
//     });
//   }

//   Future uploadFileQR() async {
//     if (_imagePD == null) return;
//     final fileName = basename(_imagePD!.path);
//     final destination = 'imagePD/$fileName';
//     String UrlPd = '';

//     try {
//       final ref = firebase_storage.FirebaseStorage.instance
//           .ref(destination)
//           .child('imagePD/');
//       await ref.putFile(_imagePD!);
//       UrlPd = await ref.getDownloadURL();
//       setState(() {
//         _UrlPd = UrlPd;
//       });
//       print("UrlPd*************** ${UrlPd}");
//     } catch (e) {
//       print('error occured');
//     }
//   }

//   void _showPickerPd(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Gallery'),
//                       onTap: () {
//                         imgFromGalleryPd();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       imgFromCameraPd();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('เพิ่มรายการสินค้า'),
//       ),
//       body: Form(
//         key: _formkey,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 width: 300,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   border: Border.all(
//                     color: Colors.white,
//                   ),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 6.0,
//                       spreadRadius: 2.0,
//                       color: Colors.grey,
//                       offset: Offset(0.0, 0.0),
//                     )
//                   ],
//                 ),
//                 child: _imagePD != null
//                     ? Image.file(
//                         _imagePD!,
//                         fit: BoxFit.cover,
//                       )
//                     : Center(child: Text('เพิ่มรูปสินค้า')),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   _showPickerPd(context);
//                 },
//                 child: Text("เพิ่มรูป"),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'ชื่อสินค้า',
//                     border: OutlineInputBorder(),
//                     hintText: 'เช่น หมูปิ้ง',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาใส่ชื่อสินค้า';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _name = newValue!;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: DropdownButtonFormField(
//                   decoration: InputDecoration(
//                     labelText: 'ประเภทสินค้า',
//                     // enabledBorder: OutlineInputBorder(),
//                     border: OutlineInputBorder(),
//                   ),
//                   value: typeOfFood,
//                   items: [
//                     DropdownMenuItem(child: Text("ของคาว"), value: "ของคาว"),
//                     DropdownMenuItem(child: Text("ของหวาน"), value: "ของหวาน"),
//                     DropdownMenuItem(child: Text("ผลไม้"), value: "ผลไม้"),
//                   ],
//                   onChanged: (String? newVal) {
//                     setState(() {
//                       _typeOfFood = newVal!;
//                     });
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       labelText: 'รายละเอียดสินค้า',
//                       border: OutlineInputBorder(),
//                       hintText: 'เช่น ร้าน... ถุงละ 10 ไม้'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาใส่รายละเอียดสินค้า';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _description = newValue!;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       labelText: 'ราคาสินค้าต่อชิ้น',
//                       border: OutlineInputBorder(),
//                       hintText: 'จำนวนเงิน (บาท)'),
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.digitsOnly
//                   ],
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาใส่ราคาสินค้า';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _prices = newValue!;
//                     // _price = int.parse(newValue!);
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       labelText: 'จำนวนสินค้า',
//                       border: OutlineInputBorder(),
//                       hintText: 'จำนวนสินค้าทั้งหมด (ชิ้น)'),
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.digitsOnly
//                   ],
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาใส่จำนวนสินค้า';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _stocks = newValue!;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       labelText: 'ค่าหิ้วต่อชิ้น',
//                       border: OutlineInputBorder(),
//                       hintText: 'จำนวนเงิน (บาท)'),
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     FilteringTextInputFormatter.digitsOnly
//                   ],
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาใส่ค่าหิ้ว';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _deliveryFees = newValue!;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: _dateSent,
//                   decoration: InputDecoration(
//                     labelText: 'วันที่จัดส่ง',
//                     border: OutlineInputBorder(),
//                     hintText: 'วันที่จัดส่ง',
//                     suffixIcon: IconButton(
//                       onPressed: () async {
//                         DateTime? pickedate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2101));
//                         if (pickedate != null) {
//                           setState(
//                             () {
//                               _dateSent.text =
//                                   DateFormat('dd/MM/yyyy').format(pickedate);
//                             },
//                           );
//                         }
//                       },
//                       icon: Icon(Icons.calendar_today_rounded),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาใส่วันที่จัดส่ง';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _sentDate = newValue!;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: _timeSent,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                       labelText: 'เวลาที่จัดส่ง',
//                       border: OutlineInputBorder(),
//                       hintText: 'เช่น 18.00',
//                       suffixIcon: IconButton(
//                         onPressed: () async {
//                           var _time = await showTimePicker(
//                             context: context,
//                             initialTime: timeOfDay,
//                           );

//                           if (_time != null) {
//                             setState(() {
//                               _timeSent.text = "${_time.hour}:${_time.minute}";
//                             });
//                           }
//                         },
//                         icon: Icon(Icons.access_time),
//                       )),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาใส่เวลาที่จัดส่ง';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _sentTime = newValue!;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                       labelText: 'สถานที่จัดส่ง',
//                       border: OutlineInputBorder(),
//                       hintText: 'เช่น คอนโด... / หมู่บ้าน...'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาใส่รายละเอียดสถานที่จัดส่ง';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _deliveryLocation = newValue!;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: _dateAvailable,
//                   decoration: InputDecoration(
//                     labelText: 'วันที่สั่งได้ถึง',
//                     border: OutlineInputBorder(),
//                     hintText: 'วันที่สั่งได้ถึง',
//                     suffixIcon: IconButton(
//                       onPressed: () async {
//                         DateTime? pickedate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2101));
//                         if (pickedate != null) {
//                           setState(
//                             () {
//                               _dateAvailable.text =
//                                   DateFormat('dd/MM/yyyy').format(pickedate);
//                             },
//                           );
//                         }
//                       },
//                       icon: Icon(Icons.calendar_today_rounded),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาใส่วันที่สั่งได้ถึง';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _availableDate = newValue!;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: _timeAvailable,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'เวลาที่สั่งได้ถึง',
//                     border: OutlineInputBorder(),
//                     hintText: 'เช่น 18.00',
//                     suffixIcon: IconButton(
//                       onPressed: () async {
//                         var _time = await showTimePicker(
//                           context: context,
//                           initialTime: timeOfDay,
//                         );

//                         if (_time != null) {
//                           setState(() {
//                             _timeAvailable.text =
//                                 "${_time.hour}:${_time.minute}";
//                           });
//                         }
//                       },
//                       icon: Icon(Icons.access_time),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาใส่เวลาที่สั่งได้ถึง';
//                     }
//                     return null;
//                   },
//                   onSaved: (newValue) {
//                     _availableTime = newValue!;
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         if (_formkey.currentState!.validate()) {
//                           _formkey.currentState!.save();

//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       AddProductSuccessPage()));

//                           _addProduct(
//                               _name,
//                               _description,
//                               _UrlPd,
//                               _deliveryLocation,
//                               user.email,
//                               _typeOfFood,
//                               _sentDate,
//                               _sentTime,
//                               // _price,
//                               _price = int.parse(_prices),
//                               _stock = int.parse(_stocks),
//                               _deliveryFee = int.parse(_deliveryFees),
//                               UrlQr,
//                               _availableDate,
//                               _availableTime);

//                           print('test QR Code ${UrlQr}');

//                           // ScaffoldMessenger.of(context).showSnackBar(
//                           //   SnackBar(
//                           //     content: Text('Processing Save : $_name'),
//                           //   ),
//                           // );
//                         }
//                         context.read<ProductModel>()
//                           ..name = _name
//                           ..description = _description
//                           ..UrlPd = _UrlPd
//                           ..deliveryLocation = _deliveryLocation
//                           ..typeOfFood = _typeOfFood
//                           ..sentDate = _sentDate
//                           ..sentTime = _sentTime
//                           ..email =
//                               context.read<emailProvider>().email.toString()
//                           ..price = _price
//                           ..stock = _stock
//                           ..deliveryFee = _deliveryFee
//                           ..availableDate = _availableDate
//                           ..availableTime = _availableTime;
//                       },
//                       child: Text('สร้างรายการสินค้า'),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text('ยกเลิก'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
