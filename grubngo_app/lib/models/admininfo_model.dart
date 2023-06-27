import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  late String adminId;
  // //late String imagerider;
  late String adminName;
  late String adminLastname;
  // late String Gender;
  // late String TelNo;
  late String adminEmail;
  // late String password;
  // late String idCard;
  // late String UrlQr;
  // late bool status;
  // late String UrlCf;
  late String adminRole;

  Admin(
    this.adminId,
    // this.imagerider,
    // this.Riderid,
    this.adminName,
    this.adminLastname,
    // this.Gender,
    // this.TelNo,
    this.adminEmail,
    // this.password,
    // this.idCard,
    // this.UrlQr,
    // this.status,
    // this.UrlCf,
    this.adminRole,
  );
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      json['adminId'] as String,
      json['adminName'] as String,
      json['adminLastname'] as String,
      // json['Gender'] as String,
      // json['TelNo'] as String,
      json['adminEmail'] as String,
      // json['password'] as String,
      // json['idCard'] as String,
      // json['UrlQr'] as String,
      // json['status'] as bool,
      // json['UrlCf'] as String,
      json['adminRole'] as String,
    );
  }
}

class AllAdmins {
  final List<Admin> admins;

  AllAdmins(this.admins);
  factory AllAdmins.fromJson(List<dynamic> json) {
    List<Admin> admins;

    admins = json.map((index) => Admin.fromJson(index)).toList();

    return AllAdmins(admins);
  }

  factory AllAdmins.fromSnapshot(QuerySnapshot s) {
    List<Admin> admins = s.docs.map((DocumentSnapshot ds) {
      print("admindocumentsnapshot ${ds.data()}");
      Admin admin = Admin.fromJson(ds.data() as Map<String, dynamic>);
      admin.adminId = ds.id;
      print("admindocumentsnapshot ${admin.adminEmail}");
      return admin;
    }).toList();

    return AllAdmins(admins);
  }
}

class AdminModel extends ChangeNotifier {
  String adminId = '';
  String adminName = '';
  String adminLastname = '';
  String adminEmail = '';
  String adminRole = '';

  get getAdminId => this.adminId;

  set setAdminId(adminId) => this.adminId = adminId;

  get getAdminName => this.adminName;

  set setAdminName(adminName) => this.adminName = adminName;

  get getAdminLastname => this.adminLastname;

  set setAdminLastname(adminLastname) => this.adminLastname = adminLastname;

  get getAdminEmail => this.adminEmail;

  set setAdminEmail(adminEmail) => this.adminEmail = adminEmail;

  get getAdminRole => this.adminRole;

  set setAdminRole(adminRole) => this.adminRole = adminRole;
}
