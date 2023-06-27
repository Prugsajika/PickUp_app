import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/admininfo_model.dart';

class AdminServices {
  get user => FirebaseAuth.instance.currentUser!;

  CollectionReference _collectionAdmin =
      FirebaseFirestore.instance.collection('admin');

  Future<List<Admin>> getEmailAdmin(String email) async {
    String emaillowC = email.toLowerCase().toString();
    print(" getAdminByEmail $emaillowC");
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('admin')
        .where('adminEmail', isEqualTo: email.toLowerCase().toString())
        .get();

    AllAdmins admins = AllAdmins.fromSnapshot(snapshot);
    print("admins  $admins");
    return admins.admins;
  }
}
