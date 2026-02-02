import 'package:e_commerce_app_flutter/database/database_helper.dart';
import 'package:e_commerce_app_flutter/models/category.dart';
import 'package:e_commerce_app_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'products_screen.dart';
import '../widgets/category_card.dart';

class CategoriesScreen extends StatefulWidget {
  final User user;

  CategoriesScreen({required this.user});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final dbHelper = DatabaseHelper();
    final categories = await dbHelper.getCategories();
    setState(() {
      _categories = categories;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: _categories[index],
                  // In onTap of category card, change to:
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/products',
                      arguments: {
                        'user': widget.user,
                        'category': _categories[index],
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
