import 'package:e_commerce_app_flutter/database/database_helper.dart';
import 'package:e_commerce_app_flutter/models/cart_item.dart';
import 'package:e_commerce_app_flutter/models/order.dart';
import 'package:e_commerce_app_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'orders_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final User user;
  final List<CartItem> cartItems;
  final double totalAmount;
  
  CheckoutScreen({
    required this.user,
    required this.cartItems,
    required this.totalAmount,
  });

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  bool _isLoading = false;
  bool _orderPlaced = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill address if user has one
    if (widget.user.address != null) {
      _addressController.text = widget.user.address!;
    }
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      final dbHelper = DatabaseHelper();
      
      // Create order
      final order = Order(
        id: 0,
        userId: widget.user.id,
        totalAmount: widget.totalAmount,
        status: 'Pending',
        deliveryAddress: _addressController.text,
        orderDate: DateTime.now(),
      );
      
      // Update user address if changed
      if (_addressController.text != widget.user.address) {
        final updatedUser = User(
          id: widget.user.id,
          name: widget.user.name,
          email: widget.user.email,
          password: widget.user.password,
          phone: widget.user.phone,
          address: _addressController.text,
          createdAt: widget.user.createdAt,
        );
        await dbHelper.updateUser(updatedUser);
      }
      
      // Create order in database
      await dbHelper.createOrder(order, widget.cartItems);
      
      setState(() {
        _isLoading = false;
        _orderPlaced = true;
      });
      
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Order Placed!'),
          content: Text('Your order has been placed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrdersScreen(user: widget.user),
                  ),
                );
              },
              child: Text('View Orders'),
            ),
          ],
        ),
      );
      
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to place order: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: _orderPlaced
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 100,
                    color: Colors.green,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Order Placed Successfully!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersScreen(user: widget.user),
                        ),
                      );
                    },
                    child: Text('View Orders'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Summary
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Summary',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16),
                            ...widget.cartItems.map((item) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${item.productName} x${item.quantity}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      '\$${item.totalPrice.toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                            Divider(),
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
                                  '\$${widget.totalAmount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Delivery Address
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        hintText: 'Enter your delivery address',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter delivery address';
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Payment Method (Mock)
                    Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.credit_card, color: Colors.blue),
                        title: Text('Cash on Delivery'),
                        subtitle: Text('Pay when you receive the order'),
                        trailing: Radio(
                          value: 'cod',
                          groupValue: 'cod',
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 32),
                    
                    // Place Order Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _placeOrder,
                        child: _isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Placing Order...'),
                                ],
                              )
                            : Text(
                                'Place Order',
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
            ),
    );
  }
}