import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  late String adminId;
  late String adminName;
  late String adminLastname;
  late String adminEmail;
  late String adminRole;

  Admin(
    this.adminId,
    this.adminName,
    this.adminLastname,
    this.adminEmail,
    this.adminRole,
  );
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      json['adminId'] as String,
      json['adminName'] as String,
      json['adminLastname'] as String,
      json['adminEmail'] as String,
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
