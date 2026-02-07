import 'package:my_first_project/api_ex/models/product.dart';
import 'package:my_first_project/api_ex/services/product_api.dart';
import 'package:my_first_project/api_ex/ui/product_form_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart'; // make sure path is correct

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  
  late Future<List<Product>> products;
  
  final api = ProductApiService();

  @override
  void initState() {
    super.initState();
    products = api.getAllProducts();
  }

  void _logout() async {
    await api.logout(); // clear token
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false, // remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final created = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProductFormPage()),
              );

              if (created == true) {
                setState(() {
                  products = api.getAllProducts();
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) {
              final p = data[i];
              return Card(
                child: ListTile(
                  leading: Image.network(
                    p.imageUrl ?? '',
                    width: 50,
                    errorBuilder: (_, _, _) => const Icon(Icons.image),
                  ),
                  title: Text(p.name),
                  subtitle: Text("${p.category} • \$${p.price}"),
                  trailing: Icon(
                    Icons.star,
                    color: (p.rating ?? 0) >= 4 ? Colors.amber : Colors.grey,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
