import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/models/products_model.dart';
import 'package:grubngo_app/pages/histories_page.dart';

import 'package:grubngo_app/pages/products_page.dart';
import 'package:grubngo_app/pages/profilescreen.dart';
import 'package:grubngo_app/pages/purchaseorder_page.dart';
import 'package:grubngo_app/pages/statusdelivery_page.dart';
import 'package:provider/provider.dart';

import '../models/riderinfo_model.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/profile_page.dart';

class DrawerBar extends StatefulWidget {
  @override
  State<DrawerBar> createState() => _DrawerBarState();
}

class _DrawerBarState extends State<DrawerBar> {
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
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ProfilePage(
                // email: user.email!,
                ),
          ));
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
                child: Consumer<RiderModel>(builder: (context, value, child) {
                  return Text(
                    'สวัสดี ${value.FirstName} ${value.LastName}',
                    style: TextStyle(fontSize: 28, color: Colors.black),
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Consumer<RiderModel>(builder: (context, value, child) {
                  return Text(
                    user.email!,
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
                builder: (context) => HomePage(),
              ));
            }),
        ListTile(
            leading: const Icon(Icons.playlist_add_rounded),
            title: Text('สินค้าของฉัน'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ProductsPage(),
              ));
            }),
        ListTile(
            leading: const Icon(Icons.list),
            title: Text('จัดการคำสั่งซื้อ'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => PurchaseOrderPage(),
              ));
            }),
        // ListTile(
        //     leading: const Icon(Icons.wrap_text_outlined),
        //     title: Text('สถานะการจัดส่ง'),
        //     onTap: () {
        //       Navigator.of(context).pushReplacement(MaterialPageRoute(
        //         builder: (context) => StatusDeliveryPage(),
        //       ));
        //     }),
        ListTile(
            leading: const Icon(Icons.history),
            title: Text('ประวัติ'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HistoryPage(),
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
        // ListTile(
        //     leading: const Icon(Icons.receipt_rounded),
        //     title: Text('ประวัติการสั่งซื้อ'),
        //     onTap: () {
        //       Navigator.of(context).pushReplacement(MaterialPageRoute(
        //         builder: (context) => OrderHistory(),
        //       ));
        //     }),
        // const Divider(
        //   color: Colors.black54,
        // ),
        // ListTile(
        //     leading: const Icon(Icons.shopping_basket),
        //     title: Text('รับหิ้วอาหาร'),
        //     onTap: () {
        //       Navigator.of(context).pushReplacement(MaterialPageRoute(
        //         builder: (context) => RestaurantPage(),
        //       ));
        //     }),
        // ListTile(
        //     leading: const Icon(Icons.settings),
        //     title: Text('การตั้งค่า'),
        //     onTap: () {}),
        // ListTile(
        //     leading: const Icon(Icons.power_settings_new),
        //     title: Text('ออกจากระบบ'),
        //     onTap: () {
        //       Navigator.of(context).pushReplacement(MaterialPageRoute(
        //         builder: (context) => LoginPage(
        //           title: 'Grub and Go!!',
        //         ),
        //       ));
        //     }),
      ],
    ),
  );
}
