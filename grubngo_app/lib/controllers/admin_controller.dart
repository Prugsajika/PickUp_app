import 'dart:async';

import '../models/admininfo_model.dart';

import '../services/admin_service.dart';

class AdminController {
  // final HttpServices services;
  final AdminServices services;

  List<Admin> admins = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  AdminController(this.services);

  Future<List<Admin>> fetchAdminByEmail(String email) async {
    onSyncController.add(true);
    admins = await services.getEmailAdmin(email);
    onSyncController.add(false);
    // print(admins.first.adminName);
    return admins;
  }
}
