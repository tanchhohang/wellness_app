import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
          'Explore',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),

        ],
      ),

      body: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 190.0,
                height:60,
                child: FilledButton.icon(
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.star_border_sharp, size: 30, color: Colors.white,),
                  label: Text(
                    'My Favorites',
                    style: TextStyle( fontSize: 16,color: Colors.white),

                  ),

                ),
              ),

              SizedBox(
                width: 190.0,
                height:60,
                child: FilledButton.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.alarm, size: 30, color: Colors.white,),

                  label: Text(
                    'Remind Me',
                    style: TextStyle( fontSize: 16,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(width: 10,),
              Text(
                "Today's Quote",
                style: TextStyle(
                  fontSize:20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400.0,
                height: 100.0,
                child: FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: (){},
                  child: Text(
                    '"Your wellness is an investment, not an expense" - Author Name',
                    style: TextStyle( fontSize: 20,color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(width: 10,),
              Text(
                "Quotes",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400.0,
                height: 60.0,
                child: FilledButton.icon(
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.wb_sunny_outlined, size: 30, color: Colors.white,),
                  label: Text('Feeling Blessed',
                    style: TextStyle( fontSize: 20,color: Colors.white),),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400.0,
                height: 60.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.emoji_flags, size: 30, color: Colors.white,),
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  label: Text('Pride Month',
                    style: TextStyle( fontSize: 20,color: Colors.white),),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400.0,
                height: 60.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.star_border, size: 30, color: Colors.white,),
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  label: Text('Self Worth',
                    style: TextStyle( fontSize: 20,color: Colors.white),),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400.0,
                height: 60.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.handshake_outlined, size: 30, color: Colors.white,),
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  label: Text('Love',
                    style: TextStyle( fontSize: 20,color: Colors.white),),
                ),
              ),
            ],
          ),

          Row(
            children:[
              SizedBox(width: 10,),
              Text(
                "Health Tips",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 400.0,
                height: 65.0,
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.air, size: 30, color: Colors.white,),
                  style: ButtonStyle(
                    alignment: Alignment.centerLeft,
                    backgroundColor: WidgetStatePropertyAll(Colors.white30),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  label: Text('Breathe to Reset',
                    style: TextStyle( fontSize: 20,color: Colors.white),)
                ),
              ),
            ],
          ),
        ], //Children
      ),
    );
  }
}