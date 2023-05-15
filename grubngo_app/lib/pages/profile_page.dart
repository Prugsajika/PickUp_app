import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/controllers/rider_controller.dart';
import 'package:grubngo_app/models/riderinfo_model.dart';
import 'package:grubngo_app/services/rider_service.dart';

import '../widgets/drawerappbar.dart';

class ProfilePage extends StatefulWidget {
  // const ProfilePage({Key? key, required this.email}) : super(key: key);
  // final String email;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Rider> profile = List.empty();
  // late String _email = widget.email;
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  RiderController riderController = RiderController(RiderServices());

  // void initState() {
  //   super.initState();
  //   riderController.onSync.listen((bool synState) => setState(() {
  //         isLoading = synState;
  //       }));
  //   _getProfile(_email);
  //   print('_getProfile _email:' + _email);
  // }

  // void _getProfile(String email) async {
  //   var newProfile = await riderController.fetchRidersByEmail(email);
  //   //print('newprofile   ${newProfile.first.firstName}');
  //   setState(() => profile = newProfile);
  // }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: !profile.isEmpty ? profile.length : 1,
          itemBuilder: (context, index) {
            if (!profile.isEmpty) {
              return Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                          Image.network('${profile[index].UrlCf}', height: 150),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'ชื่อ  - ${profile[index].FirstName}  ${profile[index].LastName}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' เพศ - ${profile[index].Gender}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' เบอร์โทรศัพย์ - ${profile[index].TelNo}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' อีเมล  - ${profile[index].email}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text(' สถานะ BlackList - ${profile[index].status}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' QR Image เพื่อรับเงิน'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child:
                          Image.network('${profile[index].UrlQr}', height: 150),
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
      drawer: DrawerBar(),
      appBar: AppBar(
        title: Text('ข้อมูลส่วนตัว'),
      ),
      body: Center(
        child: body,
      ),
    );
  }
}
