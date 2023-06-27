import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/controllers/admin_controller.dart';
import 'package:grubngo_app/services/admin_service.dart';

import '../controllers/rider_controller.dart';

import '../services/rider_service.dart';
import 'admin_homepage.dart';
import 'color.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hidePassword = true;

  RiderController controllerR = RiderController(RiderServices());
  AdminController controllerAdmin = AdminController(AdminServices());

  late String UrlQr = "";
  Future singIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final emailRider = FirebaseAuth.instance.currentUser?.email!;
      print('print rider $emailRider');
      var newRider = await controllerR.fetchBlacklistByEmail(emailRider!);
      int rider = newRider.length;
      print('chk rider** $rider');

      // get admin
      var newAdmin = await controllerAdmin.fetchAdminByEmail(emailRider);
      int admin = newAdmin.length;
      print('chk admin** $admin');
      if (admin == 1) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePageAdmin()));
      } else {
        if (rider == 1) {
          return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text('ไม่สามารถเข้าสู่ระบบได้ ติดต่อแอดมิน'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'ตกลง'),
                      child: const Text('ตกลง'),
                    ),
                  ],
                );
              });
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        }
      }
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('กรุณาตรวจสอบข้อมูลการเข้าระบบ'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'ตกลง'),
                  child: const Text('ตกลง'),
                ),
              ],
            );
          });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: iWhiteColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                Image.asset(
                  'assets/images/grubngo_logo.png',
                  height: 150,
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        bottom: 0,
                      ),
                      child: RichText(
                        text: TextSpan(
                            text: "รับหิ้วกับ",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                            children: [
                              TextSpan(
                                text: " Grub and Go!!",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                // username
                SizedBox(height: 75),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'อีเมล์ ',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: iGreyColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: iOrangeColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    obscureText: _hidePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
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
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: iGreyColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: iOrangeColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                  child: ElevatedButton(
                    onPressed: singIn,
                    child: Center(
                      child: Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(
                            color: iWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, '/2'),
                        child: Center(
                          child: Row(
                            children: [
                              Text(' ยังไม่มีบัญชีใช่ไหม '),
                              Text(
                                ' ลงทะเบียน ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                  width: 10,
                ),
                const Text(
                  '© 2022 - Grub and Go!!',
                ),
                const Text(
                  '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
