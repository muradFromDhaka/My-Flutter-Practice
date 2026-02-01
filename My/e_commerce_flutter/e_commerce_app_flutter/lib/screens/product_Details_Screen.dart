import 'package:e_commerce_app_flutter/main.dart';
import 'package:flutter/material.dart';

// ====================
// DUMMY DATA MODELS (UI Only)
// ====================

class DummyProduct {
  final String id;
  final String name;
  final String description;
  final String longDescription;
  final double price;
  final double originalPrice;
  final String imageUrl;
  final List<String> galleryImages;
  final double rating;
  final int reviewCount;
  final int soldCount;
  final String vendorId;
  final String vendorName;
  final String vendorRating;
  final String category;
  final List<String> tags;
  final List<String> colors;
  final List<String> sizes;
  final bool inStock;
  final int stockQuantity;
  final bool isFavorite;

  const DummyProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.longDescription,
    required this.price,
    required this.originalPrice,
    required this.imageUrl,
    required this.galleryImages,
    required this.rating,
    required this.reviewCount,
    required this.soldCount,
    required this.vendorId,
    required this.vendorName,
    required this.vendorRating,
    required this.category,
    required this.tags,
    required this.colors,
    required this.sizes,
    required this.inStock,
    required this.stockQuantity,
    this.isFavorite = false,
  });
}

class DummyReview {
  final String id;
  final String userId;
  final String userName;
  final String userImage;
  final double rating;
  final String comment;
  final String date;
  final List<String> helpful;
  final List<String> images;

  const DummyReview({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.comment,
    required this.date,
    required this.helpful,
    required this.images,
  });
}

// ====================
// REUSABLE WIDGETS
// ====================

class RatingBarWidget extends StatelessWidget {
  final double rating;
  final double size;
  final bool showNumber;

  const RatingBarWidget({
    super.key,
    required this.rating,
    this.size = 16,
    this.showNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Star Rating
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < rating.floor() ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: size,
            );
          }),
        ),
        const SizedBox(width: 4),
        // Rating Number
        if (showNumber)
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size - 4,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final DummyReview review;
  final VoidCallback? onHelpfulTap;

  const ReviewCard({super.key, required this.review, this.onHelpfulTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reviewer Info
            Row(
              children: [
                // User Avatar
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: NetworkImage(review.userImage),
                  onBackgroundImageError: (_, __) {},
                  child: Text(
                    review.userName[0].toUpperCase(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        review.date,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Rating
                RatingBarWidget(rating: review.rating, size: 16),
              ],
            ),
            const SizedBox(height: 12),
            // Review Comment
            Text(
              review.comment,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 12),
            // Review Images if any
            if (review.images.isNotEmpty)
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: review.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == review.images.length - 1 ? 0 : 8,
                      ),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            review.images[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.photo,
                                size: 30,
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 12),
            // Helpful Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onHelpfulTap,
                icon: const Icon(Icons.thumb_up, size: 16),
                label: Text(
                  'Helpful (${review.helpful.length})',
                  style: const TextStyle(fontSize: 12),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey.shade700,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
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
// PRODUCT DETAILS SCREEN
// ====================

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  // Dummy Product Data
  final DummyProduct product = const DummyProduct(
    id: '1',
    name: 'Premium Wireless Bluetooth Headphones',
    description: 'Noise cancelling over-ear headphones',
    longDescription:
        'Experience premium sound quality with our noise-cancelling wireless headphones. Features include 40mm drivers, 30-hour battery life, memory foam ear cushions, and built-in microphone for crystal clear calls. Perfect for music lovers, gamers, and professionals who demand the best audio experience.',
    price: 129.99,
    originalPrice: 199.99,
    imageUrl: 'https://picsum.photos/seed/headphone/800/600',
    galleryImages: [
      'https://picsum.photos/seed/headphone1/400/300',
      'https://picsum.photos/seed/headphone2/400/300',
      'https://picsum.photos/seed/headphone3/400/300',
      'https://picsum.photos/seed/headphone4/400/300',
    ],
    rating: 4.5,
    reviewCount: 128,
    soldCount: 1250,
    vendorId: 'v1',
    vendorName: 'AudioTech Electronics',
    vendorRating: '4.8',
    category: 'Electronics',
    tags: ['Wireless', 'Noise Cancelling', 'Bluetooth', 'Premium'],
    colors: ['Black', 'White', 'Blue', 'Red'],
    sizes: ['Standard', 'XL'],
    inStock: true,
    stockQuantity: 45,
    isFavorite: true,
  );

  // Dummy Reviews Data
  final List<DummyReview> reviews = const [
    DummyReview(
      id: 'r1',
      userId: 'u1',
      userName: 'Alex Johnson',
      userImage: 'https://picsum.photos/seed/user1/100/100',
      rating: 5.0,
      comment:
          'Amazing sound quality! The noise cancellation works perfectly on my daily commute. Battery life is exactly as advertised. Highly recommended!',
      date: '2 weeks ago',
      helpful: ['u2', 'u3', 'u4'],
      images: [
        'https://picsum.photos/seed/review1/200/200',
        'https://picsum.photos/seed/review2/200/200',
      ],
    ),
    DummyReview(
      id: 'r2',
      userId: 'u2',
      userName: 'Sarah Miller',
      userImage: 'https://picsum.photos/seed/user2/100/100',
      rating: 4.0,
      comment:
          'Great headphones for the price. Comfortable for long listening sessions. Only minor issue is the case could be more protective.',
      date: '1 month ago',
      helpful: ['u1'],
      images: [],
    ),
    DummyReview(
      id: 'r3',
      userId: 'u3',
      userName: 'Michael Chen',
      userImage: 'https://picsum.photos/seed/user3/100/100',
      rating: 4.5,
      comment:
          'Bought these for gaming and they work perfectly. Mic quality is clear and the sound positioning is excellent for FPS games.',
      date: '3 months ago',
      helpful: [],
      images: ['https://picsum.photos/seed/review3/200/200'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Online Shop"),
      drawer: const AppDrawer(),

      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(background: _buildProductGallery()),
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: Colors.black),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: product.isFavorite ? Colors.red : Colors.black,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          // Product Details Content
          SliverList(
            delegate: SliverChildListDelegate([
              _buildProductInfo(),
              _buildVendorInfo(),
              _buildColorOptions(),
              _buildSizeOptions(),
              _buildDescription(),
              _buildReviewsSection(),
              const SizedBox(height: 100), // Space for bottom button
            ]),
          ),
        ],
      ),
      // Bottom Action Bar
      bottomSheet: _buildBottomActionBar(),
    );
  }

  Widget _buildProductGallery() {
    return Stack(
      children: [
        // Main Product Image
        Container(
          color: Colors.grey.shade100,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.photo, size: 100, color: Colors.grey),
              );
            },
          ),
        ),
        // Image Gallery Indicators
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(product.galleryImages.length, (index) {
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == 0
                      ? Colors.blue
                      : Colors.white.withOpacity(0.6),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Name
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          // Rating and Sold Count
          Row(
            children: [
              // Rating
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Text(
                      product.rating.toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, size: 16, color: Colors.green),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Review Count
              Text(
                '${product.reviewCount} Reviews',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 12),
              // Sold Count
              Text(
                '${product.soldCount} Sold',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Price Section
          Row(
            children: [
              // Current Price
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              // Original Price
              Text(
                '\$${product.originalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(width: 12),
              // Discount Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${((product.originalPrice - product.price) / product.originalPrice * 100).toInt()}% OFF',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Stock Status
          Row(
            children: [
              Icon(
                product.inStock ? Icons.check_circle : Icons.error,
                size: 16,
                color: product.inStock ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                product.inStock
                    ? 'In Stock (${product.stockQuantity} left)'
                    : 'Out of Stock',
                style: TextStyle(
                  color: product.inStock ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVendorInfo() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Vendor Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.store, color: Colors.blue, size: 28),
              ),
              const SizedBox(width: 16),
              // Vendor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.vendorName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          product.vendorRating,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Top Rated Seller',
                          style: TextStyle(
                            color: Colors.green.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Visit Store Button
              TextButton(onPressed: () {}, child: const Text('Visit Store')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorOptions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Color',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: product.colors.length,
              itemBuilder: (context, index) {
                final color = product.colors[index];
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(
                    right: index == product.colors.length - 1 ? 0 : 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: index == 0 ? Colors.blue : Colors.grey.shade300,
                      width: index == 0 ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      color,
                      style: TextStyle(
                        fontWeight: index == 0
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeOptions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Size',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: product.sizes.map((size) {
              final isSelected = size == 'Standard';
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.shade50 : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    color: isSelected ? Colors.blue : Colors.grey.shade700,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Text(
            product.longDescription,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: product.tags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tag,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviews Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Customer Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All (${product.reviewCount})',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Overall Rating
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Overall Rating Number
                  Column(
                    children: [
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      RatingBarWidget(rating: product.rating, size: 20),
                      const SizedBox(height: 4),
                      Text(
                        '${product.reviewCount} reviews',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  // Rating Breakdown
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRatingProgress(5, 65),
                        _buildRatingProgress(4, 20),
                        _buildRatingProgress(3, 10),
                        _buildRatingProgress(2, 3),
                        _buildRatingProgress(1, 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Reviews List
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return ReviewCard(review: reviews[index], onHelpfulTap: () {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRatingProgress(int stars, int percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text('$stars', style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          const Icon(Icons.star, size: 16, color: Colors.amber),
          const SizedBox(width: 12),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade200,
              color: Colors.amber,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '$percentage%',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(): BorderSide(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Cart Button
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart_outlined),
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(width: 12),
          // Buy Now Button
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Add to Cart Button
          Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ====================
// MAIN APP
// ====================

// class ECommerceApp extends StatelessWidget {
//   const ECommerceApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ShopEasy',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.blue,
//           brightness: Brightness.light,
//         ),
//         useMaterial3: true,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.white.withOpacity(0.0),
//           elevation: 0,
//           iconTheme: const IconThemeData(color: Colors.black),
//         ),
//         // cardTheme: CardTheme(
//         //   elevation: 1,
//         //   shape: RoundedRectangleBorder(
//         //     borderRadius: BorderRadius.circular(12),
//         //   ),
//         //   surfaceTintColor: Colors.white,
//         // ),
//       ),
//       home: ProductDetailsScreen(),
//     );
//   }
// }
