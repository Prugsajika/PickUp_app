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

class AdminSaleReportPage extends StatefulWidget {
  @override
  State<AdminSaleReportPage> createState() => _AdminSaleReportPageState();
}

class _AdminSaleReportPageState extends State<AdminSaleReportPage> {
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
    List<CartItem> successorder = List.empty();
    List<CartItem> refundorder = List.empty();

    var Newcartitems = await controller.fetchReportCartItem();
    Newcartitems.sort((a, b) => a.orderDate.compareTo(b.orderDate));
    cartitems = Newcartitems.reversed.toList();

    //status จัดส่งสำเร็จ
    successorder = cartitems.where((x) => x.status == 'จัดส่งสำเร็จ').toList();
    setState(() => successorder = successorder);

    context
        .read<AdminOrderSuccessSentStatus>()
        .getListAdminOrderSuccessSentStatus = successorder;

    //status คืนเงิน
    refundorder =
        cartitems.where((x) => x.refundStatus == 'คืนเงินสำเร็จ').toList();
    setState(() => refundorder = refundorder);

    context.read<AdminOrderRefundStatus>().getListAdminOrderRefundStatus =
        refundorder;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: AdminDrawerBar(),
        appBar: AppBar(
          title: const Text("รายงานการขาย"),
          backgroundColor: Colors.red[500],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.delivery_dining),
                text: "จัดส่งสำเร็จ",
              ),
              Tab(
                icon: Icon(Icons.money),
                text: "คืนเงิน",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: buildCardListSuccess(context),
            ),
            Center(
              child: buildCardListRefund(context),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCardListSuccess(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AdminOrderSuccessSentStatus>(
          builder: (context, AdminOrderSuccessSentStatus data, child) {
        return data.getListAdminOrderSuccessSentStatus.length != 0
            ? ListView.builder(
                itemCount: data.getListAdminOrderSuccessSentStatus.length,
                itemBuilder: (context, index) {
                  print('data');
                  print(data.getListAdminOrderSuccessSentStatus.length);

                  return CardListSuccess(
                      data.getListAdminOrderSuccessSentStatus[index], index);
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

Widget buildCardListRefund(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AdminOrderRefundStatus>(
          builder: (context, AdminOrderRefundStatus data, child) {
        return data.getListAdminOrderRefundStatus.length != 0
            ? ListView.builder(
                itemCount: data.getListAdminOrderRefundStatus.length,
                itemBuilder: (context, index) {
                  print('data');
                  print(data.getListAdminOrderRefundStatus.length);

                  return CardListRefund(
                      data.getListAdminOrderRefundStatus[index], index);
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

class CardListSuccess extends StatelessWidget {
  final CartItem carts;
  int index;
  CardListSuccess(this.carts, this.index);

  @override
  Widget build(BuildContext context) {
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
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       Text(
                //         'สถานะ ',
                //         maxLines: 2,
                //         overflow: TextOverflow.ellipsis,
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       Text(
                //         carts.status,
                //         maxLines: 2,
                //         overflow: TextOverflow.ellipsis,
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 16,
                //             fontWeight: FontWeight.normal),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardListRefund extends StatelessWidget {
  final CartItem carts;
  int index;
  CardListRefund(this.carts, this.index);

  @override
  Widget build(BuildContext context) {
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
                        'เหตุผล ',
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
        ),
      ),
    );
  }
}
