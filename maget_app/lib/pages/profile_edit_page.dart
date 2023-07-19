import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:provider/provider.dart';

import '../controllers/customer_controller.dart';

import '../models/customer_model.dart';

import '../services/customer_services.dart';

import '../widgets/drawerappbar.dart';
import 'profile_page.dart';

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

  CustomerController controllerC = CustomerController(CustomerServices());
  List<Customer> CustomerInfo = List.empty();
  TextEditingController _GenderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');
    _getuserCustomerinfo(UserEmail);
    print("widget");
    // print(widget.indexs.toInt());

    setState(() {});
  }

  void _getuserCustomerinfo(String userEmail) async {
    print('_getuserCustomer : $userEmail');

    var userRider = await controllerC.fetchCustomersByEmail(userEmail);
    setState(() {
      CustomerInfo = userRider;
      _GenderController.text = '${CustomerInfo[0].Gender}';
    });
  }

  void _updateProfile(String name, lastName, TelNo, idCard, customerId) async {
    controllerC.updateProfile(name, lastName, TelNo, idCard, customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลส่วนตัว'),
      ),
      body: Consumer<ProfileDetailModel>(
        builder: (context, ProfileDetailModel customer, child) {
          print(customer.customerId);
          print(customer.name);
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
                      initialValue: customer.name,
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
                      initialValue: customer.lastName,
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
                      initialValue: customer.telNo,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: customer.idCard,
                      decoration: InputDecoration(
                        labelText: 'พร้อมเพย์',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณาใส่หมายเลขพร้อมเพย์';
                        }

                        return null;
                      },
                      onChanged: (newValue) {
                        _idCard = newValue;
                        // _price = int.parse(newValue!);
                      },
                      onSaved: (String? value) {
                        _idCard = value.toString();
                      },
                    ),
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
                                  _idCard, customer.customerId);

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
                            context.read<ProfileDetailModel>()
                              ..name = _FirstName
                              ..lastName = _LastName
                              ..telNo = _TelNo
                              ..idCard = _UrlQr
                              ..customerId = customer.customerId;
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
