import 'package:flutter/material.dart';

import '../widgets/drawerappbar.dart';

class PurchaseOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(
        title: Text('สินค้า'),
      ),
    );
  }
}
