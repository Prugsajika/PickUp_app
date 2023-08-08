import 'package:flutter/material.dart';
import 'package:grubngo_app/pages/admin_reject_success_page.dart';
import 'package:grubngo_app/widgets/admin_drawerappbar.dart';
import 'package:provider/provider.dart';

import '../controllers/rider_controller.dart';
import '../models/riderinfo_model.dart';
import '../services/rider_service.dart';
import 'admin_approve_success_page.dart';
import 'color.dart';

class ApproveRiderPage extends StatefulWidget {
  @override
  State<ApproveRiderPage> createState() => _ApproveRiderPageState();
}

class _ApproveRiderPageState extends State<ApproveRiderPage> {
  List<Rider> rider = List.empty();
  List<Rider> newRider = List.empty();
  RiderController controllerR = RiderController(RiderServices());

  @override
  void initState() {
    super.initState();
    _getRiders(context);
    setState(() {});
  }

  void _getRiders(BuildContext context) async {
    var newRiders = await controllerR.fetchRiders();
    newRider = newRiders.where((x) => x.statusApprove == '').toList();
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
                  "ไม่มีรายการรออนุมัติ",
                  style: TextStyle(
                    color: iBlueColor,
                  ),
                )));
        }),
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

  void _updateBLStatus(String Riderid, bool statusBL) async {
    controller.updateBLStatus(Riderid, statusBL);
    setState(() {});
    print('chk confirm BL status' + Riderid);
  }

  void _updateRejectStatus(String Riderid, String statusApprove) async {
    controller.updateRejectStatus(Riderid, statusApprove);
    setState(() {});
    print('chk confirm reject status' + Riderid);
  }

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'ชื่อ - นามสกุล : ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.riders.FirstName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.riders.LastName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'อีเมล์ : ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.riders.email,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'เลขบัตรประชาชน : ',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.riders.idCard,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
              Card(
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.riders.UrlCf),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ApproveSuccessPage()));
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

                          _updateBLStatus(widget.riders.Riderid, true);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RejectSuccessPage()));
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
