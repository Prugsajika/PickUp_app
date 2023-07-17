import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/controllers/admin_controller.dart';
import 'package:grubngo_app/models/riderinfo_model.dart';
import 'package:grubngo_app/pages/admin_approve.dart';
import 'package:grubngo_app/pages/admin_blacklist.dart';
import 'package:grubngo_app/services/admin_service.dart';

import 'package:provider/provider.dart';

import '../controllers/rider_controller.dart';
import '../models/admininfo_model.dart';

import '../services/rider_service.dart';
import '../widgets/admin_drawerappbar.dart';
import 'admin_approve_success_page.dart';
import 'admin_reject_success_page.dart';
import 'color.dart';

class HomePageAdmin extends StatefulWidget {
  @override
  State<HomePageAdmin> createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  List<Admin> admin = List.empty();

  List<Rider> waitRider = List.empty();
  RiderController controllerR = RiderController(RiderServices());

  final user = FirebaseAuth.instance.currentUser!;
  AdminController controllerAdmin = AdminController(AdminServices());

  void initState() {
    super.initState();

    // final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');
    _getAdmin(UserEmail);
    _getRidersWaitingApprove(context);
    _getRiders(context);
    setState(() {});
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

  void _getRidersWaitingApprove(BuildContext context) async {
    var waitRiders = await controllerR.fetchadminStat();
    waitRider = waitRiders.where((x) => x.statusApprove == '').toList();
    print('chk ${waitRider}');

    context.read<RiderModel>().getListRider = waitRiders;

//Count Status waiting for approve rider
    var statuswaiting = waitRider;
    int countstatuswaiting = statuswaiting.length;
    print('count wait $countstatuswaiting');

    context.read<RiderAdminModel>().Statuswaiting = countstatuswaiting;

//Count Status Approved rider
    var statusApprove = waitRiders.where((x) => x.statusApprove == 'Approved');
    int countstatusApprove = statusApprove.length;

    context.read<RiderAdminModel>().StatusApprove = countstatusApprove;

    var statusBL = waitRiders.where((x) => x.statusBL == true);
    int countstatusBL = statusBL.length;

    context.read<RiderAdminModel>().StatusBL = countstatusBL;
  }

  void _getRiders(BuildContext context) async {
    List<Rider> rider = List.empty();
    print('chk empty $rider');
    var newRiders = await controllerR.fetchActivateRiders();
    print('newRider $newRiders');

    print('chk activate user ${newRiders.length}');

    context.read<RiderModel>().getListRider = newRiders;
    print('list ${context.read<RiderModel>().getListRider}');
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'จำนวนผู้รับหิ้ว',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ApproveRiderPage()));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  context
                                      .watch<RiderAdminModel>()
                                      .statuswaiting
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'รออนุมัติ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                context
                                    .watch<RiderAdminModel>()
                                    .StatusApprove
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'อนุมัติ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlacklistPage()));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  context
                                      .watch<RiderAdminModel>()
                                      .StatusBL
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'แบล็คลิส',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
              'รายชื่อผู้รับหิ้ว',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<RiderModel>(
                  builder: (context, RiderModel data, child) {
                print(data.getListRider.length);
                return data.getListRider.length != 0
                    ? ListView.builder(
                        itemCount: data.getListRider.length,
                        itemBuilder: (context, index) {
                          return CardList(data.getListRider[index]);
                        })
                    : GestureDetector(
                        child: Center(
                            child: Text(
                        "ไม่มีรายการผู้รับหิ้ว",
                        style: TextStyle(
                          color: iBlueColor,
                        ),
                      )));
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final Rider riders;

  CardList(this.riders);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
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
          child: Column(
            children: [
              ListTile(
                // value: statusBL,
                shape: RoundedRectangleBorder(
                  //<-- SEE HERE
                  side: BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ชื่อ - นามสกุล : ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.riders.FirstName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      ' ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.riders.LastName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'อีเมล์ : ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.riders.email,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เบอร์โทร : ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.riders.TelNo,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'สถานนะแบล็คลิส : ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.riders.statusBL.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
