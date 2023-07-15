import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../controllers/cart_controller.dart';
import '../models/cartitem_model.dart';
import '../services/cart_services.dart';
import 'home_page.dart';

class ConfirmPaymentPage extends StatefulWidget {
  const ConfirmPaymentPage({super.key, required this.Carts});
  final CartItem Carts;
  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  CartController cartcontroller = CartController(CartServices());
  String? _chosenValue;

  void _updatePayStatus(String cartId, status) async {
    cartcontroller.updatePaystatus(cartId, status);
    setState(() {});
    print('chk confirm pty####' + cartId);
  }

  void _RejectPayStatus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("ปฎิเสธสลิป"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('กรุณาเลือกเหตุผล'),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: Text(
                        'เลือกเหตุผล',
                      ),
                      value: _chosenValue,
                      underline: Container(),
                      items: <String>[
                        'จำนวนเงินไม่ถูกต้อง',
                        'สลิปไม่ถูกต้อง',
                        'ไม่พบรายการโอนเงิน',
                        'อื่นๆ',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          _chosenValue = newVal!;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      _updatePayStatus(widget.Carts.cartId, _chosenValue);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));

                      // print(
                      //     'สลิปไม่ถูกต้อง ${context.read<CartItemModel>().cartId}');
                      // _updatePayStatus(widget.Carts.cartId, 'สลิปไม่ถูกต้อง');
                    },
                    child: const Text(
                      "ตกลง",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตรวจสอบสลิป'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                ),
                child: Image.network(
                  widget.Carts.confirmPayimg.toString(),
                  height: 400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "จำนวนเงินทั้งหมด ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            widget.Carts.totalCost.toString() + '  บาท',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "วันที่โอน ",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            widget.Carts.paydate +
                                '  เวลา ' +
                                widget.Carts.paytime +
                                ' น.',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      // ApprovePayStatus();
                      print(
                          'ยืนยันสลิปแล้ว ${context.read<CartItemModel>().cartId}');
                      _updatePayStatus(widget.Carts.cartId, "ยืนยันสลิปแล้ว");
                    },
                    child: const Text(
                      "ยืนยัน",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      _RejectPayStatus();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));

                      print(
                          'สลิปไม่ถูกต้อง ${context.read<CartItemModel>().cartId}');
                      _updatePayStatus(widget.Carts.cartId, 'สลิปไม่ถูกต้อง');
                    },
                    child: const Text(
                      "ปฎิเสธ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
