import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/riderinfo_model.dart';

class ConfirmProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<RiderModel>(builder: (context, value, child) {
              return Row(
                children: [
                  Text('ชื่อผู้ใช้งาน' ' : '),
                  Text('${value.FirstName}')
                ],
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<RiderModel>(builder: (context, value, child) {
              return Text('นามสกุล' ' : ${value.LastName}');
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<RiderModel>(builder: (context, value, child) {
              return Text('เพศ' ' : ${value.Gender}');
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<RiderModel>(builder: (context, value, child) {
              return Text('เบอร์โทรศัพท์' ' : ${value.TelNo}');
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<RiderModel>(builder: (context, value, child) {
              return Text('เลขบัตรประชาชน' ' : ${value.idCard}');
            }),
          ),
        ],
      ),
    );
  }
}
