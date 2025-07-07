import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 380,
            child: Text(
              'Start your wellness journey today.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: 380.0,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter Username',
                prefixIcon: Icon(
                  Icons.account_box_outlined,
                  size: 26.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),

          SizedBox(
            width: 380.0,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter Email',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  size: 26.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),

          SizedBox(
            width: 380.0,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter password',
                prefixIcon: Icon(
                  Icons.star_rate_sharp,
                  size: 26.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),

          Row(
            children: [
              SizedBox(
                child: Padding(padding: EdgeInsets.only(left:10.0),
                  child: Checkbox(
                    checkColor: Colors.black,
                    fillColor: WidgetStateProperty.resolveWith(getColor),
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ),
              ),

              Text('Remember Me', style: TextStyle(fontSize: 18),),

            ], //Row children
          ),
          SizedBox(
            height: 60.0,
            width: 380.0,
            child: FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              child: const Text('Signup', style: TextStyle(fontSize: 18),),
            ),
          ),

          //const SizedBox(height: 30),
          Text('Or', style: TextStyle(fontSize: 18),),

          SizedBox(
            height: 60.0,
            width: 380.0,
            child: FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
              child: const Text('Signup with Google', style: TextStyle(fontSize: 18),),
            ),
          ),

          GestureDetector(
            onTap: () {
              // Navigate to Signup page
              Navigator.pushNamed(context, '/');
            },
            child: Text(
              "Already have an account? Sign In",
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