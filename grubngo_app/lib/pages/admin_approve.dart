import 'package:flutter/material.dart';
import 'package:grubngo_app/widgets/admin_drawerappbar.dart';
import 'package:provider/provider.dart';

import '../controllers/rider_controller.dart';
import '../models/riderinfo_model.dart';
import '../services/rider_service.dart';
import 'color.dart';

class ApproveRiderPage extends StatefulWidget {
  @override
  State<ApproveRiderPage> createState() => _ApproveRiderPageState();
}

class _ApproveRiderPageState extends State<ApproveRiderPage> {
  List<Rider> rider = List.empty();
  RiderController controllerR = RiderController(RiderServices());

  @override
  void initState() {
    super.initState();
    _getRiders(context);
    setState(() {});
  }

  void _getRiders(BuildContext context) async {
    var newRider = await controllerR.fetchRiders();
    print('chk ${newRider}');

    context.read<RiderModel>().getListRider = newRider;
    print('provider ${context.read<RiderModel>().email}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerBar(),
      appBar: AppBar(
        title: Text('อนุมัติผู้รับหิ้ว'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<RiderModel>(builder: (context, RiderModel data, child) {
          return data.getListRider.length != 0
              ? ListView.builder(
                  itemCount: data.getListRider.length,
                  itemBuilder: (context, index) {
                    print(data.getListRider.length);

                    return CardList(data.getListRider[index]);
                  })
              : GestureDetector(
                  child: Center(
                      child: Text(
                  "ไม่มีข้อมูล",
                  style: TextStyle(
                    color: iBlueColor,
                  ),
                )));
        }),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/5');
      //   },
      //   backgroundColor: Colors.red[500],
      //   child: const Icon(Icons.add),
      // ),
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
  String statusApprove = '';

  RiderController controller = RiderController(RiderServices());

  void initState() {
    super.initState();
    statusApprove = widget.riders.statusApprove;
    print('status Approve rider start $statusApprove');
    setState(() {});
  }

  void _updateApproveStatus(String Riderid, String statusApprove) async {
    controller.updateApproveStatus(Riderid, statusApprove);
    setState(() {});
    print('chk confirm Approve status' + Riderid);
  }

  // void _updateRejectStatus(String Riderid, String statusApprove) async {
  //   controller.updateRejectStatus(Riderid, statusApprove);
  //   setState(() {});
  //   print('chk confirm reject status' + Riderid);
  // }

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
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.riders.FirstName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      ' ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.riders.LastName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'อีเมล์ : ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.riders.email,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(Icons.check),
                            Text('อนุมัติ'),
                          ],
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _updateApproveStatus(
                              widget.riders.Riderid, 'Approved');
                        });
                      },
                    ),
                    ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Icon(Icons.close),
                            Text('ปฎิเสธ'),
                          ],
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _updateApproveStatus(
                              widget.riders.Riderid, 'Rejected');
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
