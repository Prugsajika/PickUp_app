import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:grubngo_app/pages/login_page.dart';
import 'package:grubngo_app/pages/register_success_page.dart';
import 'package:grubngo_app/widgets/uploadimage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

import '../controllers/rider_controller.dart';
import '../models/riderinfo_model.dart';
import '../services/rider_service.dart';
import '../widgets/drawerappbar.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  List<Rider> rider = List.empty();
  RiderController controller = RiderController(RiderServices());
  bool isLoading = false;
  bool _status = false;
  late String _email;

  late String _password;
  late String UrlQr;

  bool _hidePassword = true;

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
    // context.read<ListRider>().setListRider(newRiders);
  }

  void _addRider(String FirstName, LastName, Gender, TelNo, email, idcard,
      UrlQr, bool status, String UrlCf) async {
    controller.addRider(FirstName, LastName, Gender, TelNo, email, idcard,
        UrlQr, status, UrlCf);
    _getRiders();
  }

  String? Gender;
  final _formkey = GlobalKey<FormState>();
  late String _FirstName;
  late String _LastName;
  late String _Gender;
  late String _TelNo;
  late String _idCard;

  late String UrlCf;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _confirmImage;
  final ImagePicker _picker = ImagePicker();

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _confirmImage = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_confirmImage == null) return;
    final fileName = basename(_confirmImage!.path);
    final destination = 'confirmImage/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('confirmImage/');
      var aaa = await ref.putFile(_confirmImage!);
      UrlCf = await ref.getDownloadURL();
      print(UrlCf);

      print("value ======== ${aaa}");
      // print(await ref.getDownloadURL());
    } catch (e) {
      print('error occured');
    }
  }

  void _showPickerCF(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();

                      print("imagepath ${_confirmImage}");
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  File? _imageQR;
  final ImagePicker _pickerQr = ImagePicker();

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
        title: Text('ลงทะเบียนคนรับหิ้ว'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'ชื่อ',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่ชื่อ';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _FirstName = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'นามสกุล',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่นามสกุล';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _LastName = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'เพศ',
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                        ),
                        value: Gender,
                        validator: (value) {
                          if (value == null) {
                            return 'กรุณาใส่เพศ';
                          }
                          return null;
                        },
                        items: [
                          DropdownMenuItem(
                              child: Text("ไม่ระบุเพศ"), value: "No Gender"),
                          DropdownMenuItem(
                              child: Text("หญิง"), value: "Female"),
                          DropdownMenuItem(child: Text("ชาย"), value: "Male"),
                        ],
                        onChanged: (String? newVal) {
                          setState(() {
                            _Gender = newVal!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        maxLength: 10,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'เบอร์โทรศัพท์มือถือ',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่เบอร์โทรศัพท์ 10 หลัก ';
                          }
                          if (value.length < 10 || value.length > 10) {
                            return 'เบอร์โทรศัพท์ 10 หลัก';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _TelNo = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        maxLength: 13,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'เลขบัตรประชาชน',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่เลขบัตรประชาชน 13 หลัก ';
                          }
                          if (value.length < 13 || value.length > 13) {
                            return 'เลขบัตรประชาชน 13 หลัก';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _idCard = newValue!;
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Container(
                          width: 200,
                          height: 400,
                          child: _confirmImage != null
                              ? Image.file(
                                  _confirmImage!,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  child: Image.asset(
                                    'assets/images/verify.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        )),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            _showPickerCF(context);
                          },
                          child: Text("ถ่ายรูป"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
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
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        maxLines: 2,
                                        'กรุณาแนบรูป QR Code สำหรับชำระเงิน',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
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

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterSuccessPage()));

                                _addRider(
                                    _FirstName,
                                    _LastName,
                                    _Gender,
                                    _TelNo,
                                    _email,
                                    _idCard,
                                    UrlQr,
                                    _status,
                                    UrlCf);

                                var msg = "ลงทะเบียนสำเร็จ";

                                try {
                                  final credential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: _email,
                                    password: _password,
                                  );

                                  // msg = "ลงทะเบียนสำเร็จ";
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     content: Text('$msg'),
                                  //   ),
                                  // );
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
                                  // Navigator.pushNamed(context, '/Login');
                                }
                              }

                              context.read<RiderModel>()
                                ..UrlCf = UrlCf
                                ..FirstName = _FirstName
                                ..LastName = _LastName
                                ..Gender = _Gender
                                ..TelNo = _TelNo
                                ..statusBL = _status
                                ..idCard = _idCard
                                ..email = _email
                                ..UrlQr = UrlQr;
                            },
                            child: Text('ลงทะเบียน'),
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
          ],
        ),
      ),
    );
  }
}
