import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/models/products_model.dart';
import 'package:provider/provider.dart';

import '../controllers/rider_controller.dart';
import '../models/riderinfo_model.dart';
import '../services/rider_service.dart';
import 'color.dart';
import '../models/riderinfo_model.dart';
import '../widgets/drawerappbar.dart';
import 'products_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Rider> rider = List.empty();
  final user = FirebaseAuth.instance.currentUser!;
  RiderController controllerR = RiderController(RiderServices());
  void initState() {
    super.initState();
    _getEmail(context);

    final user = FirebaseAuth.instance.currentUser!;
    String UserEmail = user.email.toString();
    print('user $UserEmail');
    _getuserRider(UserEmail);
  }

  void _getuserRider(String userEmail) async {
    print('_getuserRider : $userEmail');
    List<Rider> rider = List.empty();
    var userRider = await controllerR.fetchRidersByEmail(userEmail);
    print("userRider  $userRider");
    setState(() => rider = userRider);
    print('_getuserRider UrlQr : ${rider.first.UrlQr}');
    //UrlQr = rider.first.UrlQr;

    if (!rider.isEmpty) {
      context.read<RiderModel>()
        ..UrlCf = rider.first.UrlCf
        ..FirstName = rider.first.FirstName
        ..LastName = rider.first.LastName
        ..Gender = rider.first.Gender
        ..TelNo = rider.first.TelNo
        ..status = rider.first.status
        ..idCard = rider.first.idCard
        ..email = rider.first.email
        ..UrlQr = rider.first.UrlQr;
    }
  }

  void _getEmail(BuildContext context) async {
    // get data  MedicalDashboard
    context.read<emailProvider>().email = user.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerBar(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Consumer<RiderModel>(builder: (context, value, child) {
            //     return Text('สวัสดี!!' ' : ${value.FirstName}');
            //   }),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('สวัสดี!! ' +
                  context.read<RiderModel>().FirstName +
                  ' ' +
                  context.read<RiderModel>().LastName),
            ),

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
                          Text('ยอดขายวันนี้'),
                          Text('0.00 ฿'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('ยอดขายเดือนนี้'),
                          Text('0.00฿'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('โอนเงินแล้ว'),
                          Text('- ราย'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('รอโอนเงิน'),
                          Text('- ราย'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'รายการสินค้าที่ต้องจัดส่ง',
            ),
          ),
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
