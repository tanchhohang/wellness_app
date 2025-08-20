import 'package:flutter/material.dart';

import '../services/firestore_service.dart';

class DashboardPageTwo extends StatefulWidget {
  const DashboardPageTwo({super.key});

  @override
  State<DashboardPageTwo> createState() => _DashboardPageTwoState();
}

class _DashboardPageTwoState extends State<DashboardPageTwo> {
  int _totalCategories = 0;
  int _totalQuotes = 0;
  int _totalUsers = 0;
  bool _isLoading = true;

  @override

  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    try {
      int userCount = await FireStoreService().getTotalUser(userId: "");
      int categoryCount = await FireStoreService().getTotalCategory(userId: "");
      int quoteCount = await FireStoreService().getTotalQuote(userId: "");

      setState(() {
        _totalCategories = categoryCount;
        _totalQuotes = quoteCount;
        _totalUsers = userCount;
        _isLoading = false;
      });
    } catch (e) {
      // handle error if needed
      setState(() {
        _isLoading = false;
      });
    }
  }

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
          'Dashboard',
          style: TextStyle(
            fontFamily: 'Poppins', color: Colors.white,
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

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Column(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    spacing: 100,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.people_rounded, size: 70),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Total Users', style: TextStyle(fontSize: 18, color: Colors.white54),),
                          Text('$_totalUsers', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Column(
              spacing: 20,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    spacing: 100,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Total Category', style: TextStyle(fontSize: 16),),
                            Text('$_totalCategories',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)
                          ]
                      ),

                      Column(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/addcategory');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Colors.white12,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(5),
                            ),
                          child:Text('+', style: TextStyle(fontSize: 32, color: Colors.white),),
                          ),
                          
                          Text('Add New',style: TextStyle(color: Colors.white54),)
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    spacing: 100,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Total Quotes', style: TextStyle(fontSize: 16),),
                            Text('$_totalQuotes',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)
                          ]
                      ),

                      Column(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/addquote');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Colors.white12,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(5),
                            ),
                            child:Text('+', style: TextStyle(fontSize: 32, color: Colors.white),),
                          ),

                          Text('Add New',style: TextStyle(color: Colors.white54),)
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    spacing: 100,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Total Health Tips', style: TextStyle(fontSize: 16),),
                            Text('50',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),)
                          ]
                      ),

                      Column(
                        spacing: 5,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/dashboard');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Colors.white12,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(5),
                            ),
                            child:Text('+', style: TextStyle(fontSize: 32, color: Colors.white),),
                          ),

                          Text('Add New',style: TextStyle(color: Colors.white54),)
                        ],
                      ),
                    ],
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