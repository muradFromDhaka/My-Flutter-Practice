import 'package:flutter/material.dart';
import 'package:my_first_project/project/main.dart';
import 'package:my_first_project/project/page/categoryList.dart';
import 'package:my_first_project/project/page/productDetails.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Home"),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          Column(
            children: [
              // 🔍 Search
              Padding(
                padding: const EdgeInsets.only(left: 300, right: 300, top: 25),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Search products",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // 🖼 Hero Banner
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset("assets/hero.jpg", fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),

          // =====================
          // 📂 Categories Section
          // =====================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      CategoryItem(
                        icon: Icons.phone_android,
                        title: "Phones",
                        color: Colors.blue,
                      ),
                      CategoryItem(
                        icon: Icons.laptop,
                        title: "Laptops",
                        color: Colors.green,
                      ),
                      CategoryItem(
                        icon: Icons.watch,
                        title: "Watches",
                        color: Colors.orange,
                      ),
                      CategoryItem(
                        icon: Icons.headphones,
                        title: "Audio",
                        color: Colors.purple,
                      ),
                      CategoryItem(
                        icon: Icons.tv,
                        title: "Television",
                        color: Colors.red,
                      ),
                      CategoryItem(
                        icon: Icons.camera_alt,
                        title: "Cameras",
                        color: Colors.teal,
                      ),
                      CategoryItem(
                        icon: Icons.sports_esports,
                        title: "Gaming",
                        color: Colors.indigo,
                      ),
                      CategoryItem(
                        icon: Icons.kitchen,
                        title: "Appliances",
                        color: Colors.brown,
                      ),
                      CategoryItem(
                        icon: Icons.phone_android,
                        title: "Phones",
                        color: Colors.blue,
                      ),
                      CategoryItem(
                        icon: Icons.laptop,
                        title: "Laptops",
                        color: Colors.green,
                      ),
                      CategoryItem(
                        icon: Icons.watch,
                        title: "Watches",
                        color: Colors.orange,
                      ),
                      CategoryItem(
                        icon: Icons.headphones,
                        title: "Audio",
                        color: Colors.purple,
                      ),
                      CategoryItem(
                        icon: Icons.tv,
                        title: "Television",
                        color: Colors.red,
                      ),
                      CategoryItem(
                        icon: Icons.camera_alt,
                        title: "Cameras",
                        color: Colors.teal,
                      ),
                      CategoryItem(
                        icon: Icons.sports_esports,
                        title: "Gaming",
                        color: Colors.indigo,
                      ),
                      CategoryItem(
                        icon: Icons.kitchen,
                        title: "Appliances",
                        color: Colors.brown,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // =====================
                // 🛒 Products Section
                // =====================
                const Text(
                  "Products",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.9,
                  children: const [
                    ProductCard(
                      image: "assets/w2.jpg",
                      title: "Gaming Laptop",
                      price: "৳120,000",
                    ),
                    ProductCard(
                      image: "assets/laptop1.jpg",
                      title: "Office Laptop",
                      price: "৳85,000",
                    ),
                    ProductCard(
                      image: "assets/laptop2.jpg",
                      title: "Smart Phone",
                      price: "৳45,000",
                    ),
                    ProductCard(
                      image: "assets/laptop1.jpg",
                      title: "Smart Watch",
                      price: "৳12,000",
                    ),
                    ProductCard(
                      image: "assets/laptop2.jpg",
                      title: "Headphones",
                      price: "৳6,500",
                    ),
                    ProductCard(
                      image: "assets/w2.jpg",
                      title: "Bluetooth Speaker",
                      price: "৳8,000",
                    ),
                    ProductCard(
                      image: "assets/w5.jpg",
                      title: "Office Laptop",
                      price: "৳85,000",
                    ),
                    ProductCard(
                      image: "assets/watchHero.jpg",
                      title: "Smart Phone",
                      price: "৳45,000",
                    ),
                    ProductCard(
                      image: "assets/w5.jpg",
                      title: "Smart Watch",
                      price: "৳12,000",
                    ),
                    ProductCard(
                      image: "assets/w3.jpg",
                      title: "Headphones",
                      price: "৳6,500",
                    ),
                    ProductCard(
                      image: "assets/w2.jpg",
                      title: "Bluetooth Speaker",
                      price: "৳8,000",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
// =====================
// 📂 Category Widget
// =====================

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Navigate to CategoryListPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CategoryListPage()),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 120,
            height: 120,
            color: color,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 40),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//
// =====================
// 🛒 Product Card Widget
// =====================
class ProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;

  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ProductDetailsPage(image: image, title: title, price: price),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                image,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                price,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
