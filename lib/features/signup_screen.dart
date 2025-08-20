import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isChecked = false;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  void showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<WidgetState> states) {
      const Set<WidgetState> interactiveStates = <WidgetState>{
        WidgetState.pressed,
        WidgetState.hovered,
        WidgetState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.white;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              SizedBox(
                width: 360,
                child: Text(
                  'Start your wellness journey today!',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(
                width: 370.0,
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Username',
                    prefixIcon: Icon(
                      Icons.account_box_outlined,
                      size: 24.0,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 370.0,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 24.0,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 370.0,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    prefixIcon: Icon(
                      Icons.password_outlined,
                      size: 24.0,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Checkbox(
                      checkColor: Colors.black,
                      fillColor: WidgetStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                  ),
                  const Text('Remember Me',
                      style: TextStyle(color: Colors.white)),
                  const Spacer(),
                ],
              ),

              SizedBox(
                height: 60.0,
                width: 360.0,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                    const WidgetStatePropertyAll(Colors.white12),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    String? emailError = validateEmail(emailController.text);
                    if (emailError != null) {
                      showMessage(emailError);
                      return;
                    }

                    String? passwordError =
                    validatePassword(passwordController.text);
                    if (passwordError != null) {
                      showMessage(passwordError);
                      return;
                    }

                    UserCredential? user =
                    await AuthService().signUpWithEmailPassword(
                      emailController.text,
                      passwordController.text,
                      usernameController.text,
                    );

                    if (user != null) {
                      log("Signup success");

                      await FireStoreService().insertNewUserData(
                        email: user.user?.email ?? '',
                        name: usernameController.text,
                        uuid: user.user?.uid ?? '',
                      );

                      Navigator.pushNamed(context, '/userpreference');
                    } else {
                      log("Signup failed");
                      showMessage('Signup Failed');
                    }
                  },
                  child: const Text('Signup',
                      style: TextStyle(color: Colors.white)),
                ),
              ),

              const Text('or', style: TextStyle(color: Colors.white)),

              SizedBox(
                height: 60.0,
                width: 360.0,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor:
                    const WidgetStatePropertyAll(Colors.white12),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Signup with Google',
                      style: TextStyle(color: Colors.white)),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
