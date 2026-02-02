import 'package:e_commerce_app_flutter/main.dart';
import 'package:e_commerce_app_flutter/models/user.dart';
import 'package:e_commerce_app_flutter/screens/cart_screen.dart';
import 'package:e_commerce_app_flutter/screens/categories_screen.dart';
import 'package:e_commerce_app_flutter/screens/orders_screen.dart';
import 'package:e_commerce_app_flutter/screens/profile_screen.dart';
import 'package:e_commerce_app_flutter/screens/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// Replace bottom navigation bar screens with navigation using named routes
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      {'screen': CategoriesScreen(user: widget.user), 'title': 'Categories'},
      {'screen': SearchScreen(user: widget.user), 'title': 'Search'},
      {'screen': CartScreen(user: widget.user), 'title': 'Cart'},
      {'screen': OrdersScreen(user: widget.user), 'title': 'Orders'},
      {'screen': ProfileScreen(user: widget.user), 'title': 'Profile'},
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: _screens[_selectedIndex]['title']),
      drawer: AppDrawer(),
      body: _screens[_selectedIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
