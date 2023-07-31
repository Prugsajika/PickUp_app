import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../controllers/report_controller.dart';
import '../models/cartitem_model.dart';
import '../models/report_model.dart';
import '../models/riderinfo_model.dart';
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
    List<Rider> rider = List.empty();
    List<Rider> apprider = List.empty();
    List<ReportCustomer> customer = List.empty();

    var Newrider = await controller.fetchReportRider();
    // Newcartitems.sort((a, b) => a.orderDate.compareTo(b.orderDate));
    // cartitems = Newcartitems.reversed.toList();
    apprider = Newrider.where((x) => x.statusApprove == 'Approved').toList();
    setState(() => rider = apprider);

    context.read<AdminReportRider>().getListAdminReportRider = rider;
    print('rider chk ${context.read<AdminReportRider>().Riderid}');

    int countapprider = apprider.length;
    context.read<CountRiderAdminModel>().StatusApprove = countapprider;

    var Newcustomer = await controller.fetchReportCustomer();
    // Newcartitems.sort((a, b) => a.orderDate.compareTo(b.orderDate));
    // cartitems = Newcartitems.reversed.toList();
    // reportcart = cartitems
    //     .where((x) =>
    //         x.status == 'จัดส่งสำเร็จ' || x.refundStatus == 'คืนเงินสำเร็จ')
    //     .toList();
    setState(() => customer = Newcustomer);

    context.read<AdminReportCustomer>().getListAdminReportCustomer = customer;
    print('customer chk ${context.read<AdminReportCustomer>().customerId}');

    int countallCustomer = customer.length;
    context.read<CountAdminModel>().customerCount = countallCustomer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerBar(),
      appBar: AppBar(
        title: Text('สถานะผู้ใช้งาน'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ผู้รับหิ้ว จำนวน ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  context
                      .watch<CountRiderAdminModel>()
                      .StatusApprove
                      .toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  ' คน ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: buildCardListRider(context),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ผู้งสั่งซื้อ จำนวน ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  context.watch<CountAdminModel>().customerCount.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  ' คน',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: buildCardListCustomer(context),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          ),
        ],
      ),
    );
  }
}

Widget buildCardListRider(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AdminReportRider>(
          builder: (context, AdminReportRider data, child) {
        return data.getListAdminReportRider.length != 0
            ? ListView.builder(
                itemCount: data.getListAdminReportRider.length,
                itemBuilder: (context, index) {
                  print('data');
                  print(data.getListAdminReportRider.length);

                  return CardListRider(
                      data.getListAdminReportRider[index], index);
                })
            : GestureDetector(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ไม่มีผู้ใช้งาน",
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

Widget buildCardListCustomer(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<AdminReportCustomer>(
          builder: (context, AdminReportCustomer data, child) {
        return data.getListAdminReportCustomer.length != 0
            ? ListView.builder(
                itemCount: data.getListAdminReportCustomer.length,
                itemBuilder: (context, index) {
                  print('data');
                  print(data.getListAdminReportCustomer.length);

                  return CardListCustomer(
                      data.getListAdminReportCustomer[index], index);
                })
            : GestureDetector(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ไม่มีผู้ใช้งาน",
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

class CardListRider extends StatelessWidget {
  final Rider riders;
  int index;
  CardListRider(this.riders, this.index);

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
          ),
        ),
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
                        'ชื่อ ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        riders.FirstName,
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
                            'นามสกุล ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            riders.LastName,
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
                    //         carts.totalCost.toString(),
                    //         maxLines: 2,
                    //         overflow: TextOverflow.ellipsis,
                    //         style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.normal),
                    //       ),
                    //       Text(
                    //         ' บาท',
                    //         maxLines: 2,
                    //         overflow: TextOverflow.ellipsis,
                    //         style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
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
                        riders.statusApprove,
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

class CardListCustomer extends StatelessWidget {
  final ReportCustomer customer;
  int index;
  CardListCustomer(this.customer, this.index);

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
                        'ชื่อ ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        customer.name,
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
                            'นามสกุล ',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            customer.lastName,
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
                    //         carts.totalCost.toString(),
                    //         maxLines: 2,
                    //         overflow: TextOverflow.ellipsis,
                    //         style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.normal),
                    //       ),
                    //       Text(
                    //         ' บาท',
                    //         maxLines: 2,
                    //         overflow: TextOverflow.ellipsis,
                    //         style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       Text(
                //         'ผู้รับหิ้ว ',
                //         maxLines: 2,
                //         overflow: TextOverflow.ellipsis,
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold),
                //       ),
                //       Text(
                //         carts.emailRider,
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
