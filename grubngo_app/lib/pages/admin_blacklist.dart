import 'package:flutter/material.dart';
import 'package:grubngo_app/widgets/admin_drawerappbar.dart';
import 'package:provider/provider.dart';

import '../controllers/rider_controller.dart';
import '../models/riderinfo_model.dart';
import '../services/rider_service.dart';
import 'color.dart';

class BlacklistPage extends StatefulWidget {
  @override
  State<BlacklistPage> createState() => _BlacklistPageState();
}

class _BlacklistPageState extends State<BlacklistPage> {
  List<Rider> rider = List.empty();
  RiderController controllerR = RiderController(RiderServices());

  @override
  void initState() {
    super.initState();
    _getAdminRiders(context);
    setState(() {});
  }

  void _getAdminRiders(BuildContext context) async {
    var newRider = await controllerR.fetchAdminRiders();
    print('chk ${newRider.length}');

    context.read<AdminRiderModel>().getListAdminRiderModel = newRider;
    print('provider ${context.read<AdminRiderModel>().email}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerBar(),
      appBar: AppBar(
        title: Text('แบล็คลิส'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AdminRiderModel>(
            builder: (context, AdminRiderModel data, child) {
          return data.getListAdminRiderModel.length != 0
              ? ListView.builder(
                  itemCount: data.getListAdminRiderModel.length,
                  itemBuilder: (context, index) {
                    print(
                        '${data.getListAdminRiderModel[index].statusBL} BLPAge');

                    return CardList(data.getListAdminRiderModel[index]);
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
  bool statusBL = false;

  RiderController controller = RiderController(RiderServices());

  void initState() {
    super.initState();

    statusBL = widget.riders.statusBL;
    print('BL rider status start $statusBL');

    setState(() {
      // statusBL = context.read<AdminRiderBL>().statusBL;
    });
  }

  void _getAdminRiders(BuildContext context) async {
    var newRider = await controller.fetchAdminRiders();
    print('chk ${newRider.length}');

    context.read<AdminRiderModel>().getListAdminRiderModel = newRider;
    print('provider ${context.read<AdminRiderModel>().email}');
  }

  void _updateBLStatus(String Riderid, bool statusBL) async {
    controller.updateBLStatus(Riderid, statusBL);

    setState(() {});
    print('chk confirm BL status ' + Riderid);
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
        child: SwitchListTile(
          value: statusBL,
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
          subtitle: Row(
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
          onChanged: (bool value) {
            statusBL = value;
            _updateBLStatus(widget.riders.Riderid, statusBL);

            _getAdminRiders(context);

            print('${context.read<AdminRiderModel>().statusBL}  chk status');
            print('BL Status $statusBL');
          },
        ),
      ),
    );
  }
}
