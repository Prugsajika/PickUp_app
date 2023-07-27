import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/pages/admin_approve.dart';
import 'package:grubngo_app/pages/admin_blacklist.dart';
import 'package:grubngo_app/pages/admin_homepage.dart';
import 'package:grubngo_app/pages/admin_salereport_page.dart';

import 'package:provider/provider.dart';

import '../models/admininfo_model.dart';
import '../models/riderinfo_model.dart';
import '../pages/admin_userreport_page.dart';
import '../pages/login_page.dart';

class AdminDrawerBar extends StatefulWidget {
  @override
  State<AdminDrawerBar> createState() => _AdminDrawerBarState();
}

class _AdminDrawerBarState extends State<AdminDrawerBar> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Material(
      color: Colors.red[50],
      child: InkWell(
        onTap: () {
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //   builder: (context) => ProfilePage(
          //       // email: user.email!,
          //       ),
          // ));
        },
        child: Container(
          color: Colors.red[50],
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: Column(
            children: [
              // CircleAvatar(
              //   radius: 52,
              //   backgroundImage: NetworkImage(
              //       'https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
              // ),
              // SizedBox(
              //   height: 12,
              // ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Consumer<AdminModel>(
                    builder: (context, AdminModel admin, child) {
                  return Text(
                    'แอดมิน ${admin.adminName} ${admin.adminLastname}',
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Consumer<AdminModel>(
                    builder: (context, AdminModel admin, child) {
                  return Text(
                    admin.adminEmail,
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildMenuItems(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(12),
    child: Wrap(
      runSpacing: 5,
      children: [
        ListTile(
            leading: const Icon(Icons.home_outlined),
            title: Text('หน้าหลัก'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomePageAdmin(),
              ));
            }),
        ListTile(
            leading: const Icon(Icons.approval),
            title: Text('อนุมัติผู้รับหิ้ว'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ApproveRiderPage(),
              ));
            }),
        ListTile(
            leading: const Icon(Icons.list),
            title: Text('แบล็คลิส'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => BlacklistPage(),
              ));
            }),
        ListTile(
            leading: const Icon(Icons.attach_money),
            title: Text('รายงานการขาย'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AdminSaleReportPage(),
              ));
            }),
        ListTile(
            leading: const Icon(Icons.people_alt_rounded),
            title: Text('รายงานผู้ใช้งานระบบ'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AdminUserReportPage(),
              ));
            }),
        const Divider(
          color: Colors.black54,
        ),
        ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: Text('ออกจากระบบ'),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
            }),
      ],
    ),
  );
}
