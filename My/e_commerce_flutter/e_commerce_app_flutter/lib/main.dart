// import 'package:e_commerce_app_flutter/database/database_helper.dart';
// import 'package:e_commerce_app_flutter/models/user.dart';
// import 'package:e_commerce_app_flutter/screens/user_Profile_Screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'screens/auth/login_screen.dart';
// import 'screens/auth/register_screen.dart';
// import 'screens/profile_screen.dart';
// import 'screens/categories_screen.dart';
// import 'screens/product_detail_screen.dart';
// import 'screens/cart_screen.dart';
// import 'screens/checkout_screen.dart';
// import 'screens/orders_screen.dart';
// import 'screens/search_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   if (!kIsWeb) {
//     await DatabaseHelper().database;
//   }

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'E-Commerce App',
//       theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
//       initialRoute: '/login',
//       debugShowCheckedModeBanner: false,
//       routes: {
//         '/login': (context) => LoginScreen(),
//         '/register': (context) => RegisterScreen(),
//         '/home': (context) {
//           final args = ModalRoute.of(context)?.settings.arguments;
//           if (args is User) {
//             return HomeScreen(user: args);
//           }
//           return Scaffold(body: Center(child: Text('Please login first')));
//         },
//         '/profile': (context) {
//           final args = ModalRoute.of(context)?.settings.arguments;
//           if (args is User) {
//             return ProfileScreen(user: args);
//           }
//           return Scaffold(body: Center(child: Text('User data not found')));
//         },
//         '/categories': (context) {
//           final args = ModalRoute.of(context)?.settings.arguments;
//           if (args is User) {
//             return CategoriesScreen(user: args);
//           }
//           return Scaffold(body: Center(child: Text('User data not found')));
//         },
//         // '/products': (context) {
//         //   final args = ModalRoute.of(context)?.settings.arguments;
//         //   if (args is Map<String, dynamic>) {
//         //     return ProductsScreen(
//         //       user: args['user'],
//         //       category: args['category'],
//         //     );
//         //   }
//         //   return Scaffold(
//         //     body: Center(child: Text('Invalid arguments')),
//         //   );
//         // },
//         '/product-detail': (context) {
//           final args = ModalRoute.of(context)?.settings.arguments;
//           if (args is Map<String, dynamic>) {
//             return ProductDetailScreen(
//               user: args['user'],
//               product: args['product'],
//             );
//           }
//           return Scaffold(body: Center(child: Text('Invalid arguments')));
//         },
//         '/cart': (context) {
//           final args = ModalRoute.of(context)?.settings.arguments;
//           if (args is User) {
//             return CartScreen(user: args);
//           }
//           return Scaffold(body: Center(child: Text('User data not found')));
//         },
//         '/checkout': (context) {
//           final args = ModalRoute.of(context)?.settings.arguments;
//           if (args is Map<String, dynamic>) {
//             return CheckoutScreen(
//               user: args['user'],
//               cartItems: args['cartItems'],
//               totalAmount: args['totalAmount'],
//             );
//           }
//           return Scaffold(body: Center(child: Text('Invalid arguments')));
//         },
//         '/orders': (context) {
//           final args = ModalRoute.of(context)?.settings.arguments;
//           if (args is User) {
//             return OrdersScreen(user: args);
//           }
//           return Scaffold(body: Center(child: Text('User data not found')));
//         },
//         '/search': (context) {
//           final args = ModalRoute.of(context)?.settings.arguments;
//           if (args is User) {
//             return SearchScreen(user: args);
//           }
//           return Scaffold(body: Center(child: Text('User data not found')));
//         },
//       },
//     );
//   }
// }

// //==================== common appbar====================
// class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final List<Widget>? actions;

//   const CommonAppBar({super.key, required this.title, this.actions});

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(title),
//       titleSpacing: 20,
//       toolbarOpacity: 1,
//       backgroundColor: Colors.deepPurpleAccent,
//       actions:
//           actions ??
//           [
//             IconButton(
//               icon: Icon(Icons.notifications),
//               onPressed: () {
//                 // Notification action
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: () {
//                 // Settings action
//               },
//             ),
//             IconButton(
//               icon: Icon(Icons.dashboard),
//               onPressed: () {
//                 // Dashboard action
//               },
//             ),
//           ],
//     );
//   }
// }

// // // ==========================Common Drawer========================
// // class AppDrawer extends StatelessWidget {
// //   final dynamic user;

// //   const AppDrawer({super.key, required this.user});

// //   void navigate(BuildContext context, String route) {
// //     Navigator.pop(context);
// //     Navigator.pushNamed(context, route);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Drawer(
// //       child: ListView(
// //         padding: EdgeInsets.zero,
// //         children: [
// //           UserAccountsDrawerHeader(
// //             accountName: Text(user.name),
// //             accountEmail: Text(user.email),
// //             decoration: BoxDecoration(color: Colors.blue),
// //             currentAccountPicture: CircleAvatar(
// //               backgroundColor: Colors.white,
// //               child: Icon(Icons.person, color: Colors.blue),
// //             ),
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.home, color: Colors.blue),
// //             title: const Text("Home"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               // Navigate to home
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.category, color: Colors.green),
// //             title: const Text("Categories"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               // Navigate to categories
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.search, color: Colors.orange),
// //             title: const Text("Search"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               // Navigate to search
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.shopping_cart, color: Colors.red),
// //             title: const Text("Cart"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               // Navigate to cart
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.history, color: Colors.purple),
// //             title: const Text("Orders"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               // Navigate to orders
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.person, color: Colors.teal),
// //             title: const Text("Profile"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               // Already on profile page
// //             },
// //           ),
// //           Divider(),
// //           ListTile(
// //             leading: const Icon(Icons.settings, color: Colors.grey),
// //             title: const Text("Settings"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               // Handle settings
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.help, color: Colors.grey),
// //             title: const Text("Help & Support"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               // Handle help
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.logout, color: Colors.red),
// //             title: const Text("Logout"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               // Handle logout
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // ==========================Simple Drawer========================
// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           // App Logo/Header
//           Container(
//             height: 150,
//             width: double.infinity,
//             color: Colors.blue,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.shopping_cart,
//                     size: 50,
//                     color: Colors.white,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'E-Commerce App',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 // Navigation Section
//                 _buildSectionHeader('Navigation'),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.home,
//                   title: 'Home',
//                   route: '/home',
//                 ),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.category,
//                   title: 'Categories',
//                   route: '/categories',
//                 ),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.shopping_bag,
//                   title: 'Products',
//                   route: '/products',
//                 ),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.shopping_cart,
//                   title: 'Cart',
//                   route: '/cart',
//                 ),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.history,
//                   title: 'Orders',
//                   route: '/orders',
//                 ),

//                 Divider(),

//                 // Account Section
//                 _buildSectionHeader('Account'),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.person,
//                   title: 'Profile',
//                   route: '/profile',
//                 ),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.login,
//                   title: 'Login',
//                   route: '/login',
//                 ),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.person_add,
//                   title: 'Register',
//                   route: '/register',
//                 ),

//                 Divider(),

//                 // App Section
//                 _buildSectionHeader('App'),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.settings,
//                   title: 'Settings',
//                   route: '/settings',
//                 ),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.help,
//                   title: 'Help',
//                   route: '/help',
//                 ),

//                 _buildMenuItem(
//                   context: context,
//                   icon: Icons.info,
//                   title: 'About',
//                   route: '/about',
//                 ),

//                 // Logout Button
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       Navigator.pushNamedAndRemoveUntil(
//                         context,
//                         '/login',
//                         (route) => false,
//                       );
//                     },
//                     icon: Icon(Icons.logout),
//                     label: Text('Logout'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//           color: Colors.grey.shade600,
//           letterSpacing: 1.0,
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String route,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.blue),
//       title: Text(title),
//       trailing: Icon(Icons.chevron_right, color: Colors.grey),
//       onTap: () {
//         Navigator.pop(context);
//         Navigator.pushNamed(context, route);
//       },
//     );
//   }
// }

import 'package:e_commerce_app_flutter/database/database_helper.dart';
import 'package:e_commerce_app_flutter/models/user.dart';
import 'package:e_commerce_app_flutter/screens/products_screen.dart';
import 'package:e_commerce_app_flutter/screens/user_Profile_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await DatabaseHelper().database;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
      onGenerateRoute: (settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/home':
            if (args is User)
              return MaterialPageRoute(builder: (_) => HomeScreen(user: args));
            return _errorScreen('Please login first');

          case '/profile':
            if (args is User)
              return MaterialPageRoute(
                builder: (_) => ProfileScreen(user: args),
              );
            return _errorScreen('User data not found');

          case '/categories':
            if (args is User)
              return MaterialPageRoute(
                builder: (_) => CategoriesScreen(user: args),
              );
            return _errorScreen('User data not found');

          case '/products': // ✅ FIXED
            if (args is Map<String, dynamic>) {
              return MaterialPageRoute(
                builder: (_) => ProductsScreen(
                  user: args['user'],
                  // category: args['category'],
                ),
              );
            }
            return _errorScreen('No arguments passed for Products');

          case '/product-detail':
            if (args is Map<String, dynamic>) {
              return MaterialPageRoute(
                builder: (_) => ProductDetailScreen(
                  user: args['user'],
                  product: args['product'],
                ),
              );
            }
            return _errorScreen('Invalid arguments');

          case '/cart':
            if (args is User)
              return MaterialPageRoute(builder: (_) => CartScreen(user: args));
            return _errorScreen('User data not found');

          case '/checkout':
            if (args is Map<String, dynamic>) {
              return MaterialPageRoute(
                builder: (_) => CheckoutScreen(
                  user: args['user'],
                  cartItems: args['cartItems'],
                  totalAmount: args['totalAmount'],
                ),
              );
            }
            return _errorScreen('Invalid arguments');

          case '/orders':
            if (args is User)
              return MaterialPageRoute(
                builder: (_) => OrdersScreen(user: args),
              );
            return _errorScreen('User data not found');

          case '/search':
            if (args is User)
              return MaterialPageRoute(
                builder: (_) => SearchScreen(user: args),
              );
            return _errorScreen('User data not found');

          default:
            return _errorScreen('Route not found');
        }
      },
    );
  }

  MaterialPageRoute _errorScreen(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(body: Center(child: Text(message))),
    );
  }
}

// ===================== Common AppBar =====================
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CommonAppBar({super.key, required this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleSpacing: 20,
      toolbarOpacity: 1,
      backgroundColor: Colors.deepPurpleAccent,
      actions:
          actions ??
          [
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
            IconButton(icon: Icon(Icons.dashboard), onPressed: () {}),
          ],
    );
  }
}

// ========================== Drawer =========================
class AppDrawer extends StatelessWidget {
  final User? currentUser; // pass current user for arguments

  const AppDrawer({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'E-Commerce App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildSectionHeader('Navigation'),
                _buildMenuItem(
                  context: context,
                  icon: Icons.home,
                  title: 'Home',
                  route: '/home',
                  arguments: currentUser,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.category,
                  title: 'Categories',
                  route: '/categories',
                  arguments: currentUser,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.shopping_bag,
                  title: 'Products',
                  route: '/products',
                  arguments: {'user': currentUser, 'category': 'All'},
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.shopping_cart,
                  title: 'Cart',
                  route: '/cart',
                  arguments: currentUser,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.history,
                  title: 'Orders',
                  route: '/orders',
                  arguments: currentUser,
                ),
                Divider(),
                _buildSectionHeader('Account'),
                _buildMenuItem(
                  context: context,
                  icon: Icons.person,
                  title: 'Profile',
                  route: '/profile',
                  arguments: currentUser,
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.login,
                  title: 'Login',
                  route: '/login',
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.person_add,
                  title: 'Register',
                  route: '/register',
                ),
                Divider(),
                _buildSectionHeader('App'),
                _buildMenuItem(
                  context: context,
                  icon: Icons.settings,
                  title: 'Settings',
                  route: '/settings',
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.help,
                  title: 'Help',
                  route: '/help',
                ),
                _buildMenuItem(
                  context: context,
                  icon: Icons.info,
                  title: 'About',
                  route: '/about',
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    icon: Icon(Icons.logout),
                    label: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
    Object? arguments,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route, arguments: arguments);
      },
    );
  }
}
