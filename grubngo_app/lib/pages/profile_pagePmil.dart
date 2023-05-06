import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midterm_app/pages/menu_page.dart';
import 'package:provider/provider.dart';

import '../controller/regis_controller.dart';
import '../model/regis_model.dart';
import '../model/show_menu_model.dart';
import '../service/regis_service.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.email, required this.role})
      : super(key: key);
  final String email;
  final String role;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Register> profile = List.empty();
  late String _email = widget.email;

  late String _role = widget.role;
  late String _rolename;

  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
//  HttpServices services = HttpServices();
  // TodoController controller = TodoController(HttpServices());
  RegisController controller = RegisController(FirebaseServices());

  void initState() {
    super.initState();
    controller.onSync.listen((bool synState) => setState(() {
          isLoading = synState;
        }));
    _getProfile(_email, _role);
    print('_getProfile _email:' + _email + ' , role :' + _role);
  }

  void _getProfile(String email, String userRole) async {
    var newProfile = await controller.fetchProfile(email, userRole);
    //print('newprofile   ${newProfile.first.firstName}');
    setState(() => profile = newProfile);
  }

  void _updateProfile(Register profile) {
    controller.updateProfile(profile);
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: !profile.isEmpty ? profile.length : 1,
          itemBuilder: (context, index) {
            if (!profile.isEmpty) {
              if (profile[index].userRole == "User") {
                _rolename = 'ลูกแชร์';
              } else if (profile[index].userRole == 'Admin') {
                _rolename = 'ท้าวแชร์';
              }

              return Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /* Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          labelText: 'ชื่อ',
                          label: Text(profile[index].firstName),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.mic),
                            onPressed: () {},
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่ชื่อ';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() => profile[index].firstName = value);

                          _updateProfile(profile[index]);
                        },
                        /*    onChanged: (newValue) {
                          _username = newValue;
                        },
                        onSaved: (newValue) {
                          _username = newValue!;
                        }, */
                      ),
                    ),*/

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('" $_rolename "',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('images/4140059.png', height: 150),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'ชื่อ  - ${profile[index].firstName}  ${profile[index].lastName}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' ที่อยู่ - ${profile[index].address}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' เบอร์โทรศัพย์ - ${profile[index].tel}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' อีเมล  - ${profile[index].email}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          ' สถานะ BlackList - ${profile[index].isBlackList}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' QR Image เพื่อรับเงิน'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset('images/Qrcode.jpg', height: 150),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('ไม่พบข้อมูล กรุณาลองอีกครั้ง')],
              );
            }
          });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowMenuPage(),
                ),
              );
            },
          ),
          IconButton(
              icon: Icon(Icons.logout_rounded),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                var msg = 'Log out';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$msg'),
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              })
        ],
      ),
      body: Center(
        child: body,
      ),
    );
  }
}
 /*  trailing: Row(children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                  /*   setState(() {
                      _hidePassword = false;
                    });
                    Timer.periodic(
                      Duration(seconds: 5),
                      (Timer) {
                        setState(() {
                          _hidePassword = true;
                        });
                      },
                    ); */
                  },
                ),
              ]), */