import 'package:flutter/material.dart';


class AddQuote extends StatefulWidget {
  const AddQuote({super.key});

  @override
  State<AddQuote> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  bool isChecked = false;
  String? selectedCategory;

  final List<String> categories = [
    'Inspirational',
    'Motivational',
  ];

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
          'Add Quote',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          spacing: 100,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Select Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Container(
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    hint: Text(
                      'Choose category', style: TextStyle(fontSize: 18,color: Colors.white),),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 32,
                    ),
                    dropdownColor: Colors.black,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    items: categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                  ),
                ),


                Text(
                  'Author Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextField(
                  decoration: InputDecoration(
                    hintText: 'Author Name',
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
                Text(
                  'Quote',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Container(
                  child:  TextField(
                    maxLines: 10,//increases the height
                    decoration: InputDecoration(
                      hintText: 'Write a Quote',
                    ),
                  ),
                ),
              ],

            ),

            SizedBox(
              height: 70,
              width: 500,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white12),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)), // No rounded corners
                    ),
                  ),
                ),
                child: Text('Save', style: TextStyle(fontSize: 20, color: Colors.white),),
              ),
            ),
          ], //Main Children
        ),
      ),
    );
  }
}