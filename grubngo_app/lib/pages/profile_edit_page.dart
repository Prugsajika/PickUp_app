import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:grubngo_app/pages/profile_page.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

import '../controllers/rider_controller.dart';

import '../models/riderinfo_model.dart';

import '../services/rider_service.dart';
import '../widgets/drawerappbar.dart';
import 'productadd_success_page.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  final _formkey = GlobalKey<FormState>();

  late String _FirstName = '';
  late String _LastName = '';
  late String _Gender = '';
  late String _TelNo = '';
  late String _idCard = '';
  late String _UrlQr = '';

  late String UrlQr = "";

  RiderController controllerR = RiderController(RiderServices());
  List<Rider> riderInfo = List.empty();
  TextEditingController _GenderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');
    _getuserRiderinfo(UserEmail);
    print("widget");

    setState(() {});
  }

  void _getuserRiderinfo(String userEmail) async {
    print('_getuserRider : $userEmail');

    var userRider = await controllerR.fetchRidersByEmail(userEmail);
    setState(() {
      riderInfo = userRider;
      _GenderController.text = '${riderInfo[0].Gender}';
    });
  }

  void _updateProfile(String FirstName, LastName, TelNo, UrlQr, riderid) async {
    controllerR.updateProfile(FirstName, LastName, TelNo, UrlQr, riderid);
  }

  File? _imageQR;
  final ImagePicker _pickerQr = ImagePicker();

  Future imgFromGalleryQR() async {
    final pickedFile = await _pickerQr.pickImage(source: ImageSource.gallery);

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
    final fileName = Path.basename(_imageQR!.path);
    final destination = 'imageQR/$fileName';
    String UrlQr = '';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('imageQR/');
      await ref.putFile(_imageQR!);
      UrlQr = await ref.getDownloadURL();
      setState(() {
        _UrlQr = UrlQr;
      });
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
        title: const Text('แก้ไขข้อมูลส่วนตัว'),
      ),
      body: Consumer<RiderModel>(
        builder: (context, RiderModel rider, child) {
          print(rider.UrlQr);
          print(rider.FirstName);
          return Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: rider.FirstName,
                      decoration: InputDecoration(
                        labelText: 'ชื่อ',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่ชื่อ';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _FirstName = newValue;
                      },
                      onSaved: (String? value) {
                        _FirstName = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: rider.LastName,
                      decoration: InputDecoration(
                        labelText: 'นามสกุล',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่นามสกุล';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _LastName = newValue;
                      },
                      onSaved: (String? value) {
                        _LastName = value!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLength: 10,
                      initialValue: rider.TelNo,
                      decoration: InputDecoration(
                        labelText: 'เบอร์โทรศัพท์มือถือ',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่เบอร์โทรศัพท์ 10 หลัก';
                        }
                        if (value.length < 10 || value.length > 10) {
                          return 'เบอร์โทรศัพท์ 10 หลัก';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        _TelNo = newValue;
                        // _price = int.parse(newValue!);
                      },
                      onSaved: (String? value) {
                        _TelNo = value.toString();
                      },
                    ),
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
                    child: _imageQR != null
                        ? Image.file(
                            _imageQR!,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            _UrlQr = rider.UrlQr,
                            fit: BoxFit.cover,
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showPickerQR(context);
                    },
                    child: Text("เปลี่ยน QR Code สำหรับชำระเงิน"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _formkey.currentState!.save();

                              _updateProfile(_FirstName, _LastName, _TelNo,
                                  _UrlQr, rider.Riderid);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                'บันทึกข้อมูลเรียบร้อย',
                                style: TextStyle(fontSize: 16),
                              )));
                            }
                            context.read<RiderModel>()
                              ..FirstName = _FirstName
                              ..LastName = _LastName
                              ..TelNo = _TelNo
                              ..UrlQr = _UrlQr
                              ..Riderid = rider.Riderid;
                          },
                          child: Text('บันทึก'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.grey),
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
