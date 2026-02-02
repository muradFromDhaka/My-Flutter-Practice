import 'package:flutter/material.dart';

class CategoryListPage extends StatelessWidget {
  CategoryListPage({super.key});

  final List<Category> categories = [
    Category(name: "Electronics", image: "assets/car2.jpg"),
    Category(name: "Fashion", image: "assets/car4.jpg"),
    Category(name: "Shoes", image: "assets/categories/car6.jpg"),
    Category(name: "Groceries", image: "assets/categories/grocery.png"),
    Category(name: "Books", image: "assets/categories/books.png"),
    Category(name: "Sports", image: "assets/categories/sports.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.99,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return CategoryCard(category: category);
          },
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("${category.name} clicked")));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(category.image, height: 70, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(
              category.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class Category {
  final String name;
  final String image;

  Category({required this.name, required this.image});
}
