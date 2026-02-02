import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const ProductDetailsPage({
    super.key,
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text(title), backgroundColor: Colors.deepPurple),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼 Product Image (Left)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    image,
                    width: 200,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 24),

                // 📄 Product Info (Right)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🏷 Title
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // 💰 Price
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ⭐ Rating
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 22),
                          Icon(Icons.star, color: Colors.amber, size: 22),
                          Icon(Icons.star, color: Colors.amber, size: 22),
                          Icon(Icons.star_half, color: Colors.amber, size: 22),
                          Icon(Icons.star_border, size: 22),
                          SizedBox(width: 8),
                          Text("(4.5)", style: TextStyle(fontSize: 16)),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // 📄 Description
                      const Text(
                        "Product Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "This is a high-quality product suitable for daily use. "
                        "It comes with premium materials, long durability and modern design.",
                        style: TextStyle(fontSize: 15),
                      ),

                      const SizedBox(height: 24),

                      // 🛒 Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text("Add to Cart"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 6,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.favorite_border),
                              color: Colors.red,
                              // iconSize: 28,
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
      ),
    );
  }
}
