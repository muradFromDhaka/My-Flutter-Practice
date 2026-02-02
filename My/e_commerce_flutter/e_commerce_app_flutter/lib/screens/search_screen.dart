import 'package:e_commerce_app_flutter/database/database_helper.dart';
import 'package:e_commerce_app_flutter/models/product.dart';
import 'package:e_commerce_app_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'product_detail_screen.dart';
import '../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  final User user;

  SearchScreen({required this.user});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  // Filter variables
  double _minPrice = 0;
  double _maxPrice = 1000;
  double _minRating = 0;

  @override
  void initState() {
    super.initState();
    _loadAllProducts();
  }

  Future<void> _loadAllProducts() async {
    setState(() => _isLoading = true);
    final dbHelper = DatabaseHelper();
    final products = await dbHelper.getProducts();
    setState(() {
      _products = products;
      _filteredProducts = products;
      _isLoading = false;
    });
  }

  void _searchProducts(String query) {
    setState(() {
      _filteredProducts = _products.where((product) {
        final matchesSearch =
            query.isEmpty ||
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.description.toLowerCase().contains(query.toLowerCase());

        final matchesPrice =
            product.price >= _minPrice && product.price <= _maxPrice;
        final matchesRating = product.rating >= _minRating;

        return matchesSearch && matchesPrice && matchesRating;
      }).toList();
    });
  }

  void _applyFilters() {
    _searchProducts(_searchController.text);
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filter Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  // Price Range
                  Text(
                    'Price Range: \$${_minPrice.toInt()} - \$${_maxPrice.toInt()}',
                  ),
                  RangeSlider(
                    values: RangeValues(_minPrice, _maxPrice),
                    min: 0,
                    max: 1000,
                    divisions: 10,
                    labels: RangeLabels(
                      '\$${_minPrice.toInt()}',
                      '\$${_maxPrice.toInt()}',
                    ),
                    onChanged: (values) {
                      setState(() {
                        _minPrice = values.start;
                        _maxPrice = values.end;
                      });
                    },
                  ),

                  SizedBox(height: 20),

                  // Minimum Rating
                  Text('Minimum Rating: ${_minRating.toStringAsFixed(1)}'),
                  Slider(
                    value: _minRating,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: _minRating.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        _minRating = value;
                      });
                    },
                  ),

                  SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _minPrice = 0;
                              _maxPrice = 1000;
                              _minRating = 0;
                            });
                          },
                          child: Text('Reset Filters'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _applyFilters();
                          },
                          child: Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Products')),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_searchController.text.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _searchProducts('');
                        },
                      ),
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: _showFilterDialog,
                    ),
                  ],
                ),
              ),
              onChanged: _searchProducts,
            ),
          ),

          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredProducts.length} products found',
                  style: TextStyle(color: Colors.grey),
                ),
                if (_minPrice > 0 || _maxPrice < 1000 || _minRating > 0)
                  Chip(
                    label: Text('Filters Active'),
                    backgroundColor: Colors.blue[50],
                    deleteIcon: Icon(Icons.close, size: 16),
                    onDeleted: () {
                      setState(() {
                        _minPrice = 0;
                        _maxPrice = 1000;
                        _minRating = 0;
                      });
                      _applyFilters();
                    },
                  ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Products List
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 80, color: Colors.grey),
                        SizedBox(height: 20),
                        Text(
                          'No products found',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        if (_searchController.text.isNotEmpty ||
                            _minPrice > 0 ||
                            _maxPrice < 1000 ||
                            _minRating > 0)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Try changing your search or filters',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: _filteredProducts[index],
                        // In product card onTap, change to:
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/product-detail',
                            arguments: {
                              'user': widget.user,
                              'product': _filteredProducts[index],
                            },
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
