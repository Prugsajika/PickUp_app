import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/pages/purchaseorder_page.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_controller.dart';
import '../models/cartitem_model.dart';

import '../services/cart_services.dart';

class PurchaseOrderNotCompletePage extends StatefulWidget {
  const PurchaseOrderNotCompletePage({super.key, required this.Carts});
  final CartItem Carts;

  @override
  State<PurchaseOrderNotCompletePage> createState() =>
      _PurchaseOrderNotCompletePageState();
}

class _PurchaseOrderNotCompletePageState
    extends State<PurchaseOrderNotCompletePage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _dateC = TextEditingController();
  TextEditingController _timeC = TextEditingController();

  CartController cartcontroller = CartController(CartServices());
  late AnimationController animationController;
  final user = FirebaseAuth.instance.currentUser!;

  String _refunddate = '';
  String _refundtime = '';
  late String refundPayimg;
  String customerId = '';
  String _refundStatus = '';

  TimeOfDay timeOfDay = TimeOfDay.now();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }

  void _updateRefundPayment(
    String cartId,
    refundStatus,
    _refunddate,
    _refundtime,
    refundPayimg,
  ) async {
    cartcontroller.updateRefundPayment(
      cartId,
      refundStatus,
      _refunddate,
      _refundtime,
      refundPayimg,
    );
    setState(() {});
    print('PurchaseOrderNotCompletePage refund pty####' + cartId);
  }

  File? _refundPayimg;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _refundPayimg = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_refundPayimg == null) return;
    final fileName = basename(_refundPayimg!.path);
    final destination = 'refundPayimg/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('refundPayimg/');
      await ref.putFile(_refundPayimg!);
      refundPayimg = await ref.getDownloadURL();
      print("refundPayimg*************** ${refundPayimg}");
    } catch (e) {
      print('error occured');
    }
  }

  void _showPicker(context) {
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
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
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
        title: Text('คืนเงิน'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "หมายเลขพร้อมเพย์สำหรับคืนเงิน",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.Carts.promtPay,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Consumer<CartItemModel>(builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "จำนวนเงินที่ต้องโอน ",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      widget.Carts.totalCost.toString(),
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      ' บาท',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(
                height: 15,
              ),
              Text(
                "กรอกข้อมูลการชำระเงิน",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _dateC,
                        decoration: InputDecoration(
                          labelText: 'วันที่โอน',
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          hintText: 'วันที่โอน',
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
                                    _dateC.text = DateFormat('dd/MM/yyyy')
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
                            return 'กรุณาใส่วันที่โอน';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _refunddate = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _timeC,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'เวลาที่โอน',
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
                                  _timeC.text = formattedTime;
                                });
                              }
                            },
                            icon: Icon(Icons.access_time),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่เวลาที่โอน';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _refundtime = newValue!;
                          print(_refundtime + _refunddate);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Container(
                        width: 200,
                        height: 200,
                        child: _refundPayimg != null
                            ? Image.file(
                                _refundPayimg!,
                                fit: BoxFit.cover,
                              )
                            : Text('กรุณาแนบรูป Slip สำหรับชำระเงิน')),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showPicker(context);
                    },
                    child: Text("เลือกภาพ"),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                  }
                  _updateRefundPayment(widget.Carts.cartId, 'คืนเงินสำเร็จ',
                      _refunddate, _refundtime, refundPayimg);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PurchaseOrderPage()));
                },
                child: Text("ยืนยันการคืนเงิน"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
