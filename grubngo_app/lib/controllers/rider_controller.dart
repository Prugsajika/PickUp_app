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

  // void addRider(String name, lastName, birthDay, password, bank, bankAccount,
  //     email) async {
  //   services.add(name, lastName, birthDay, password, bank, bankAccount, email);
  // }
  // updateRider(Rider rider) {
  //   services.update(rider);
  // }

  void addRider(String FirstName, LastName, Gender, TelNo, email, idCard,
      imageQR, bool status, String UrlCf) async {
    services.addRider(FirstName, LastName, Gender, TelNo, email, idCard,
        imageQR, status, UrlCf);
  }
}
