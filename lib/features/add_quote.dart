import 'package:flutter/material.dart';
import '../auth/firestore_service.dart';


class AddQuote extends StatefulWidget {
  final String userId;
  const AddQuote({super.key, required this.userId});

  @override
  State<AddQuote> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  bool isChecked = false;
  String? selectedCategory;
  bool isLoading = false;
  List<Map<String, dynamic>> userCategories = [];

  final TextEditingController _authorNameController = TextEditingController();
  final TextEditingController _quoteController = TextEditingController();

/*  final List<String> categories = [
    'Inspirational',
    'Motivational',
  ];*/

  @override
  void initState() {
    super.initState();
    _loadUserCategories();
  }

  Future<void> _loadUserCategories() async {
    try {
      // Load user categories from FireStore
      List<Map<String, dynamic>> categories = await FireStoreService().getUserCategories(
        userId: widget.userId,
      );

      setState(() {
        userCategories = categories;
      });
    } catch (e) {
      _showSnackBar('Failed to load categories: ${e.toString()}', isError: true);
    }
  }

  Future<void> _saveQuote() async {
    // Validate input
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      _showSnackBar('Please select a category', isError: true);
      return;
    }

    if (_authorNameController.text
        .trim()
        .isEmpty) {
      _showSnackBar('Please enter author name', isError: true);
      return;
    }

    if (_quoteController.text
        .trim()
        .isEmpty) {
      _showSnackBar('Please enter the quote', isError: true);
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Call the FireStore service to add quote
      bool success = await FireStoreService().addQuote(
        userId: widget.userId,
        categoryName: selectedCategory!,
        authorName: _authorNameController.text.trim(),
        quoteText: _quoteController.text.trim(),
      );

      if (success) {
        _showSnackBar('Quote added successfully!');
        Navigator.pushReplacementNamed(context, '/admindashboard');
      } else {
        _showSnackBar('Failed to add quote. Please try again.', isError: true);
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}', isError: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Widget build(BuildContext context) {
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
                      'Choose category',
                      style: TextStyle(fontSize: 18,color: Colors.white),),
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
                    items: userCategories.map((Map<String, dynamic> category) {
                      return DropdownMenuItem<String>(
                        value: category['name'],
                        child: Text(
                          category['name'],
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

                if (userCategories.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'No categories found. Please add a category first.',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 14,
                      ),
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
                  controller: _authorNameController,
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
                    controller: _quoteController,
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
                onPressed: isLoading ? null : _saveQuote,
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