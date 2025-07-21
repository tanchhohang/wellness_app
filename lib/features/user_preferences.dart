import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class UserPreferencePage extends StatefulWidget {
  const UserPreferencePage({super.key});

  @override
  State<UserPreferencePage> createState() => _UserPreferencePageState();
}

class _UserPreferencePageState extends State<UserPreferencePage> {
  bool isChecked = false;
  bool isLoading = false;

  // Store preferences as a map for easier management
  Map<String, bool> preferences = {
    'Hard Times': false,
    'Working Out': false,
    'Productivity': false,
    'Self-esteem': false,
    'Achieving goals': false,
    'Inspiration': false,
    'Letting Go': false,
    'Love': false,
    'Relationship': false,
    'Faith Spirituality': false,
  };

  @override
  void initState() {
    super.initState();
  }

  Future<void> _savePreferencesToFirebase() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get selected preferences
        List<String> selectedPreferences = preferences.entries
            .where((entry) => entry.value)
            .map((entry) => entry.key)
            .toList();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'preferences': selectedPreferences,
        });

        // Navigate to dashboard
        Navigator.pushReplacementNamed(context, '/userdashboard');
      }
    } catch (e) {
      log("Failed to save preferences: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save preferences. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildPreferenceButton(String preferenceKey) {
    return SizedBox(
      height: 65,
      width: 180,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: preferences[preferenceKey]!
              ? Colors.white
              : Colors.white12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          setState(() {
            preferences[preferenceKey] = !preferences[preferenceKey]!;
          });
        },
        child: Text(
          preferenceKey,
          style: TextStyle(
            fontSize: 16,
            color: preferences[preferenceKey]! ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select all topics that motivates you!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
            Column(
              spacing: 20,
              children: [
                // Row 1
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.0,
                  children: [
                    _buildPreferenceButton('Hard Times'),
                    _buildPreferenceButton('Working Out'),
                  ],
                ),
                // Row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.0,
                  children: [
                    _buildPreferenceButton('Productivity'),
                    _buildPreferenceButton('Self-esteem'),
                  ],
                ),
                // Row 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.0,
                  children: [
                    _buildPreferenceButton('Achieving goals'),
                    _buildPreferenceButton('Inspiration'),
                  ],
                ),
                // Row 4
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.0,
                  children: [
                    _buildPreferenceButton('Letting Go'),
                    _buildPreferenceButton('Love'),
                  ],
                ),
                // Row 5
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 15.0,
                  children: [
                    _buildPreferenceButton('Relationship'),
                    _buildPreferenceButton('Faith Spirituality'),
                  ],
                ),
                // Continue Button
                isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : TextButton(
                  onPressed: _savePreferencesToFirebase,
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}