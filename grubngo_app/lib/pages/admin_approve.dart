import 'package:flutter/material.dart';
import 'package:grubngo_app/widgets/admin_drawerappbar.dart';

class ApproveRiderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerBar(),
      appBar: AppBar(
        title: Text('อนุมัติผู้รับหิ้ว'),
      ),
      body: Container(),
    );
  }
}
