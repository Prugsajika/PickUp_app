import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/customer_model.dart';
import '../pages/deliveryreport_page.dart';
import '../pages/favourite_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/order_page.dart';
import '../pages/profile_page.dart';

class DrawerBar extends StatelessWidget {
  const DrawerBar({Key? key}) : super(key: key);

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
      color: Colors.amber[100],
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ));
        },
        child: Container(
          color: Colors.amber[100],
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
              Text(
                context.read<ProfileDetailModel>().name.toString() +
                    ' ' +
                    context.read<ProfileDetailModel>().lastName.toString(),
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),
              Text(
                context.read<ProfileDetailModel>().email.toString(),
                style: TextStyle(fontSize: 16, color: Colors.black),
              )
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
        // ListTile(
        //     leading: const Icon(Icons.favorite_border),
        //     title: Text('รายการโปรด'),
        //     onTap: () {
        //       Navigator.of(context).pushReplacement(MaterialPageRoute(
        //         builder: (context) => const FavouritesPage(),
        //       ));
        //     }),
        // ListTile(
        //     leading: const Icon(Icons.shopping_cart),
        //     title: Text('ตระกร้าของฉัน'),
        //     onTap: () {}),
        // ListTile(
        //     leading: const Icon(Icons.add_box),
        //     title: Text('รายการสั่งซื้อ'),
        //     onTap: () {
        //     }),
        ListTile(
            leading: const Icon(Icons.attach_money),
            title: Text('การชำระเงิน'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => OrderPage(),
              ));
            }),
        ListTile(
            leading: const Icon(Icons.delivery_dining_outlined),
            title: Text('สถานะการจัดส่ง'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => DeliveryReportPage(),
              ));
            }),
        const Divider(
          color: Colors.black54,
        ),
        // ListTile(
        //     leading: const Icon(Icons.shopping_basket),
        //     title: Text('รับหิ้วอาหาร'),
        //     onTap: () {
        //       Navigator.of(context).pushReplacement(MaterialPageRoute(
        //         builder: (context) => RestaurantPage(),
        //       ));
        //     }),

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
