import 'dart:developer';

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
  /// Initializes Firebase Cloud Messaging for the current device.
  ///
  /// This enables FCM auto-initialization so that the device can automatically
  /// manage FCM token generation and reception of messages.
  ///
  /// Should be called early in the app lifecycle, such as during app startup.
  ///
  /// Returns a [Future] that completes when initialization is finished.
  Future<void> initializeCloudMessaging() => Future.wait([
      FirebaseMessaging.instance.requestPermission(),
      FirebaseMessaging.instance.setAutoInitEnabled(true),
  ]);

  void listenFCMessage(){
    FirebaseMessaging.onMessage.listen(_handleFCMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      log("Notification opened: ${message.notification?.title}");
    });
  }


  /// Retrieves the default FCM token for the current device.
  ///
  /// This token is used to uniquely identify the device to Firebase Cloud Messaging
  /// and is necessary for sending targeted push notifications.
  ///
  /// Returns a [Future] that completes with the FCM token as a [String],
  /// or `null` if the token could not be retrieved.
  Future<String?> getFCMToken() => FirebaseMessaging.instance.getToken();

  Future<void> _handleFCMessage(RemoteMessage message) async{
    log('Received FCM Message: ${message.notification?.title}');
  }
}