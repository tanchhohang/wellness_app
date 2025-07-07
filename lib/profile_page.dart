import 'package:flutter/material.dart';
import 'package:wellness_app/login_screen.dart';
import 'package:wellness_app/signup_screen.dart';

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: [
            Text('Profile', textAlign: TextAlign.start, style: TextStyle( fontSize: 20,color: Colors.white),),
            Row(
              spacing: 10.0,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/app_icon.jpg'),
                ),

                Column(
                  spacing: 10,
                  children: [
                    SizedBox(
                      child: Text(
                        'TANCHHO LIMBU',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),

                    SizedBox(child: Text('abc@gmail.com',
                      style: TextStyle(fontStyle: FontStyle.italic,)
                      ),
                    ),
                  ],
                ),
              ], //MAIN body (ROW)
            ),
          ],
        ),
      );
  }
}