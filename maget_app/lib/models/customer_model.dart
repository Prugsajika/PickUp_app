import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controllers/customer_controller.dart';
import '../services/customer_services.dart';

class Customer {
  late String customerId;
  // late String id;
  late String name;
  late String lastName;
  late String Gender;
  late String profilePicture;
  late String password;
  late String idCard;
  late String telNo;
  late String email;
  late bool status;
  late String role;

  Customer(
      this.customerId,
      this.name,
      this.lastName,
      this.Gender,
      this.password,
      this.idCard,
      this.telNo,
      this.email,
      this.status,
      this.role);

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      json['customerId'] as String,
      // json['id'] as String,
      json['name'] as String,
      json['lastName'] as String,
      json['Gender'] as String,
      json['password'] as String,
      json['idCard'] as String,
      json['telNo'] as String,
      json['email'] as String,
      json['status'] as bool,
      json['role'] as String,
    );
  }
}

class AllCustomers {
  final List<Customer> customers;

  AllCustomers(this.customers);

  factory AllCustomers.fromJson(List<dynamic> json) {
    List<Customer> customers;

    customers = json.map((index) => Customer.fromJson(index)).toList();

    return AllCustomers(customers);
  }

  factory AllCustomers.fromSnapshot(QuerySnapshot s) {
    List<Customer> customers = s.docs.map((DocumentSnapshot ds) {
      Customer customer = Customer.fromJson(ds.data() as Map<String, dynamic>);
      customer.customerId = ds
          .id; //after mapping from firevase can insert or replace value before return list
      return customer;
    }).toList();
    return AllCustomers(customers);
  }
}

class ProfileDetailModel with ChangeNotifier {
  late String customerId = '';
  // late String id = '';
  String name = '';
  String lastName = '';
  String birthDay = '';
  String email = '';
  String profilePicture = '';
  String password = '';
  String idCard = '';
  String telNo = '';
  late bool status = false;
  String role = '';
  String Gender = '';

  // get getId => this.id;
  // set setId(value) {
  //   this.id = value;
  //   notifyListeners();
  // }

  get getCustomerId => this.customerId;
  set setCustomerId(value) {
    this.customerId = value;
    notifyListeners();
  }

  get getStatus => this.status;
  set setStatus(value) {
    this.status = value;
    notifyListeners();
  }

  get getName => this.name;
  set setName(value) {
    this.name = value;
    notifyListeners();
  }

  get getLastName => this.lastName;
  set setLastName(value) {
    this.lastName = value;
    notifyListeners();
  }

  get getBirthDay => this.birthDay;
  set setbirthDay(value) {
    this.birthDay = value;
    notifyListeners();
  }

  get getEmail => this.email;
  set setEmail(value) {
    this.email = value;
    notifyListeners();
  }

  // get getProfilePicture => this.profilePicture;
  // set setProfilePicture(value) {
  //   this.profilePicture = value;
  //   notifyListeners();
  // }

  get getPassword => this.password;
  set setPassword(value) {
    this.password = value;
    notifyListeners();
  }

  get getIDCard => this.idCard;
  set setDCard(value) {
    this.idCard = value;
    notifyListeners();
  }

  get getTelNo => this.telNo;
  set setTelNo(value) {
    this.telNo = value;
    notifyListeners();
  }

  get getrole => this.role;
  set setrole(value) {
    this.role = value;
    notifyListeners();
  }

  get getGender => this.Gender;
  set setGender(value) {
    this.Gender = value;
    notifyListeners();
  }
}

class emailProvider extends ChangeNotifier {
  String email = "";
  get getemail => this.email;
  set setemail(value) {
    this.email = value;
    notifyListeners();
  }
}

class ListProfileProvider with ChangeNotifier {
  CustomerController controller = CustomerController(CustomerServices());

  List<Customer> _CustomerList = [];
  List<Customer> get CustomerList => this._CustomerList;

  set CustomerList(List<Customer> value) {
    this._CustomerList = value;

    notifyListeners();
  }
}
