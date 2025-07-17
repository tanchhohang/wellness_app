import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:wellness_app/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;

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
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your password',

                prefixIcon: Icon(
                  Icons.star_border_purple500_sharp,
                  size: 24.0,
                  color: Colors.white70,
                ),

              ),
            ),
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

              Text('Forgot Password', style: TextStyle(fontSize: 16),)
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
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
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
                  ).pushNamed('/dashboard');
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