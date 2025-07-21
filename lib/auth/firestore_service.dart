import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {

  Future<void> insertNewUserData({
    required String email,
    required String name,
    required String uuid,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uuid)
          .set({
        'email': email,
        'name': name,
        'userRole': 'customer',
        'preferences': [], // Initialize empty preferences
      });
    } catch (e) {
      log("Failed to add new user data [insertNewUserData] : $e");
    }
  }

  // Update user preferences
  Future<void> updateUserPreferences({
    required String uuid,
    required List<String> preferences,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uuid)
          .update({
        'preferences': preferences,
      });
    } catch (e) {
      log("Failed to update user preferences [updateUserPreferences] : $e");
    }
  }

  // Get user preferences
  Future<List<String>> getUserPreferences(String uuid) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uuid)
          .get();

      if (doc.exists && doc.data()!.containsKey('preferences')) {
        return List<String>.from(doc.data()!['preferences'] ?? []);
      }
      return [];
    } catch (e) {
      log("Failed to get user preferences [getUserPreferences] : $e");
      return [];
    }
  }

  // Get user data including preferences
  Future<Map<String, dynamic>?> getUserData(String uuid) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uuid)
          .get();

      if (doc.exists) {
        return doc.data();
      }
      return null;
    } catch (e) {
      log("Failed to get user data [getUserData] : $e");
      return null;
    }
  }
}