import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:maget_app/models/products_model.dart';
import 'package:maget_app/pages/order_page.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_controller.dart';
import '../models/cartitem_model.dart';
import '../models/customer_model.dart';
import '../services/cart_services.dart';

class ProcessPaymentPage extends StatefulWidget {
  const ProcessPaymentPage({super.key, required this.Carts});
  final CartItem Carts;

  @override
  State<ProcessPaymentPage> createState() => _ProcessPaymentPageState();
}

class _ProcessPaymentPageState extends State<ProcessPaymentPage> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _dateC = TextEditingController();
  TextEditingController _timeC = TextEditingController();

  CartController cartcontroller = CartController(CartServices());
  late AnimationController animationController;
  final user = FirebaseAuth.instance.currentUser!;

  String _paydate = '';
  String _paytime = '';
  late String confirmPayimg;
  String customerId = '';
  String _status = '';

  TimeOfDay timeOfDay = TimeOfDay.now();

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
  }

  void _updateProcessPayment(
    String cartId,
    status,
    _paydate,
    _paytime,
    confirmPayimg,
  ) async {
    cartcontroller.updateProcessPayment(
      cartId,
      status,
      _paydate,
      _paytime,
      confirmPayimg,
    );
    setState(() {});
    print('chk confirm pty####' + cartId);
  }

  File? _confirmPayimg;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _confirmPayimg = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_confirmPayimg == null) return;
    final fileName = basename(_confirmPayimg!.path);
    final destination = 'confirmPayimg/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('confirmPay/');
      await ref.putFile(_confirmPayimg!);
      confirmPayimg = await ref.getDownloadURL();
      print("confirmPayimg*************** ${confirmPayimg}");
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
        title: Text('ชำระเงิน'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "QR Code สำหรับชำระเงิน",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 237, 243),
                      image: DecorationImage(
                        image: NetworkImage(widget.Carts.UrlQr),
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
                          _paydate = newValue!;
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
                          _paytime = newValue!;
                          print(_paytime + _paydate);
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
                        child: _confirmPayimg != null
                            ? Image.file(
                                _confirmPayimg!,
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
                  _updateProcessPayment(widget.Carts.cartId, 'รอยืนยันสลิป',
                      _paydate, _paytime, confirmPayimg);

                  Navigator.pushNamed(context, '/7');
                },
                child: Text("ยืนยันการชำระเงิน"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
