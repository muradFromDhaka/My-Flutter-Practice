import 'package:flutter/material.dart';

void main() {
  runApp(const ECommerceApp());
}

// ====================
// DUMMY DATA MODELS (UI Only)
// ====================

class DummyCartItem {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final String vendorName;
  int quantity;
  final bool inStock;

  DummyCartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.vendorName,
    this.quantity = 1,
    this.inStock = true,
  });
}

// ====================
// REUSABLE WIDGETS
// ====================

class CartItemCard extends StatelessWidget {
  final DummyCartItem item;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const CartItemCard({
    super.key,
    required this.item,
    this.onIncrease,
    this.onDecrease,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.productImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.shopping_bag,
                        size: 40,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name and Remove Button
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.productName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: onRemove,
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    // Vendor Name
                    Text(
                      'Sold by: ${item.vendorName}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    // Stock Status
                    Row(
                      children: [
                        Icon(
                          item.inStock ? Icons.check_circle : Icons.error,
                          size: 14,
                          color: item.inStock ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.inStock ? 'In Stock' : 'Low Stock',
                          style: TextStyle(
                            fontSize: 12,
                            color: item.inStock ? Colors.green : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Price and Quantity Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        Text(
                          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue.shade800,
                                  ),
                        ),
                        // Quantity Controls
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              // Decrease Button
                              IconButton(
                                onPressed: onDecrease,
                                icon: const Icon(
                                  Icons.remove,
                                  size: 18,
                                ),
                                padding: const EdgeInsets.all(4),
                                constraints: const BoxConstraints(),
                                color: item.quantity > 1
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              // Quantity Display
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.symmetric(
                                    vertical: BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  item.quantity.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // Increase Button
                              IconButton(
                                onPressed: onIncrease,
                                icon: const Icon(
                                  Icons.add,
                                  size: 18,
                                ),
                                padding: const EdgeInsets.all(4),
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartSummaryCard extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double discount;
  final double tax;
  final VoidCallback? onCheckout;
  final VoidCallback? onApplyCoupon;

  const CartSummaryCard({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.tax,
    this.onCheckout,
    this.onApplyCoupon,
  });

  @override
  Widget build(BuildContext context) {
    final total = subtotal + shipping - discount + tax;

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Section Title
            Row(
              children: [
                const Icon(
                  Icons.receipt_long,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(
                  'Order Summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Price Breakdown
            Column(
              children: [
                _buildPriceRow(
                  'Subtotal',
                  '\$${subtotal.toStringAsFixed(2)}',
                  context,
                ),
                const SizedBox(height: 8),
                _buildPriceRow(
                  'Shipping',
                  shipping == 0 ? 'FREE' : '\$${shipping.toStringAsFixed(2)}',
                  context,
                  valueStyle: shipping == 0
                      ? const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        )
                      : null,
                ),
                const SizedBox(height: 8),
                _buildPriceRow(
                  'Discount',
                  '-\$${discount.toStringAsFixed(2)}',
                  context,
                  valueStyle: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildPriceRow(
                  'Tax',
                  '\$${tax.toStringAsFixed(2)}',
                  context,
                ),
                const SizedBox(height: 12),
                Divider(color: Colors.grey.shade300),
                const SizedBox(height: 12),
                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    Text(
                      '\$${total.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.blue.shade800,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Coupon Input
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter coupon code',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                    ),
                    child: TextButton(
                      onPressed: onApplyCoupon,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Checkout Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Proceed to Checkout',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String value,
    BuildContext context, {
    TextStyle? valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
        Text(
          value,
          style: valueStyle ??
              Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
        ),
      ],
    );
  }
}

// ====================
// CART SCREEN
// ====================

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  // Dummy Cart Items Data
  final List<DummyCartItem> cartItems = [
    DummyCartItem(
      id: '1',
      productId: '101',
      productName: 'Wireless Bluetooth Headphones',
      productImage: 'https://picsum.photos/seed/headphone/400/300',
      price: 129.99,
      vendorName: 'AudioTech',
      quantity: 1,
      inStock: true,
    ),
    DummyCartItem(
      id: '2',
      productId: '102',
      productName: 'Smart Watch Series 5',
      productImage: 'https://picsum.photos/seed/watch/400/300',
      price: 249.99,
      vendorName: 'TechGear',
      quantity: 2,
      inStock: true,
    ),
    DummyCartItem(
      id: '3',
      productId: '103',
      productName: 'Organic Cotton T-Shirt',
      productImage: 'https://picsum.photos/seed/tshirt/400/300',
      price: 29.99,
      vendorName: 'EcoWear',
      quantity: 3,
      inStock: true,
    ),
    DummyCartItem(
      id: '4',
      productId: '104',
      productName: 'Ceramic Coffee Mug (Limited Edition)',
      productImage: 'https://picsum.photos/seed/mug/400/300',
      price: 19.99,
      vendorName: 'HomeEssentials',
      quantity: 1,
      inStock: false,
    ),
  ];

  // Calculate cart totals
  double get subtotal {
    return cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  double get shipping => subtotal > 100 ? 0.0 : 9.99;
  double get discount => 15.0; // Fixed discount for demo
  double get tax => subtotal * 0.08; // 8% tax

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear Cart',
          ),
        ],
      ),
      body: cartItems.isEmpty ? _buildEmptyCart() : _buildCartWithItems(),
    );
  }

  Widget _buildCartWithItems() {
    return Column(
      children: [
        // Cart Items Count
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              const Icon(
                Icons.shopping_cart_checkout,
                color: Colors.blue,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${cartItems.length} ${cartItems.length == 1 ? 'item' : 'items'} in your cart',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        // Cart Items List
        Expanded(
          child: ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return CartItemCard(
                item: item,
                onIncrease: () {
                  // In a real app, this would update state
                  print('Increase quantity for ${item.productName}');
                },
                onDecrease: () {
                  // In a real app, this would update state
                  print('Decrease quantity for ${item.productName}');
                },
                onRemove: () {
                  // In a real app, this would remove item
                  print('Remove ${item.productName} from cart');
                },
                onTap: () {
                  // In a real app, this would navigate to product details
                  print('View details for ${item.productName}');
                },
              );
            },
          ),
        ),
        // Cart Summary
        CartSummaryCard(
          subtotal: subtotal,
          shipping: shipping,
          discount: discount,
          tax: tax,
          onCheckout: () {
            print('Proceed to checkout');
          },
          onApplyCoupon: () {
            print('Apply coupon');
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty Cart Illustration
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            // Empty Cart Message
            Text(
              'Your cart is empty',
              // style: Theme.of(context).textTheme.titleLarge?.copyWith(
              //       fontWeight: FontWeight.w700,
              //     ),
            ),
            const SizedBox(height: 12),
            Text(
              'Looks like you haven\'t added any items to your cart yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),
            // Continue Shopping Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  print('Continue shopping');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Start Shopping',
                  // style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  //       fontWeight: FontWeight.w600,
                  //     ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ====================
// MAIN APP
// ====================

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopEasy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        // cardTheme: CardTheme(
        //   elevation: 1,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   surfaceTintColor: Colors.white,
        // ),
      ),
      home: CartScreen(),
    );
  }
}