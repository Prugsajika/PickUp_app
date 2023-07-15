import 'dart:async';
import 'dart:ffi';

import '../models/riderinfo_model.dart';
import '../services/rider_service.dart';

class RiderController {
  // final HttpServices services;
  final RiderServices services;
  List<Rider> riders = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  RiderController(this.services);

  // Future<List<Rider>> getRider() async {
  //   // onSyncController.add(true);
  //   riders = await services.getRiders();
  //   // onSyncController.add(false);
  //   return riders;
  // }

  // void updateRegister(Register register) async {
  //   services.update(register);
  // }

  Future<List<Rider>> fetchRiders() async {
    onSyncController.add(true);
    riders = await services.getRiders();
    onSyncController.add(false);
    return riders;
  }

  Future<List<Rider>> fetchRidersByEmail(String email) async {
    onSyncController.add(true);
    riders = await services.getRidersByEmail(email);
    onSyncController.add(false);
    return riders;
  }

  Future<List<Rider>> fetchBlacklistByEmail(String email) async {
    onSyncController.add(true);
    riders = await services.getEmailRidersBlacklist(email);
    onSyncController.add(false);
    return riders;
  }

  Future<List<Rider>> fetchApproveRiderByEmail(String email) async {
    onSyncController.add(true);
    riders = await services.getEmailRidersApprove(email);
    onSyncController.add(false);
    return riders;
  }

  Future<List<Rider>> fetchActivateRiders() async {
    onSyncController.add(true);
    riders = await services.getActivateRiders();
    onSyncController.add(false);
    return riders;
  }

  fetchRidersinfo(String userEmail) {}

  // void addRider(String name, lastName, birthDay, password, bank, bankAccount,
  //     email) async {
  //   services.add(name, lastName, birthDay, password, bank, bankAccount, email);
  // }
  // updateRider(Rider rider) {
  //   services.update(rider);
  // }

  void addRider(String FirstName, LastName, Gender, TelNo, email, idCard,
      imageQR, bool statusBL, String UrlCf) async {
    services.addRider(FirstName, LastName, Gender, TelNo, email, idCard,
        imageQR, statusBL, UrlCf);
  }

  void updateBLStatus(String riderid, bool statusBL) async {
    services.updateBLStatus(riderid, statusBL);
  }

  void updateApproveStatus(String riderid, String statusApprove) async {
    services.updateApproveStatus(riderid, statusApprove);
  }

  void updateRejectStatus(String riderid, String statusApprove) async {
    services.updateRejectStatus(riderid, statusApprove);
  }

  void updatePrifile(String FirstName, LastName, TelNo, UrlQr, riderid) async {
    services.updatePrifile(FirstName, LastName, TelNo, UrlQr, riderid);
  }
}
