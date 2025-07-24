import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../constant/firestore_constant.dart';

class FireStoreService {
  final String _generateUniqueId = Uuid().v4();

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
      });
    } catch (e) {
      log("Failed to add new user data [insertNewUserData] : $e");
    }
  }

  Future<Map<String, dynamic>> getUserByEmail({required String email}) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isEmpty) {
        return {};
      } else {
        return snapshot.docs.first.data();
      }
    } catch (e) {
      log("Failed to get user data [getUserByEmail]: $e");
      return {};
    }
  }

  Future<bool> addCategory({
    required String userId,
    required String categoryName,
  }) async {
    try {
      String id = _generateUniqueId;
      await FirebaseFirestore.instance
          .collection(CloudFireStoreConstant.categoryTable)
          .doc(categoryName)
          .set({'name': categoryName, 'id': id});
      return true;
    } catch (e) {
      log("Failed to add new category : $e");
      return false;
    }
  }

  Future<bool> addQuote({
    required String userId,
    required String categoryName,
    required String authorName,
    required String quoteText,
  }) async {
    try {
      String id = _generateUniqueId;
      await FirebaseFirestore.instance
          .collection(CloudFireStoreConstant.quotesTable)
          .doc(id)
          .set({'userId': userId, 'name': categoryName, 'authorName': authorName, 'quoteText': quoteText,'id': id});
      return true;
    } catch (e) {
      log("Failed to add new quote : $e");
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getUserCategories({
    required String userId,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(CloudFireStoreConstant.categoryTable)
          .get();
      return snapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    } catch (e) {
      log("Failed to get user categories [getUserCategories]: $e");
      return [];
    }
  }

  Future<int> getTotalUser({
    required String userId,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(CloudFireStoreConstant.userTable)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      log("Failed to get total user count [getTotalUser]: $e");
      return 0;
    }
  }

  Future<int> getTotalCategory({
    required String userId,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(CloudFireStoreConstant.categoryTable)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      log("Failed to get total category count [getTotalCategory]: $e");
      return 0;
    }
  }

  Future<int> getTotalQuote({
    required String userId,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(CloudFireStoreConstant.quotesTable)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      log("Failed to get total quote count [getTotalQuote]: $e");
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getQuotesByCategory({
    required String categoryName,
  }) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(CloudFireStoreConstant.quotesTable)
          .where('categoryName', isEqualTo: categoryName)
          .get();
      return snapshot.docs.map((doc) => {
        'id': doc.id,
        ...doc.data(),
      }).toList();
    } catch (e) {
      log("Failed to get quotes by category [getQuotesByCategory]: $e");
      return [];
    }
  }

  Future<void> insertDataIntoPreferences({
    required String categoryName,
    required String preferenceName,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(CloudFireStoreConstant.preferenceTable)
          .doc(preferenceName)
          .set({'categoryName': categoryName, 'name': preferenceName});
    } catch (e) {
      log("Failed to add new user data [insertNewUserData] : $e");
    }
  }

  Future<Map<String, dynamic>> fetchUserDataWithCategoriesAndPreferences(
      String userId,
      ) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // 1. Fetch user data
      final userDoc = await firestore
          .collection(CloudFireStoreConstant.userTable)
          .doc(userId)
          .get();
      if (!userDoc.exists) throw Exception('User not found');

      final userData = userDoc.data()!;

      // 2. Fetch categories for the user
      final categorySnapshot = await firestore
          .collection(CloudFireStoreConstant.categoryTable)
          .where('userId', isEqualTo: userId)
          .get();

      List<Map<String, dynamic>> categoriesWithPreferences = [];

      for (var categoryDoc in categorySnapshot.docs) {
        final categoryData = categoryDoc.data();

        // 3. Fetch preferences for each category
        final preferenceSnapshot = await firestore
            .collection(CloudFireStoreConstant.preferenceTable)
            .where('categoryName', isEqualTo: categoryData['name'])
            .get();

        final preferences = preferenceSnapshot.docs
            .map((doc) => doc.data())
            .toList();

        categoriesWithPreferences.add({
          'category': categoryData,
          'preferences': preferences,
        });
      }

      // 4. Combine user and category/preference data
      return {'user': userData, 'categories': categoriesWithPreferences};
    } catch (e) {
      log("Error fetching user data with categories and preferences: $e");
      rethrow;
    }
  }
}