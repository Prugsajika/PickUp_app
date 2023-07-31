import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../controllers/report_controller.dart';
import '../models/cartitem_model.dart';
import '../models/report_model.dart';
import '../services/report_services.dart';
import '../widgets/drawerappbar.dart';
import 'color.dart';

class SaleReportPage extends StatefulWidget {
  @override
  State<SaleReportPage> createState() => _SaleReportPageState();
}

class _SaleReportPageState extends State<SaleReportPage> {
  ReportController controller = ReportController(ReportServices());

  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');

    _getReportByEmail(UserEmail);
  }

  void _getReportByEmail(String emailRider) async {
    List<CartItem> cartitems = List.empty();
    List<CartItem> reportcart = List.empty();

    var Newcartitems = await controller.fetchReportCartItemByEmail(emailRider);
    Newcartitems.sort((a, b) => a.orderDate.compareTo(b.orderDate));
    cartitems = Newcartitems.reversed.toList();
    reportcart = cartitems.where((x) => x.status == 'จัดส่งสำเร็จ').toList();
    setState(() => reportcart = reportcart);
    print('emailRider $emailRider');

    context.read<ReportCartItem>().getListReportCartItem = reportcart;
    print('cart chk ${context.read<ReportCartItem>().cartId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(
        title: Text('รายงานการขาย'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ReportCartItem>(
            builder: (context, ReportCartItem data, child) {
          return data.getListReportCartItem.length != 0
              ? ListView.builder(
                  itemCount: data.getListReportCartItem.length,
                  itemBuilder: (context, index) {
                    print('data');
                    print(data.getListReportCartItem.length);

                    return CardList(data.getListReportCartItem[index], index);
                  })
              : GestureDetector(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ไม่มีรายงานการขาย",
                          style: TextStyle(
                            color: iBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  final CartItem carts;
  int index;
  CardList(this.carts, this.index);

  @override
  Widget build(BuildContext context) {
    late DateTime date;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )),
        child: ListTile(
          shape: RoundedRectangleBorder(
            //<-- SEE HERE
            side: BorderSide(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'วันที่ ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        carts.orderDate,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'สินค้า ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            carts.nameProduct,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            carts.totalCost.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            ' บาท',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'ลูกค้า ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        carts.email,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
