import 'package:e_commerce_app_flutter/main.dart';
import 'package:flutter/material.dart';

// ====================
// DUMMY DATA MODELS (UI Only)
// ====================

class DummyUser {
  final String name;
  final String email;
  final String? profileImage;

  const DummyUser({required this.name, required this.email, this.profileImage});
}

class DummyCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const DummyCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class DummyProduct {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String vendorName;
  final bool isFavorite;

  const DummyProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.vendorName,
    this.isFavorite = false,
  });
}

// ====================
// REUSABLE WIDGETS
// ====================

class ProductCard extends StatelessWidget {
  final DummyProduct product;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Favorite Button
              Stack(
                children: [
                  // Product Image
                  Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.shopping_bag,
                            size: 60,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: onFavoriteTap,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: product.isFavorite ? Colors.red : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Product Name
              Text(
                product.name,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              // Vendor Name
              Text(
                'By ${product.vendorName}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Rating Row
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          product.rating.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(Icons.star, size: 12, color: Colors.green),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '(${product.reviewCount})',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Price and Action Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  // Add to Cart Button
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        size: 20,
                        color: Colors.blue,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final DummyCategory category;
  final VoidCallback? onTap;

  const CategoryItem({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            // Category Icon Container
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(category.icon, size: 28, color: category.color),
            ),
            const SizedBox(height: 8),
            // Category Name
            Text(
              category.name,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ====================
// HOME SCREEN
// ====================

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Dummy Categories Data (UI Only)
  final List<DummyCategory> categories = const [
    DummyCategory(
      id: '1',
      name: 'Electronics',
      icon: Icons.electrical_services,
      color: Colors.blue,
    ),
    DummyCategory(
      id: '2',
      name: 'Fashion',
      icon: Icons.shopping_bag,
      color: Colors.pink,
    ),
    DummyCategory(id: '3', name: 'Home', icon: Icons.home, color: Colors.green),
    DummyCategory(
      id: '4',
      name: 'Beauty',
      icon: Icons.spa,
      color: Colors.purple,
    ),
    DummyCategory(
      id: '5',
      name: 'Sports',
      icon: Icons.sports_basketball,
      color: Colors.orange,
    ),
    DummyCategory(
      id: '6',
      name: 'Books',
      icon: Icons.menu_book,
      color: Colors.brown,
    ),
  ];

  // Dummy Products Data (UI Only)
  final List<DummyProduct> featuredProducts = const [
    DummyProduct(
      id: '1',
      name: 'Wireless Bluetooth Headphones',
      description: 'Noise cancelling over-ear headphones',
      price: 129.99,
      imageUrl: 'https://picsum.photos/seed/headphone/400/300',
      rating: 4.5,
      reviewCount: 128,
      vendorName: 'AudioTech',
      isFavorite: true,
    ),
    DummyProduct(
      id: '2',
      name: 'Smart Watch Series 5',
      description: 'Fitness tracker with heart rate monitor',
      price: 249.99,
      imageUrl: 'https://picsum.photos/seed/watch/400/300',
      rating: 4.7,
      reviewCount: 89,
      vendorName: 'TechGear',
      isFavorite: false,
    ),
    DummyProduct(
      id: '3',
      name: 'Organic Cotton T-Shirt',
      description: '100% organic cotton, regular fit',
      price: 29.99,
      imageUrl: 'https://picsum.photos/seed/tshirt/400/300',
      rating: 4.3,
      reviewCount: 56,
      vendorName: 'EcoWear',
      isFavorite: true,
    ),
    DummyProduct(
      id: '4',
      name: 'Ceramic Coffee Mug',
      description: 'Heat retaining ceramic mug, 350ml',
      price: 19.99,
      imageUrl: 'https://picsum.photos/seed/mug/400/300',
      rating: 4.8,
      reviewCount: 203,
      vendorName: 'HomeEssentials',
      isFavorite: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Online Shop"),
      backgroundColor: Colors.grey.shade50,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with Search
            SliverAppBar(
              floating: true,
              pinned: false,
              snap: true,
              backgroundColor: Colors.white,
              elevation: 1,
              title: Row(
                children: [
                  // App Logo/Title
                  const Text(
                    'ShopEasy',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.orange.shade400,
                    size: 20,
                  ),
                ],
              ),
              actions: [
                // Notification Icon
                IconButton(
                  onPressed: () {},
                  icon: Badge(
                    label: const Text('3'),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        prefixIcon: const Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Body Content
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 8),
                // Promotional Banner
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue.shade400, Colors.purple.shade400],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 16,
                          top: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/discount.png',
                            width: 120,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.discount,
                                size: 100,
                                color: Colors.white,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SUMMER SALE',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Up to 50% OFF',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Shop Now',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Categories Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('See All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Categories List
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index == categories.length - 1 ? 0 : 16,
                              ),
                              child: CategoryItem(
                                category: categories[index],
                                onTap: () {},
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Featured Products Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Featured Products',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('See All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Products Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.75,
                            ),
                        itemCount: featuredProducts.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: featuredProducts[index],
                            onTap: () {},
                            onFavoriteTap: () {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: Badge(
              label: Text('2'),
              child: Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedIndex: 0,
        onDestinationSelected: (index) {},
      ),
    );
  }
}
