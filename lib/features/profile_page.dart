import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wellness_app/features//login_screen.dart';
import 'package:wellness_app/features/signup_screen.dart';

import 'package:wellness_app/auth/auth_service.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 30,
          children: [
            Container(
              height: 100,
              width: 650,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white12,
              ),
              child: Row(

                spacing: 20.0,
                children: [
                  SizedBox(width: 5),
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/app_icon.jpg'),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(
                          'Tanchho Limbu',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(child: Text('abc@gmail.com',),
                      ),
                    ],
                  ),
                ], //MAIN body (ROW)
              ),
            ),

            Text('MAKE IT YOURS',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white54),),

            Container(
              height: 70,
              width: 600,
              child: FilledButton.icon(
                style: ButtonStyle(
                  alignment: Alignment.centerLeft,
                  backgroundColor: WidgetStatePropertyAll(Colors.white12),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                onPressed: () {},
                icon: Icon(
                  Icons.menu_book_outlined,
                  size: 35,
                  color: Colors.white,
                ),
                label: Text(
                  'Content preferences',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ),

              Text('ACCOUNT',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white54),),

              Column(
                spacing: 20,
                children: [

                  Container(
                    height: 70,
                    width: 600,
                    child: FilledButton.icon(
                      style: ButtonStyle(
                        alignment: Alignment.centerLeft,
                        backgroundColor: WidgetStatePropertyAll(Colors.white12),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      onPressed: () {},
                      icon: Icon(
                        Icons.pentagon_outlined,
                        size: 35,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Theme',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                  Container(
                    height: 70,
                    width: 600,
                    child: FilledButton.icon(
                      style: ButtonStyle(
                        alignment: Alignment.centerLeft,
                        backgroundColor: WidgetStatePropertyAll(Colors.white12),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      onPressed: () {},
                      icon: Icon(
                        Icons.password_outlined,
                        size: 35,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                  Container(
                    height: 70,
                    width: 600,
                    child: FilledButton.icon(
                      style: ButtonStyle(
                        alignment: Alignment.centerLeft,
                        backgroundColor: WidgetStatePropertyAll(Colors.white12),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      onPressed: () async {
                        await AuthService().signOut();
                        Navigator.of(
                          context,
                        ).pushNamed('/login');
                      },
                      icon: Icon(
                        Icons.logout,
                        size: 35,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                ],
              )

          ],
        ),
        ),
      );
  }
}