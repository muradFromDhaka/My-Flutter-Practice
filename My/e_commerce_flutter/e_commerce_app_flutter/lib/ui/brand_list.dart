import 'package:e_commerce_app_flutter/models/brand.dart';
import 'package:e_commerce_app_flutter/services/auth_service.dart';
import 'package:e_commerce_app_flutter/services/brand_service.dart';
import 'package:e_commerce_app_flutter/ui/brand_form.dart';
import 'package:flutter/material.dart';

import 'login_page.dart'; // make sure path is correct

class BrandListPage extends StatefulWidget {
  const BrandListPage({super.key});

  @override
  State<BrandListPage> createState() => _BrandListPageState();
}

class _BrandListPageState extends State<BrandListPage>
    with WidgetsBindingObserver {
  final api = BrandService();
  final auth = AuthService();

  late Future<List<Brand>> _brandsFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshBrands();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Refresh when app comes back to foreground
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshBrands();
    }
  }

  void _refreshBrands() {
    setState(() {
      _brandsFuture = api.getAllBrands();
    });
  }

  Future<void> _logout() async {
    await auth.logout();
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (_) => false,
    );
  }

  Future<void> _addBrand() async {
    final created = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const BrandFormPage()),
    );

    if (created == true) _refreshBrands();
  }

  Future<void> _editBrand(Brand brand) async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BrandFormPage(brand: brand)),
    );

    if (updated == true) _refreshBrands();
  }

  Future<void> _deleteBrand(Brand brand) async {
    await api.deleteBrand(brand.id!);
    _refreshBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brands"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshBrands,
          ),
          IconButton(icon: const Icon(Icons.add), onPressed: _addBrand),
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: FutureBuilder<List<Brand>>(
        future: _brandsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final brands = snapshot.data ?? [];

          if (brands.isEmpty) {
            return const Center(child: Text("No brands found"));
          }

          return RefreshIndicator(
            onRefresh: () async => _refreshBrands(),
            child: ListView.builder(
              itemCount: brands.length,
              itemBuilder: (_, i) {
                final p = brands[i];

                return Card(
                  child: ListTile(
                    leading: Image.network(
                     ("http://192.168.20.43:8080" + p.logoUrl) ?? '',
                      width: 50,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image),
                    ),
                    title: Text(p.name),
                    subtitle: Text("${p.description}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editBrand(p),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteBrand(p),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
