import 'package:flutter/material.dart';

/// ====================
/// DUMMY MODELS
/// ====================

class DummyVendor {
  final String id;
  final String shopName;
  final String ownerName;
  final String description;
  final String logoImage;
  final String coverImage;
  final double rating;
  final int totalRatings;
  final int followerCount;
  final String joinDate;
  final String location;
  final String contactEmail;
  final String contactPhone;
  final bool isVerified;

  const DummyVendor({
    required this.id,
    required this.shopName,
    required this.ownerName,
    required this.description,
    required this.logoImage,
    required this.coverImage,
    required this.rating,
    required this.totalRatings,
    required this.followerCount,
    required this.joinDate,
    required this.location,
    required this.contactEmail,
    required this.contactPhone,
    required this.isVerified,
  });
}

class DummyVendorProduct {
  final String id;
  final String name;
  final String image;
  final double price;
  final double originalPrice;
  final double rating;
  final int soldCount;
  bool isFavorite;
  final bool inStock;

  DummyVendorProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.soldCount,
    this.isFavorite = false,
    this.inStock = true,
  });
}

/// ====================
/// SCREEN
/// ====================

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  bool isFollowing = false;

  final DummyVendor vendor = const DummyVendor(
    id: 'v1',
    shopName: 'TechGear Pro',
    ownerName: 'Michael Chen',
    description:
        'Premium electronics and gadgets store with fast delivery and warranty support.',
    logoImage: 'https://picsum.photos/200',
    coverImage: 'https://picsum.photos/800/300',
    rating: 4.8,
    totalRatings: 1287,
    followerCount: 2543,
    joinDate: 'March 2022',
    location: 'San Francisco, CA',
    contactEmail: 'contact@techgearpro.com',
    contactPhone: '+1 555 987 6543',
    isVerified: true,
  );

  late List<DummyVendorProduct> products;

  @override
  void initState() {
    super.initState();
    products = [
      DummyVendorProduct(
        id: 'p1',
        name: 'Wireless Headphones',
        image: 'https://picsum.photos/400',
        price: 149.99,
        originalPrice: 199.99,
        rating: 4.7,
        soldCount: 342,
        isFavorite: true,
      ),
      DummyVendorProduct(
        id: 'p2',
        name: 'Smart Watch',
        image: 'https://picsum.photos/401',
        price: 299.99,
        originalPrice: 349.99,
        rating: 4.9,
        soldCount: 187,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildVendorInfo()),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: _buildProductGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(vendor.coverImage, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildVendorInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            vendor.shopName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(vendor.description),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isFollowing = !isFollowing;
                    });
                  },
                  child: Text(isFollowing ? 'Following' : 'Follow'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Contact'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildProductCard(products[index], index),
        childCount: products.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
    );
  }

  Widget _buildProductCard(DummyVendorProduct product, int index) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              product.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
