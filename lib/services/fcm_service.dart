import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// A service class for managing Firebase Cloud Messaging (FCM) operations.
///
/// This class provides utility functions to initialize FCM and retrieve the
/// FCM token for the current device.
///
/// Example usage:
/// ```dart
/// final fcmService = FCMServices();
/// await fcmService.initializeCloudMessaging();
/// String? token = await fcmService.getFCMToken();
/// ```
class FCMServices {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initializeCloudMessaging() async {
    // Your existing implementation
    await _firebaseMessaging.requestPermission();

    // Store token when user logs in
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _storeFCMToken(user.uid);
    }
  }

  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  void listenFCMMessage() {
    // Your existing implementation
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("FCM onMessage: ${message.notification?.title}");
      // Handle foreground messages
    });
  }

  // Store FCM token for the current user
  Future<void> _storeFCMToken(String userId) async {
    try {
      String? token = await getFCMToken();
      if (token != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .update({
          'fcmToken': token,
          'lastTokenUpdate': FieldValue.serverTimestamp(),
        });
        log("FCM token stored for user: $userId");
      }
    } catch (e) {
      log("Failed to store FCM token: $e");
    }
  }

  // Call this when user logs in
  Future<void> updateFCMTokenForUser(String userId) async {
    await _storeFCMToken(userId);
  }
}