import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rider {
  late String Riderid;
  //late String imagerider;
  late String FirstName;
  late String LastName;
  late String Gender;
  late String TelNo;
  late String email;
  late String password;
  late String idCard;
  late String UrlQr;
  late bool statusBL;
  late String UrlCf;
  late String role;
  late String statusApprove;

  Rider(
    // this.id,
    // this.imagerider,
    this.Riderid,
    this.FirstName,
    this.LastName,
    this.Gender,
    this.TelNo,
    this.email,
    this.password,
    this.idCard,
    this.UrlQr,
    this.statusBL,
    this.UrlCf,
    this.role,
    this.statusApprove,
  );
  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
      json['Riderid'] as String,
      json['FirstName'] as String,
      json['LastName'] as String,
      json['Gender'] as String,
      json['TelNo'] as String,
      json['email'] as String,
      json['password'] as String,
      json['idCard'] as String,
      json['UrlQr'] as String,
      json['statusBL'] as bool,
      json['UrlCf'] as String,
      json['role'] as String,
      json['statusApprove'] as String,
    );
  }
}

class AllRiders {
  final List<Rider> riders;

  AllRiders(this.riders);
  factory AllRiders.fromJson(List<dynamic> json) {
    List<Rider> riders;

    riders = json.map((index) => Rider.fromJson(index)).toList();

    return AllRiders(riders);
  }
//TODO รอถามอาจารย์
  factory AllRiders.fromSnapshot(QuerySnapshot s) {
    List<Rider> riders = s.docs.map((DocumentSnapshot ds) {
      print("documentsnapshot ${ds.data()}");
      Rider rider = Rider.fromJson(ds.data() as Map<String, dynamic>);
      rider.Riderid = ds.id;
      print("riderdocumentsnapshot ${rider.Riderid}");
      return rider;
    }).toList();

    return AllRiders(riders);
  }
}

// class CountRiders {
//   final List<Rider> riders;

//   CountRiders(this.riders);
//   factory CountRiders.fromJson(List<dynamic> json) {
//     List<Rider> riders;

//     riders = json.map((index) => Rider.fromJson(index)).toList();

//     return CountRiders(riders);
//   }
// //TODO รอถามอาจารย์
//   factory CountRiders.fromSnapshot(QuerySnapshot s) {
//     List<Rider> riders = s.docs.map((DocumentSnapshot ds) {
//       print("documentsnapshot ${ds.data()}");
//       Rider rider = Rider.fromJson(ds.data() as Map<String, dynamic>);
//       rider.Riderid = ds.id;
//       print("riderdocumentsnapshot ${rider.Riderid}");
//       return rider;
//     }).toList();

//     return CountRiders(riders);
//   }
// }

class RiderModel extends ChangeNotifier {
  String Riderid = '';
  // String imagerider = '';
  String FirstName = '';
  String LastName = '';
  String Gender = '';
  String TelNo = '';
  String email = '';
  String Password = '';
  late String idCard;
  String UrlQr = '';
  late bool statusBL;
  String UrlCf = '';
  String role = '';
  String statusApprove = '';

  get getRiderid => this.Riderid;
  set setRiderid(value) {
    this.Riderid = value;
    notifyListeners();
  }

  // get getimagerider => this.imagerider;
  // set setimagerider(value) {
  //   this.imagerider = value;
  //   notifyListeners();
  // }

  get getFirstName => this.FirstName;
  set setFirstName(value) {
    this.FirstName = value;
    notifyListeners();
  }

  get getLastName => this.LastName;
  set setLastName(value) {
    this.LastName = value;
    notifyListeners();
  }

  get getGender => this.Gender;
  set setGender(value) {
    this.Gender = value;
    notifyListeners();
  }

  get getTelNo => this.TelNo;
  set setTelNo(value) {
    this.TelNo = value;
    notifyListeners();
  }

  get getemail => this.email;
  set setemail(value) {
    this.email = value;
    notifyListeners();
  }

  get getPassword => this.Password;
  set setPassword(value) {
    this.Password = value;
    notifyListeners();
  }

  get getidCard => this.idCard;
  set setidCard(value) {
    this.idCard = value;
    notifyListeners();
  }

  get getUrlQr => this.UrlQr;
  set setUrlQr(value) {
    this.UrlQr = value;
    notifyListeners();
  }

  get getstatusBL => this.statusBL;
  set setstatus(value) {
    this.statusBL = value;
    notifyListeners();
  }

  get getUrlCf => this.UrlCf;
  set setUrlCf(value) {
    this.UrlCf = value;
    notifyListeners();
  }

  get getrole => this.role;
  set setrole(value) {
    this.role = value;
    notifyListeners();
  }

  get getstatusApprove => this.statusApprove;
  set setstatusApprove(value) {
    this.statusApprove = value;
    notifyListeners();
  }

  List<Rider> _listRider = List.empty();
  List<Rider> get getListRider => this._listRider;

  set getListRider(List<Rider> value) {
    this._listRider = value;
    notifyListeners();
  }
}

class AdminRiderModel extends ChangeNotifier {
  String Riderid = '';
  // String imagerider = '';
  String FirstName = '';
  String LastName = '';
  String Gender = '';
  String TelNo = '';
  String email = '';
  String Password = '';
  late String idCard;
  String UrlQr = '';
  late bool statusBL;
  String UrlCf = '';
  String role = '';
  String statusApprove = '';

  get getRiderid => this.Riderid;
  set setRiderid(value) {
    this.Riderid = value;
    notifyListeners();
  }

  // get getimagerider => this.imagerider;
  // set setimagerider(value) {
  //   this.imagerider = value;
  //   notifyListeners();
  // }

  get getFirstName => this.FirstName;
  set setFirstName(value) {
    this.FirstName = value;
    notifyListeners();
  }

  get getLastName => this.LastName;
  set setLastName(value) {
    this.LastName = value;
    notifyListeners();
  }

  get getGender => this.Gender;
  set setGender(value) {
    this.Gender = value;
    notifyListeners();
  }

  get getTelNo => this.TelNo;
  set setTelNo(value) {
    this.TelNo = value;
    notifyListeners();
  }

  get getemail => this.email;
  set setemail(value) {
    this.email = value;
    notifyListeners();
  }

  get getPassword => this.Password;
  set setPassword(value) {
    this.Password = value;
    notifyListeners();
  }

  get getidCard => this.idCard;
  set setidCard(value) {
    this.idCard = value;
    notifyListeners();
  }

  get getUrlQr => this.UrlQr;
  set setUrlQr(value) {
    this.UrlQr = value;
    notifyListeners();
  }

  get getstatusBL => this.statusBL;
  set setstatus(value) {
    this.statusBL = value;
    notifyListeners();
  }

  get getUrlCf => this.UrlCf;
  set setUrlCf(value) {
    this.UrlCf = value;
    notifyListeners();
  }

  get getrole => this.role;
  set setrole(value) {
    this.role = value;
    notifyListeners();
  }

  get getstatusApprove => this.statusApprove;
  set setstatusApprove(value) {
    this.statusApprove = value;
    notifyListeners();
  }

  List<Rider> _listAdminRiderModel = List.empty();
  List<Rider> get getListAdminRiderModel => this._listAdminRiderModel;

  set getListAdminRiderModel(List<Rider> value) {
    this._listAdminRiderModel = value;
    notifyListeners();
  }
}

class CountRiderAdminModel with ChangeNotifier {
  int statusApprove = 0;
  int statuswaiting = 0;
  int statusBL = 0;

  get StatusApprove => this.statusApprove;

  set StatusApprove(statusApprove) => this.statusApprove = statusApprove;

  get Statuswaiting => this.statuswaiting;

  set Statuswaiting(statuswaiting) => this.statuswaiting = statuswaiting;

  get StatusBL => this.statusBL;

  set StatusBL(statusBL) => this.statusBL = statusBL;
}

class EditProfileModel extends ChangeNotifier {
  String _FirstName = '';
  String _LastName = '';

  String _TelNo = '';

  String _UrlQr = '';
  String _riderid = '';
  get FirstName => this._FirstName;

  set FirstName(value) => this._FirstName = value;

  get LastName => this._LastName;

  set LastName(value) => this._LastName = value;

  get TelNo => this._TelNo;

  set TelNo(value) => this._TelNo = value;

  get UrlQr => this._UrlQr;

  set UrlQr(value) => this._UrlQr = value;

  get riderid => this._riderid;

  set riderid(value) => this._riderid = value;

  List<Rider> _listEditProfile = List.empty();
  List<Rider> get getEditListProfile => this._listEditProfile;
  set getEditListProduct(List<Rider> value) {
    this._listEditProfile = value;
    notifyListeners();
  }
}

class WaitingRider {
  late String Riderid;
  //late String imagerider;
  late String FirstName;
  late String LastName;
  late String Gender;
  late String TelNo;
  late String email;
  late String password;
  late String idCard;
  late String UrlQr;
  late bool statusBL;
  late String UrlCf;
  late String role;
  late String statusApprove;

  WaitingRider(
    // this.id,
    // this.imagerider,
    this.Riderid,
    this.FirstName,
    this.LastName,
    this.Gender,
    this.TelNo,
    this.email,
    this.password,
    this.idCard,
    this.UrlQr,
    this.statusBL,
    this.UrlCf,
    this.role,
    this.statusApprove,
  );
  factory WaitingRider.fromJson(Map<String, dynamic> json) {
    return WaitingRider(
      json['Riderid'] as String,
      json['FirstName'] as String,
      json['LastName'] as String,
      json['Gender'] as String,
      json['TelNo'] as String,
      json['email'] as String,
      json['password'] as String,
      json['idCard'] as String,
      json['UrlQr'] as String,
      json['statusBL'] as bool,
      json['UrlCf'] as String,
      json['role'] as String,
      json['statusApprove'] as String,
    );
  }
}

class AllWaitingRider {
  final List<WaitingRider> waitingriders;

  AllWaitingRider(this.waitingriders);
  factory AllWaitingRider.fromJson(List<dynamic> json) {
    List<WaitingRider> waitingriders;

    waitingriders = json.map((index) => WaitingRider.fromJson(index)).toList();

    return AllWaitingRider(waitingriders);
  }
//TODO รอถามอาจารย์
  factory AllWaitingRider.fromSnapshot(QuerySnapshot s) {
    List<WaitingRider> waitingriders = s.docs.map((DocumentSnapshot ds) {
      print("documentsnapshot ${ds.data()}");
      WaitingRider rider =
          WaitingRider.fromJson(ds.data() as Map<String, dynamic>);
      rider.Riderid = ds.id;
      print("riderdocumentsnapshot ${rider.Riderid}");
      return rider;
    }).toList();

    return AllWaitingRider(waitingriders);
  }
}

class AllWaitingRiderModel extends ChangeNotifier {
  String Riderid = '';
  // String imagerider = '';
  String FirstName = '';
  String LastName = '';
  String Gender = '';
  String TelNo = '';
  String email = '';
  String Password = '';
  late String idCard;
  String UrlQr = '';
  late bool statusBL;
  String UrlCf = '';
  String role = '';
  String statusApprove = '';

  get getRiderid => this.Riderid;
  set setRiderid(value) {
    this.Riderid = value;
    notifyListeners();
  }

  // get getimagerider => this.imagerider;
  // set setimagerider(value) {
  //   this.imagerider = value;
  //   notifyListeners();
  // }

  get getFirstName => this.FirstName;
  set setFirstName(value) {
    this.FirstName = value;
    notifyListeners();
  }

  get getLastName => this.LastName;
  set setLastName(value) {
    this.LastName = value;
    notifyListeners();
  }

  get getGender => this.Gender;
  set setGender(value) {
    this.Gender = value;
    notifyListeners();
  }

  get getTelNo => this.TelNo;
  set setTelNo(value) {
    this.TelNo = value;
    notifyListeners();
  }

  get getemail => this.email;
  set setemail(value) {
    this.email = value;
    notifyListeners();
  }

  get getPassword => this.Password;
  set setPassword(value) {
    this.Password = value;
    notifyListeners();
  }

  get getidCard => this.idCard;
  set setidCard(value) {
    this.idCard = value;
    notifyListeners();
  }

  get getUrlQr => this.UrlQr;
  set setUrlQr(value) {
    this.UrlQr = value;
    notifyListeners();
  }

  get getstatusBL => this.statusBL;
  set setstatus(value) {
    this.statusBL = value;
    notifyListeners();
  }

  get getUrlCf => this.UrlCf;
  set setUrlCf(value) {
    this.UrlCf = value;
    notifyListeners();
  }

  get getrole => this.role;
  set setrole(value) {
    this.role = value;
    notifyListeners();
  }

  get getstatusApprove => this.statusApprove;
  set setstatusApprove(value) {
    this.statusApprove = value;
    notifyListeners();
  }

  List<WaitingRider> _listWaitingRider = List.empty();
  List<WaitingRider> get getListWaitingRider => this._listWaitingRider;

  set getListRider(List<WaitingRider> value) {
    this._listWaitingRider = value;
    notifyListeners();
  }
}

class AdminRiderBL extends ChangeNotifier {
  String Riderid = '';
  // String imagerider = '';
  String FirstName = '';
  String LastName = '';
  String Gender = '';
  String TelNo = '';
  String email = '';
  String Password = '';
  late String idCard;
  String UrlQr = '';
  late bool statusBL;
  String UrlCf = '';
  String role = '';
  String statusApprove = '';

  get getRiderid => this.Riderid;
  set setRiderid(value) {
    this.Riderid = value;
    notifyListeners();
  }

  // get getimagerider => this.imagerider;
  // set setimagerider(value) {
  //   this.imagerider = value;
  //   notifyListeners();
  // }

  get getFirstName => this.FirstName;
  set setFirstName(value) {
    this.FirstName = value;
    notifyListeners();
  }

  get getLastName => this.LastName;
  set setLastName(value) {
    this.LastName = value;
    notifyListeners();
  }

  get getGender => this.Gender;
  set setGender(value) {
    this.Gender = value;
    notifyListeners();
  }

  get getTelNo => this.TelNo;
  set setTelNo(value) {
    this.TelNo = value;
    notifyListeners();
  }

  get getemail => this.email;
  set setemail(value) {
    this.email = value;
    notifyListeners();
  }

  get getPassword => this.Password;
  set setPassword(value) {
    this.Password = value;
    notifyListeners();
  }

  get getidCard => this.idCard;
  set setidCard(value) {
    this.idCard = value;
    notifyListeners();
  }

  get getUrlQr => this.UrlQr;
  set setUrlQr(value) {
    this.UrlQr = value;
    notifyListeners();
  }

  get getstatusBL => this.statusBL;
  set setstatus(value) {
    this.statusBL = value;
    notifyListeners();
  }

  get getUrlCf => this.UrlCf;
  set setUrlCf(value) {
    this.UrlCf = value;
    notifyListeners();
  }

  get getrole => this.role;
  set setrole(value) {
    this.role = value;
    notifyListeners();
  }

  get getstatusApprove => this.statusApprove;
  set setstatusApprove(value) {
    this.statusApprove = value;
    notifyListeners();
  }

  List<Rider> _listAdminRiderBL = List.empty();
  List<Rider> get getListAdminRiderBL => this._listAdminRiderBL;

  set getListAdminRiderBL(List<Rider> value) {
    this._listAdminRiderBL = value;
    notifyListeners();
  }
}


// class ListRiderModel extends ChangeNotifier {
//   List<Rider> _listRider = List.empty();
//   List<Rider> get getListRider => this._listRider;

//   set getListRider(List<Rider> value) {
//     this._listRider = value;
//     notifyListeners();
//   }

//   // void setListRider(List<Rider> value) {
//   //   _listRider = value;
//   //   notifyListeners();
//   // }
// }

// class Blacklist {
//   late String id;
//   // //late String imagerider;
//   // late String FirstName;
//   // late String LastName;
//   // late String Gender;
//   // late String TelNo;
//   late String email;
//   // late String password;
//   // late String idCard;
//   // late String UrlQr;
//   // late bool status;
//   // late String UrlCf;
//   // late String role;

//   Blacklist(
//     this.id,
//     // this.imagerider,
//     // this.Riderid,
//     // this.FirstName,
//     // this.LastName,
//     // this.Gender,
//     // this.TelNo,
//     this.email,
//     // this.password,
//     // this.idCard,
//     // this.UrlQr,
//     // this.status,
//     // this.UrlCf,
//     // this.role,
//   );
//   factory Blacklist.fromJson(Map<String, dynamic> json) {
//     return Blacklist(
//       json['id'] as String,
//       // json['FirstName'] as String,
//       // json['LastName'] as String,
//       // json['Gender'] as String,
//       // json['TelNo'] as String,
//       json['email'] as String,
//       // json['password'] as String,
//       // json['idCard'] as String,
//       // json['UrlQr'] as String,
//       // json['status'] as bool,
//       // json['UrlCf'] as String,
//       // json['role'] as String,
//     );
//   }
// }

// class AllBlacklists {
//   final List<Blacklist> blacklists;

//   AllBlacklists(this.blacklists);
//   factory AllBlacklists.fromJson(List<dynamic> json) {
//     List<Blacklist> blacklists;

//     blacklists = json.map((index) => Blacklist.fromJson(index)).toList();

//     return AllBlacklists(blacklists);
//   }

//   factory AllBlacklists.fromSnapshot(QuerySnapshot s) {
//     List<Blacklist> blacklists = s.docs.map((DocumentSnapshot ds) {
//       print("BLdocumentsnapshot ${ds.data()}");
//       Blacklist blacklist =
//           Blacklist.fromJson(ds.data() as Map<String, dynamic>);
//       blacklist.id = ds.id;
//       print("riderBLdocumentsnapshot ${blacklist.email}");
//       return blacklist;
//     }).toList();

//     return AllBlacklists(blacklists);
//   }
// }
