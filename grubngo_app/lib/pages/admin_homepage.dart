import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/controllers/admin_controller.dart';
import 'package:grubngo_app/services/admin_service.dart';

import 'package:provider/provider.dart';

import '../models/admininfo_model.dart';

import '../widgets/admin_drawerappbar.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  List<Admin> admin = List.empty();

  final user = FirebaseAuth.instance.currentUser!;
  AdminController controllerAdmin = AdminController(AdminServices());

  void initState() {
    super.initState();

    // final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');
    _getAdmin(UserEmail);
  }

  void _getAdmin(String userEmail) async {
    print('_getAdmin : $userEmail');
    List<Admin> admin = List.empty();
    var useradmin = await controllerAdmin.fetchAdminByEmail(userEmail);
    print("useradmin  $useradmin");
    setState(() => admin = useradmin);
    print('_getuseradmin  : ${admin.first.adminEmail}');

    if (!admin.isEmpty) {
      context.read<AdminModel>()
        ..adminEmail = admin.first.adminEmail
        ..adminId = admin.first.adminId
        ..adminLastname = admin.first.adminLastname
        ..adminName = admin.first.adminName
        ..adminRole = admin.first.adminRole;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerBar(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<AdminModel>(
                  builder: (context, AdminModel admin, child) {
                return Text('แอดมิน' ' : ${admin.adminName}' +
                    ' ${admin.adminLastname}');
              }),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text('สวัสดี!! ' +
            //       context.read<AdminModel>().adminName +
            //       ' ' +
            //       context.read<AdminModel>().adminLastname),
            // ),

            // Text('สวัสดี!! XXXXXXXXX'),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/Login');
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.attach_money),
                          Text(
                            'จำนวนผู้ใช้งานทั้งหมด',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          // Text(context
                          //     .read<CartItemModel>()
                          //     .totalCost
                          //     .toString()),

                          // Consumer<AdminModel>(
                          //   builder: (context, AdminModel admin, child) {
                          //     return Text('${admin.adminName}');
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                //       Expanded(
                //         child: Card(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //               children: [
                //                 Text('ยอดขายเดือนนี้'),
                //                 Text('0.00฿'),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(15.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //     children: [
                //       Expanded(
                //         child: Card(
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //               children: [
                //                 Text('โอนเงินแล้ว'),
                //                 Text('- ราย'),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                // Expanded(
                //   child: Card(
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Text('รอโอนเงิน'),
                //           Text('- ราย'),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'รายการที่รออนุมัติ',
            ),
          ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Consumer<CartItemModel>(
          //         builder: (context, CartItemModel data, child) {
          //       return data.getListCartItem.length != 0
          //           ? ListView.builder(
          //               itemCount: data.getListCartItem.length,
          //               itemBuilder: (context, index) {
          //                 print(data.getListCartItem.length);

          //                 return CardList(data.getListCartItem[index], index);
          //               },
          //             )
          //           : GestureDetector(
          //               child: Center(
          //                 child: Text(
          //                   "ไม่มีรายการสั่งซื้อ",
          //                   style: TextStyle(
          //                     color: Colors.black,
          //                   ),
          //                 ),
          //               ),
          //             );
          //     }),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 450,
          //     child: GridView.builder(
          //       itemCount: 10,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 1,
          //         childAspectRatio: (6 / 2),
          //       ),
          //     //   itemBuilder: (context, index) => Widget(),
          //     // ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
