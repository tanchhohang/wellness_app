import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:show_hide_password/show_hide_password.dart';

import 'package:wellness_app/services/auth_service.dart';
import 'package:wellness_app/services/firestore_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  String role = 'customer';
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 70),
              SizedBox(
                width: 375.0,
                child: Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(
                width: 380.0,
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
                  width: 380.0,
                  child: ShowHidePassword(
                      passwordField: (bool hidePassword) {
                        return TextField(
                          controller: passwordController,
                          obscureText: hidePassword,
                          decoration: const InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              size: 24.0,
                              color: Colors.white70,
                            ),
                          ),
                        );
                      })),

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

                  const Text('Remember Me', style: TextStyle(color: Colors.white)),

                  const Spacer(),

                  TextButton(
                    onPressed: () async {
                      bool linksent =
                      await AuthService().forgotPassword(emailController.text);
                      if (linksent) {
                        log('Forgot Password linksent success');
                      } else {
                        log('Forgot Password linksent failed');
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 60.0,
                width: 380.0,
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
                    await AuthService().signInWithEmailPassword(
                      emailController.text,
                      passwordController.text,
                    );

                    if (user != null) {
                      log("Login success");
                      String userId = user.user!.uid;
                      String? userRole =
                      await FireStoreService().getUserRole(userId);

                      if (userRole != null) {
                        log("User role: $userRole");

                        if (userRole == 'admin') {
                          Navigator.pushNamed(context, '/admindashboard');
                        } else if (userRole == 'customer') {
                          Navigator.pushNamed(context, '/userdashboard');
                        } else {
                          showMessage("Unknown user role");
                        }
                      } else {
                        log("Failed to retrieve user role");
                        showMessage("Failed to retrieve user information");
                      }
                    } else {
                      log("Login failed");
                      showMessage("Login failed. Please check your credentials.");
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const Text('Or',
                  style: TextStyle(fontSize: 18, color: Colors.white)),

              SizedBox(
                height: 60.0,
                width: 380.0,
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
                    UserCredential? user =
                    await AuthService().signInWithGoogle();
                    if (user != null) {
                      log("login success");
                      Navigator.of(
                        context,
                      ).pushNamed('/admindashboard');
                    } else {
                      log("login failed");
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.mail_outline,
                        size: 25.0,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Google',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  "Don't have an account? Create Account",
                  style: TextStyle(
                    fontSize: 16,
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
