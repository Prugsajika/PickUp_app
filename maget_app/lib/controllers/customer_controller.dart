import 'dart:async';

import '../models/customer_model.dart';
import '../services/customer_services.dart';

class CustomerController {
  // final HttpServices services;
  final CustomerServices services;
  List<Customer> customers = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  CustomerController(this.services);

  Future<List<Customer>> fetchCustomers() async {
    onSyncController.add(true);
    customers = await services.getCustomers();
    onSyncController.add(false);
    return customers;
  }

  // void updateRegister(Register register) async {
  //   services.update(register);
  // }

  Future<List<Customer>> fetchCustomersByEmail(String email) async {
    onSyncController.add(true);
    customers = await services.getCustomersByEmail(email);
    onSyncController.add(false);
    return customers;
  }

  void addCustomer(
      String name, lastName, Gender, password, telNo, idCard, email) async {
    services.add(name, lastName, Gender, password, telNo, idCard, email);
  }
}
