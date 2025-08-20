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

  // Simple password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }

  // Show error message
  void showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: 3),
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
      body: Column(
        spacing: 20, //equal spacing of 10
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 375.0,
            child: Text(
              'Welcome Back!',
              textAlign: TextAlign.center,
              style: TextStyle(
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
              decoration: InputDecoration(
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
                passwordField: (bool hidePassword){
                  return  TextField(
                    controller: passwordController,
                    obscureText: hidePassword, //use the hidePassword status on obscureText to toggle the visibility
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      prefixIcon: Icon(
                        Icons.password_outlined,
                        size: 24.0,
                        color: Colors.white70,
                      ),
                      /*suffixIcon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,)*/
                    ),
                  );
                }
            )
          ),

          Row(
            children: [
              SizedBox(
                //width: 40,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  //Adding padding to checkbox
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
              ),

              Text('Remember Me'),

              const SizedBox(width: 100),

              TextButton(
                onPressed: () async {
                  bool linksent = await AuthService().forgotPassword(emailController.text);
                  if (linksent){
                    log('Forgot Password linksent success');
                  } else {
                    log('Forgot Password linksent failed');
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.underline),
                ),
              ),

            ], //Row children
          ),
          SizedBox(
            height: 60.0,
            width: 380.0,
            child: FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white12),
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

                // Validate password
                String? passwordError = validatePassword(passwordController.text);
                if (passwordError != null) {
                  showMessage(passwordError);
                  return;
                }

                // If both validations pass, proceed with login
                UserCredential? user = await AuthService().signInWithEmailPassword(
                  emailController.text,
                  passwordController.text,
                );

                if (user != null) {
                  log("Login success");
                  //showMessage('Login Successful', isError: false);
                  String userId = user.user!.uid; // Get the user's UID
                  String? userRole = await FireStoreService().getUserRole(userId);

                  if (userRole != null) {
                    log("User role: $userRole");

                    // Navigate based on role
                    if (userRole == 'admin') {
                      Navigator.pushNamed(context, '/admindashboard');
                    } else if (userRole == 'customer') {
                      Navigator.pushNamed(context, '/userdashboard');
                    } else {
                      // Handle unknown role
                      showMessage("Unknown user role");
                    }
                  } else {
                    log("Failed to retrieve user role");
                    showMessage("Failed to retrieve user information");
                  }

                } else {
                  log("Login failed");
                  //showMessage('Invalid Credentials');
                  showMessage("Login failed. Please check your credentials.");
                }
              },
              child: const Text('Login', style: TextStyle(fontSize: 18, color: Colors.white),),
            ),
          ),
          //const SizedBox(height: 30),

          Text('Or', style: TextStyle(fontSize: 18),),

          SizedBox(
            height: 60.0,
            width: 380.0,
            child: FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white12),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () async {
                UserCredential? user = await AuthService()
                    .signInWithGoogle();
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
                children: [
                  Icon(
                    Icons.mail_outline,
                    size: 25.0,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Google',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 5),

          GestureDetector(
            onTap: () {
              // Navigate to Signup page
              Navigator.pushNamed(context, '/signup');
            },
            child: Text(
              "Don't have an account? Create Account",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ], //Children
      ),
    );
  }
}