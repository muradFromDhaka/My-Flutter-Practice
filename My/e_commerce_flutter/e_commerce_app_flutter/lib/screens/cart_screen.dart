import 'package:e_commerce_app_flutter/database/database_helper.dart';
import 'package:e_commerce_app_flutter/models/cart_item.dart';
import 'package:e_commerce_app_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'checkout_screen.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  final User user;

  CartScreen({required this.user});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [];
  double _totalAmount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final dbHelper = DatabaseHelper();
    final items = await dbHelper.getCartItems(widget.user.id);
    setState(() {
      _cartItems = items;
      _calculateTotal();
      _isLoading = false;
    });
  }

  void _calculateTotal() {
    _totalAmount = _cartItems.fold(0, (total, item) => total + item.totalPrice);
  }

  Future<void> _updateQuantity(int cartItemId, int newQuantity) async {
    final dbHelper = DatabaseHelper();
    if (newQuantity > 0) {
      await dbHelper.updateCartQuantity(cartItemId, newQuantity);
    } else {
      await dbHelper.removeFromCart(cartItemId);
    }
    await _loadCartItems();
  }

  Future<void> _removeItem(int cartItemId) async {
    final dbHelper = DatabaseHelper();
    await dbHelper.removeFromCart(cartItemId);
    await _loadCartItems();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Item removed from cart')));
  }

  Future<void> _clearCart() async {
    if (_cartItems.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Cart'),
        content: Text(
          'Are you sure you want to clear all items from your cart?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final dbHelper = DatabaseHelper();
              await dbHelper.clearCart(widget.user.id);
              await _loadCartItems();

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Cart cleared')));
            },
            child: Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
        actions: _cartItems.isNotEmpty
            ? [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: _clearCart,
                  tooltip: 'Clear Cart',
                ),
              ]
            : null,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Add some products to get started',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return CartItemWidget(
                        item: item,
                        onQuantityChanged: (newQuantity) {
                          _updateQuantity(item.id, newQuantity);
                        },
                        onRemove: () {
                          _removeItem(item.id);
                        },
                      );
                    },
                  ),
                ),
                // Total and Checkout
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${_totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutScreen(
                                  user: widget.user,
                                  cartItems: _cartItems,
                                  totalAmount: _totalAmount,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Proceed to Checkout',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
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
}
