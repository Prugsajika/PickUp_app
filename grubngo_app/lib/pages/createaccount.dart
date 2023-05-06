import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';

import 'package:path/path.dart';

import '../controllers/rider_controller.dart';
import '../models/riderinfo_model.dart';
import '../services/rider_service.dart';
import '../widgets/image_upload.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formkey = GlobalKey<FormState>();
  late String _email;

  late String _password;

  // late String imagerider;
  // late String FirstName;
  // late String LastName;
  // late String Gender;
  // late String TelNo;
  // late String idCard;
  // late bool status = true;
  // late String confirmImage;
  // late String role = 'rider';
  late String IDdos;
  late String UrlQr;

  bool _hidePassword = true;

  List<Rider> rider = List.empty();
  RiderController controller = RiderController(RiderServices());
  bool isLoading = false;

  void initState() {
    super.initState();
    controller.onSync.listen((bool syncState) => setState(() {
          isLoading = syncState;
          print(isLoading);
        }));
    _getRiders();
  }

  void _getRiders() async {
    var newRiders = await controller.fetchRiders();
    setState(() => rider = newRiders);
    setState(() {
      List<Rider> rg = newRiders;
      print("******************** ${rg}");
    });
    // context.read<RiderModel>().setListRider(newRiders);
  }

  void _addRider(String FirstName, LastName, Gender, TelNo, email, idcard,
      imageQR, bool status, String UrlCf) async {
    controller.addRider(FirstName, LastName, Gender, TelNo, email, idcard,
        imageQR, status, UrlCf);
    // _getRiders();
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _imageQR;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGalleryQR() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageQR = File(pickedFile.path);
        uploadFileQR();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCameraQR() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageQR = File(pickedFile.path);
        uploadFileQR();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFileQR() async {
    if (_imageQR == null) return;
    final fileName = basename(_imageQR!.path);
    final destination = 'imageQR/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('imageQR/');
      await ref.putFile(_imageQR!);
      UrlQr = await ref.getDownloadURL();
      print("UrlQr*************** ${UrlQr}");
    } catch (e) {
      print('error occured');
    }
  }

  void _showPickerQR(context) {
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
                        imgFromGalleryQR();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCameraQR();
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
        title: Text('สร้างบัญชี'),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Row(children: [
              //   Consumer<RiderModel>(
              //     builder: (context, value, child) {
              //       String CarModel = '';
              //       if (value.FirstName.toString().isNotEmpty) {
              //         CarModel = '${value.FirstName}';
              //       }
              //       return Text(
              //         '$CarModel',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 20,
              //           //fontWeight: FontWeight.bold,
              //         ),
              //       );
              //     },
              //   ),
              // ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<RiderModel>(builder: (context, value, child) {
                  return Text('ชื่อผู้ใช้งาน' ' : ${value.FirstName}');
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<RiderModel>(builder: (context, value, child) {
                  IDdos = value.Gender;
                  print(IDdos);
                  return Text('นามสกุล' ' : ${value.LastName}');
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<RiderModel>(builder: (context, value, child) {
                  return Text('เพศ' ' : ${value.Gender}');
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<RiderModel>(builder: (context, value, child) {
                  return Text('เบอร์โทรศัพท์' ' : ${value.TelNo}');
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<RiderModel>(builder: (context, value, child) {
                  return Text('เลขบัตรประชาชน' ' : ${value.idCard}');
                }),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Consumer<RiderModel>(builder: (context, value, child) {
              //     return Text('pic' ' : ${value.imagerider}');
              //   }),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<RiderModel>(builder: (context, value, child) {
                  return Container(
                      child: Image.network(
                    value.UrlCf,
                    height: 200,
                  ));
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  maxLength: 30,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    labelText: 'อีเมล์  ',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่อีเมล์';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _email = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  maxLength: 30,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    labelText: 'รหัสผ่าน',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidePassword = false;
                        });

                        Timer.periodic(Duration(seconds: 5), ((timer) {
                          setState(() {
                            _hidePassword = true;
                          });
                        }));
                      },
                      icon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                  onChanged: ((value) => _password = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่รหัสผ่าน';
                    }
                    if (value.length < 5 || value.length > 30) {
                      return 'รหัสผ่านต้องมีตัวอักษรหรือตัวเลขไม่น้อยกว่า 5 ตัว';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _password = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  maxLength: 30,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                    labelText: 'ยืนยันรหัสผ่าน',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidePassword = false;
                        });

                        Timer.periodic(Duration(seconds: 5), ((timer) {
                          setState(() {
                            _hidePassword = true;
                          });
                        }));
                      },
                      icon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณายืนยันรหัสผ่าน';
                    }
                    if (value != _password) {
                      return 'รหัสผ่านไม่ตรงกัน';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Container(
                        width: 200,
                        height: 200,
                        child: _imageQR != null
                            ? Image.file(
                                _imageQR!,
                                fit: BoxFit.cover,
                              )
                            : Text('กรุณาแนบรูป QR Code สำหรับชำระเงิน')),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showPickerQR(context);
                    },
                    child: Text("เลือกภาพ"),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();

                          Navigator.pushNamed(context, '/Login');

                          // _addRider(FirstName, LastName, Gender, TelNo, _email,
                          //     idCard, 1, status, '12');

                          var msg = "Create user";

                          try {
                            final credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: _email,
                              password: _password,
                            );

                            msg = "Create user successful";
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$msg'),
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'week-password') {
                              print('The password provided is too weak.');
                              msg = 'The password provided is too weak.';
                            } else if (e.code == 'email-already-to-use') {
                              print(
                                  'The account already exists for that email.');
                              msg =
                                  'The account already exists for that email.';
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$msg'),
                              ),
                            );
                            return;
                          } catch (e) {
                            print(e);
                            msg = 'Error ${e.toString()}';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$msg'),
                              ),
                            );
                          }

                          context.read<RiderModel>()
                            // ..confirmImage = _confirmImage
                            // ..FirstName = _FirstName
                            // ..LastName = _LastName
                            // ..Gender = _Gender
                            // ..TelNo = _TelNo
                            // ..status = true
                            // ..idCard = _idCard
                            ..email = _email
                            // ..Password = _password
                            ..UrlQr = UrlQr;
                        }
                      },
                      child: Text('สร้างบัญชี'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/Login');
                      },
                      child: Text('ยกเลิก'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
