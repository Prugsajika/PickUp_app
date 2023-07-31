import 'dart:async';

import '../models/cartitem_model.dart';
import '../models/products_model.dart';
import '../models/report_model.dart';
import '../models/riderinfo_model.dart';
import '../services/report_services.dart';

class ReportController {
  final ReportServices services;
  List<CartItem> cartitems = List.empty();
  List<Rider> riders = List.empty();
  List<ReportCustomer> customers = List.empty();
  List<Product> products = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  ReportController(this.services);

  Future<List<CartItem>> fetchReportCartItem() async {
    // controller status => Start
    onSyncController.add(true);
    cartitems = await services.getReportCartItem();
    // controller status => End
    onSyncController.add(false);

    return cartitems;
  }

  Future<List<CartItem>> fetchReportCartItemByEmail(String emailRider) async {
    // controller status => Start
    onSyncController.add(true);
    cartitems = await services.getReportCartItemByEmail(emailRider);
    // controller status => End
    onSyncController.add(false);

    return cartitems;
  }

  Future<List<Rider>> fetchReportRider() async {
    // controller status => Start
    onSyncController.add(true);
    riders = await services.getReportRider();
    // controller status => End
    onSyncController.add(false);

    return riders;
  }

  Future<List<ReportCustomer>> fetchReportCustomer() async {
    // controller status => Start
    onSyncController.add(true);
    customers = await services.getReportCustomer();
    // controller status => End
    onSyncController.add(false);

    return customers;
  }

  Future<List<Product>> fetchReportProductActive() async {
    // controller status => Start
    onSyncController.add(true);
    products = await services.getReportProductActivate();
    // controller status => End
    onSyncController.add(false);

    return products;
  }

  Future<List<Product>> fetchReportProductNotActive() async {
    // controller status => Start
    onSyncController.add(true);
    products = await services.getReportProductNotActivate();
    // controller status => End
    onSyncController.add(false);

    return products;
  }

  Future<List<Product>> fetchReportProductAll() async {
    // controller status => Start
    onSyncController.add(true);
    products = await services.getReportProductAll();
    // controller status => End
    onSyncController.add(false);

    return products;
  }
}
