import 'package:flutter/material.dart';
import 'package:maget_app/pages/home_page.dart';

import '../widgets/drawerappbar.dart';

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(
        title: const Text('รายการสั่งซื้อ'),
        backgroundColor: Colors.amber[100],
      ),
    );
  }
}
