import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/riderinfo_model.dart';

class RiderServices {
  get user => FirebaseAuth.instance.currentUser!;
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('rider');

  // CollectionReference _collectionBL =
  //     FirebaseFirestore.instance.collection('blacklist');

  Future<List<Rider>> getRiders() async {
    QuerySnapshot snapshot = await _collection.get();

    AllRiders riders = AllRiders.fromSnapshot(snapshot);

    print('QuerySnapshot All Riders ${riders.riders.length}');
    return riders.riders;
  }

  Future<List<Rider>> getAdminRiders() async {
    QuerySnapshot snapshot =
        await _collection.where('statusApprove', isEqualTo: 'Approved').get();

    AllRiders riders = AllRiders.fromSnapshot(snapshot);

    print('QuerySnapshot All Riders ${riders.riders.length}');
    return riders.riders;
  }

// get adminstat

  // final CollectionReference<Map<String, dynamic>> userList =
  //     FirebaseFirestore.instance.collection('rider');

  // Future<int> getadminStat() async {
  //   AggregateQuerySnapshot query = await userList.count().get();
  //   debugPrint('The number of users: ${query.count}');
  //   return query.count;
  // }
  getadminStat() async {
    var snapshot = await _collection.count().get().then(
          (res) => print(res.count),
          onError: (e) => print("Error completing: $e"),
        );

    // var snapshot = await myRef.count().get();
  }

  Future<List<Rider>> getRidersByEmail(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('rider')
        .where('email', isEqualTo: email.toLowerCase().toString())
        .get();

    AllRiders riders = AllRiders.fromSnapshot(snapshot);
    print("riders  $riders");
    return riders.riders;
  }

  Future<List<Rider>> getEmailRidersBlacklist(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('rider')
        .where('email', isEqualTo: email.toLowerCase().toString())
        .where('statusBL', isEqualTo: true)
        .get();

    AllRiders riders = AllRiders.fromSnapshot(snapshot);
    print("blacklists  $riders");
    return riders.riders;
  }

  Future<List<Rider>> getEmailRidersApprove(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('rider')
        .where('email', isEqualTo: email.toLowerCase().toString())
        .where('statusApprove', isEqualTo: 'Approved')
        .get();

    AllRiders riders = AllRiders.fromSnapshot(snapshot);
    print("Approve  $riders");
    return riders.riders;
  }

  Future<List<Rider>> getActivateRiders() async {
    QuerySnapshot snapshotAct = await FirebaseFirestore.instance
        .collection('rider')
        .where('statusApprove', isEqualTo: 'Approved')
        .get();

    AllRiders riders = AllRiders.fromSnapshot(snapshotAct);
    print("Approve  $riders");
    return riders.riders;
  }

  Future<List<WaitingRider>> getWaitingRiders() async {
    QuerySnapshot snapshotAct =
        await FirebaseFirestore.instance.collection('rider').get();

    AllWaitingRider waitingriders = AllWaitingRider.fromSnapshot(snapshotAct);
    print("Approve  $waitingriders");
    return waitingriders.waitingriders;
  }

  void addRider(String FirstName, LastName, Gender, TelNo, email, idCard, UrlQr,
      bool statusBL, String UrlCf) async {
    FirebaseFirestore.instance.collection('rider').add({
      // 'id': "",
      'FirstName': FirstName,
      'LastName': LastName,
      'Gender': Gender,
      'TelNo': TelNo,
      'email': email,
      'password': '',
      'idCard': idCard,
      'UrlQr': UrlQr,
      'statusBL': false,
      'UrlCf': UrlCf,
      'role': "rider",
      'statusApprove': '',
    }).then((value) =>
        FirebaseFirestore.instance.collection('rider').doc(value.id).update({
          'Riderid': value.id,
        }));
  }

  void updateAc(Rider item) async {
    print(item.Riderid);
    await _collection.doc(item.Riderid).update({
      // 'imagerider': item.imagerider,
      // 'FirstName': item.FirstName,
      // 'LastName': item.LastName,
      // 'Gender': item.Gender,
      // 'TelNo': item.TelNo,
      'email': item.email,
      'UrlQr': item.UrlQr,
      // 'status': item.status,
    });
  }

  void updateBLStatus(String riderid, bool statusBL) async {
    FirebaseFirestore.instance.collection('rider').doc(riderid).update({
      'riderid': riderid,
      'statusBL': statusBL,
    });
    print('rider id for service update BL status $riderid');
  }

  void updateApproveStatus(String riderid, String statusApprove) async {
    FirebaseFirestore.instance.collection('rider').doc(riderid).update({
      'riderid': riderid,
      'statusApprove': statusApprove,
    });
  }

  void updateRejectStatus(String riderid, String statusApprove) async {
    FirebaseFirestore.instance.collection('rider').doc(riderid).update({
      'riderid': riderid,
      'statusApprove': statusApprove,
    });
  }

  void updateProfile(String FirstName, LastName, TelNo, UrlQr, riderid) async {
    FirebaseFirestore.instance.collection('rider').doc(riderid).update({
      'FirstName': FirstName,
      'LastName': LastName,
      'TelNo': TelNo,
      'UrlQr': UrlQr,
      'riderid': riderid
    });
  }
}
