import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';


class FireStoreService {

  Future<void> insertNewUserData({
    required String email,
    required String name,
    required String uuid,
  }) async {
    try{
      await FirebaseFirestore.instance
          .collection(
          "users"
      )
          .doc(uuid)
          .set({
        'email': email,
        'name': name,
        'userRole': 'customer',
      });

    }catch(e){
      log("Failed to add new user data [insertNewUserData] : $e");
    }
  }
}