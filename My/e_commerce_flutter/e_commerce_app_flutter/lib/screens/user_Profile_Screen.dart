// ====================
// DUMMY DATA MODELS (UI Only)
// ====================

import 'package:e_commerce_app_flutter/main.dart';
import 'package:e_commerce_app_flutter/models/user.dart';
import 'package:flutter/material.dart';

class DummyUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String profileImage;
  final String joinDate;
  final int totalOrders;
  final double totalSpent;
  final String membershipLevel;
  final List<String> addresses;

  const DummyUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
    required this.joinDate,
    required this.totalOrders,
    required this.totalSpent,
    required this.membershipLevel,
    required this.addresses,
  });
}

class DummyOrder {
  final String id;
  final String date;
  final double amount;
  final int itemCount;
  final String status;
  final String statusColor;
  final String trackingNumber;
  final List<DummyOrderItem> items;

  const DummyOrder({
    required this.id,
    required this.date,
    required this.amount,
    required this.itemCount,
    required this.status,
    required this.statusColor,
    required this.trackingNumber,
    required this.items,
  });
}

class DummyOrderItem {
  final String id;
  final String name;
  final String image;
  final int quantity;
  final double price;

  const DummyOrderItem({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });
}

// ====================
// REUSABLE WIDGETS
// ====================

class ProfileInfoCard extends StatelessWidget {
  final DummyUser user;
  final VoidCallback? onEditProfile;
  final VoidCallback? onViewAddresses;

  const ProfileInfoCard({
    super.key,
    required this.user,
    this.onEditProfile,
    this.onViewAddresses,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue.shade100, width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 37,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: NetworkImage(user.profileImage),
                    onBackgroundImageError: (_, __) {},
                    child: user.profileImage.isEmpty
                        ? Text(
                            user.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 16),
                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Membership Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getMembershipColor(user.membershipLevel),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getMembershipIcon(user.membershipLevel),
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              user.membershipLevel,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Edit Button
                IconButton(
                  onPressed: onEditProfile,
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit, size: 18, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Stats Row
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Total Orders
                  _buildStatItem(
                    icon: Icons.shopping_bag,
                    value: user.totalOrders.toString(),
                    label: 'Orders',
                  ),
                  // Total Spent
                  _buildStatItem(
                    icon: Icons.attach_money,
                    value: '\$${user.totalSpent.toStringAsFixed(0)}',
                    label: 'Spent',
                  ),
                  // Member Since
                  _buildStatItem(
                    icon: Icons.calendar_today,
                    value: user.joinDate,
                    label: 'Member',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Contact Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contact Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _buildContactInfoItem(icon: Icons.phone, text: user.phone),
                const SizedBox(height: 8),
                _buildContactInfoItem(icon: Icons.email, text: user.email),
                const SizedBox(height: 8),
                _buildContactInfoItem(
                  icon: Icons.location_on,
                  text: '${user.addresses.length} saved addresses',
                  isAction: true,
                  onTap: onViewAddresses,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildContactInfoItem({
    required IconData icon,
    required String text,
    bool isAction = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: isAction ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade600),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: isAction ? Colors.blue : Colors.grey.shade700,
                  fontWeight: isAction ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            if (isAction)
              const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Color _getMembershipColor(String level) {
    switch (level.toLowerCase()) {
      case 'gold':
        return Colors.amber.shade700;
      case 'silver':
        return Colors.grey.shade600;
      case 'platinum':
        return Colors.blue.shade800;
      default:
        return Colors.green;
    }
  }

  IconData _getMembershipIcon(String level) {
    switch (level.toLowerCase()) {
      case 'gold':
        return Icons.workspace_premium;
      case 'silver':
        return Icons.star;
      case 'platinum':
        return Icons.diamond;
      default:
        return Icons.person;
    }
  }
}

class OrderHistoryCard extends StatelessWidget {
  final DummyOrder order;
  final VoidCallback? onViewDetails;
  final VoidCallback? onTrackOrder;

  const OrderHistoryCard({
    super.key,
    required this.order,
    this.onViewDetails,
    this.onTrackOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${order.id}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.statusColor).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: _getStatusColor(order.statusColor),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Order Items Preview
            if (order.items.isNotEmpty) ...[
              Container(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: order.items.length,
                  itemBuilder: (context, index) {
                    final item = order.items[index];
                    return Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.only(
                        right: index == order.items.length - 1 ? 0 : 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.shopping_bag,
                                size: 24,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${order.itemCount} item${order.itemCount > 1 ? 's' : ''}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
            ],
            // Order Summary
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${order.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                // Tracking Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Tracking #',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.trackingNumber,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onViewDetails,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      side: BorderSide(color: Colors.blue.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('View Details'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onTrackOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Track Order'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String statusColor) {
    switch (statusColor.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// ====================
// USER PROFILE SCREEN
// ====================

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  // Dummy User Data
  final DummyUser user = const DummyUser(
    id: 'user_001',
    name: 'Alex Johnson',
    email: 'alex.johnson@email.com',
    phone: '+1 (555) 123-4567',
    profileImage: 'https://picsum.photos/seed/userprofile/200/200',
    joinDate: 'Jan 2023',
    totalOrders: 24,
    totalSpent: 2895.50,
    membershipLevel: 'Gold',
    addresses: [
      '123 Main St, New York, NY 10001',
      '456 Park Ave, Brooklyn, NY 11201',
    ],
  );

  // Dummy Orders Data
  final List<DummyOrder> orders = [
    DummyOrder(
      id: 'ORD-789456',
      date: 'Dec 15, 2023',
      amount: 129.99,
      itemCount: 2,
      status: 'Delivered',
      statusColor: 'green',
      trackingNumber: 'TRK-789456123',
      items: [
        DummyOrderItem(
          id: '1',
          name: 'Wireless Headphones',
          image: 'https://picsum.photos/seed/headphone/100/100',
          quantity: 1,
          price: 129.99,
        ),
        DummyOrderItem(
          id: '2',
          name: 'Phone Case',
          image: 'https://picsum.photos/seed/case/100/100',
          quantity: 1,
          price: 24.99,
        ),
      ],
    ),
    DummyOrder(
      id: 'ORD-123789',
      date: 'Nov 28, 2023',
      amount: 459.98,
      itemCount: 3,
      status: 'Shipped',
      statusColor: 'blue',
      trackingNumber: 'TRK-123789456',
      items: [
        DummyOrderItem(
          id: '3',
          name: 'Smart Watch',
          image: 'https://picsum.photos/seed/watch/100/100',
          quantity: 1,
          price: 249.99,
        ),
        DummyOrderItem(
          id: '4',
          name: 'T-Shirt',
          image: 'https://picsum.photos/seed/tshirt/100/100',
          quantity: 2,
          price: 29.99,
        ),
      ],
    ),
    DummyOrder(
      id: 'ORD-456123',
      date: 'Oct 10, 2023',
      amount: 89.99,
      itemCount: 1,
      status: 'Processing',
      statusColor: 'orange',
      trackingNumber: 'TRK-456123789',
      items: [
        DummyOrderItem(
          id: '5',
          name: 'Coffee Mug Set',
          image: 'https://picsum.photos/seed/mug/100/100',
          quantity: 1,
          price: 89.99,
        ),
      ],
    ),
    DummyOrder(
      id: 'ORD-987654',
      date: 'Sep 5, 2023',
      amount: 199.99,
      itemCount: 2,
      status: 'Cancelled',
      statusColor: 'red',
      trackingNumber: 'TRK-987654321',
      items: [
        DummyOrderItem(
          id: '6',
          name: 'Laptop Bag',
          image: 'https://picsum.photos/seed/bag/100/100',
          quantity: 1,
          price: 79.99,
        ),
        DummyOrderItem(
          id: '7',
          name: 'Wireless Mouse',
          image: 'https://picsum.photos/seed/mouse/100/100',
          quantity: 1,
          price: 120.00,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: CommonAppBar(title: "My Profile"),
      drawer: AppDrawer(),

      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              // Profile Info Section
              ProfileInfoCard(
                user: user,
                onEditProfile: () {
                  print('Edit profile tapped');
                },
                onViewAddresses: () {
                  print('View addresses tapped');
                },
              ),
              // Order History Section
              _buildOrderHistorySection(),
              // Account Actions Section
              _buildAccountActionsSection(),
              const SizedBox(height: 32),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Order History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              TextButton(onPressed: () {}, child: const Text('View All')),
            ],
          ),
        ),
        // Order Status Filter Chips
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildFilterChip('All', true),
              const SizedBox(width: 8),
              _buildFilterChip('Delivered', false),
              const SizedBox(width: 8),
              _buildFilterChip('Processing', false),
              const SizedBox(width: 8),
              _buildFilterChip('Cancelled', false),
            ],
          ),
        ),
        // Orders List
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return OrderHistoryCard(
              order: orders[index],
              onViewDetails: () {
                print('View details for order ${orders[index].id}');
              },
              onTrackOrder: () {
                print('Track order ${orders[index].id}');
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        print('Filter changed to: $label');
      },
      selectedColor: Colors.blue,
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey.shade700,
      ),
    );
  }

  Widget _buildAccountActionsSection() {
    final List<Map<String, dynamic>> accountActions = [
      {'icon': Icons.favorite_border, 'label': 'Wishlist', 'count': '12 items'},
      {
        'icon': Icons.receipt_long,
        'label': 'Returns & Refunds',
        'count': '2 requests',
      },
      {
        'icon': Icons.credit_card,
        'label': 'Payment Methods',
        'count': '3 cards',
      },
      {
        'icon': Icons.help_outline,
        'label': 'Help Center',
        'count': 'FAQ & Support',
      },
      {
        'icon': Icons.notifications,
        'label': 'Notifications',
        'count': 'Unread: 3',
      },
      {
        'icon': Icons.security,
        'label': 'Privacy & Security',
        'count': 'Manage settings',
      },
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: accountActions.length,
            itemBuilder: (context, index) {
              final action = accountActions[index];
              return Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    print('${action['label']} tapped');
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            action['icon'] as IconData,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                action['label'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                action['count'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
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
      home: UserProfileScreen(),
    );
  }
}
