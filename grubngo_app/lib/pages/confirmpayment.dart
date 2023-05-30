import 'package:flutter/material.dart';
import 'package:grubngo_app/pages/home_page.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_controller.dart';
import '../models/cartitem_model.dart';
import '../services/cart_services.dart';

class ConfirmPaymentPage extends StatefulWidget {
  const ConfirmPaymentPage({super.key, required this.Carts});
  final CartItem Carts;
  @override
  State<ConfirmPaymentPage> createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  CartController cartcontroller = CartController(CartServices());

  void _updatePayStatus(String cartId, status) async {
    cartcontroller.updatePaystatus(cartId, status);
    setState(() {});
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
                child: Consumer<CartItemModel>(
                  builder: (context, value, child) {
                    return Image.network(
                      // 'https://firebasestorage.googleapis.com/v0/b/is-devops-prugsajika.appspot.com/o/confirmPayimg%2FC33EF892-275F-42C9-803C-D732DFD4A2B8.jpg%2FconfirmPay?alt=media&token=3bbd4253-f979-4e33-b6a1-8290ad7d1ef2',
                      '${value.confirmPayimg}',
                      height: 400,
                    );
                  },
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
                            "จำนวนเงินทั้งหมด",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Consumer<CartItemModel>(
                            builder: (context, value, child) {
                              return Text(
                                ' ${value.totalCost} บาท',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              );
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "วันที่โอน",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Consumer<CartItemModel>(
                            builder: (context, value, child) {
                              return Text(
                                ' ${value.paydate} เวลา ${value.paytime} น.',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              );
                            },
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
                      print('ยืนยันสลิปแล้ว');
                      _updatePayStatus(context.read<CartItemModel>().cartId,
                          "ยืนยันสลิปแล้ว");
                    },
                    child: Text(
                      "ยืนยัน",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      print('สลิปไม่ถูกต้อง');
                      _updatePayStatus(context.read<CartItemModel>().cartId,
                          'สลิปไม่ถูกต้อง');
                    },
                    child: Text(
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
