import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

import '../services/firestore_service.dart';


class AddCategory extends StatefulWidget {
  final String userId;
  const AddCategory({super.key, required this.userId});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool isChecked = false;
  String selectedType = 'Quotes';
  bool isLoading = false;

  final TextEditingController _categoryNameController = TextEditingController();

  @override

  Future<void> _saveCategory() async {
    // Validate input
    if (_categoryNameController.text.trim().isEmpty) {
      _showSnackBar('Please enter a category name', isError: true);
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {
      // Call the FireStore service to add category
      bool success = await FireStoreService().addCategory(
        userId: widget.userId,
        categoryName: _categoryNameController.text.trim(),
      );

      if (success) {
        _showSnackBar('Category added successfully!');
        Navigator.pushReplacementNamed(context, '/admindashboard');
      } else {
        _showSnackBar('Failed to add category. Please try again.', isError: true);
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
          'Add Category',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          spacing: 25,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              spacing: 25,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category Name:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _categoryNameController,
                  decoration: InputDecoration(
                    hintText: 'Category Name',
                  ),
                ),
              ],
            ),

            Column(
              spacing: 25,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category Type:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = 'Quotes';
                          });
                        },

                        child: Container(
                          padding: EdgeInsets.all(
                            30
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: selectedType == 'Quotes'
                                    ? Center(
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                    : null,
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Quotes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = 'Health';
                          });
                        },

                        child: Container(
                          padding: EdgeInsets.all(
                              30
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: selectedType == 'Health'
                                    ? Center(
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                    : null,
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Health',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose image for category:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 15),

                    GestureDetector(
                      onTap: () {
                        // Handle image selection
                        print('Image selection tapped');
                        _showSnackBar('Image selection coming soon');
                      },
                      child: DottedBorder(
                        color: Colors.grey[600]!,
                        strokeWidth: 2,
                        dashPattern: [8, 4],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                child: Icon(
                                    Icons.image,
                                    size: 50
                                ),
                              ),
                              SizedBox(height: 15),
                              Text('Tap to choose image'),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),

            SizedBox(height: 100),
            SizedBox(
              height: 70,
              width: 500,
              child: FilledButton(
                onPressed: isLoading ? null : _saveCategory,
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
