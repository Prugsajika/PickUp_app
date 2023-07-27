import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../controllers/report_controller.dart';
import '../models/cartitem_model.dart';
import '../models/report_model.dart';
import '../services/report_services.dart';
import '../widgets/admin_drawerappbar.dart';
import 'color.dart';

class AdminUserReportPage extends StatefulWidget {
  @override
  State<AdminUserReportPage> createState() => _AdminUserReportPageState();
}

class _AdminUserReportPageState extends State<AdminUserReportPage> {
  ReportController controller = ReportController(ReportServices());

  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');

    _getReport();
  }

  void _getReport() async {
    List<CartItem> cartitems = List.empty();
    List<CartItem> reportcart = List.empty();

    var Newcartitems = await controller.fetchReport();
    Newcartitems.sort((a, b) => a.orderDate.compareTo(b.orderDate));
    cartitems = Newcartitems.reversed.toList();
    reportcart = cartitems
        .where((x) =>
            x.status == 'จัดส่งสำเร็จ' || x.refundStatus == 'คืนเงินสำเร็จ')
        .toList();
    setState(() => reportcart = reportcart);

    context.read<AdminReportCartItem>().getListAdminReportCartItem = reportcart;
    print('cart chk ${context.read<AdminReportCartItem>().cartId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerBar(),
      appBar: AppBar(
        title: Text('สถานะผู้ใช้งาน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AdminReportCartItem>(
            builder: (context, AdminReportCartItem data, child) {
          return data.getListAdminReportCartItem.length != 0
              ? ListView.builder(
                  itemCount: data.getListAdminReportCartItem.length,
                  itemBuilder: (context, index) {
                    print('data');
                    print(data.getListAdminReportCartItem.length);

                    return CardList(
                        data.getListAdminReportCartItem[index], index);
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
                        // ElevatedButton(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Column(
                        //       children: [
                        //         Text('ดูรายการที่ต้องจัดส่ง'),
                        //       ],
                        //     ),
                        //   ),
                        //   onPressed: () {
                        //     setState(() {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   StatusDeliveryPage()));
                        //     });
                        //   },
                        // ),
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
                        'ผู้รับหิ้ว ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        carts.emailRider,
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
                        'สถานะ ',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        carts.status,
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

          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(carts.image),
          // ),
          // trailing: const Icon(Icons.arrow_forward_ios),
          // onTap: () {
          //   print('#######################carts ID ${carts.cartId}');
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => ConfirmPaymentPage(Carts: carts)));
          // },
        ),
      ),
    );
  }
}
