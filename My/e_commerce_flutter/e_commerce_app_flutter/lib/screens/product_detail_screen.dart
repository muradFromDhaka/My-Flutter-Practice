import 'package:e_commerce_app_flutter/database/database_helper.dart';
import 'package:e_commerce_app_flutter/models/product.dart';
import 'package:e_commerce_app_flutter/models/review.dart';
import 'package:e_commerce_app_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final User user;
  final Product product;

  ProductDetailScreen({required this.user, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  List<Review> _reviews = [];
  bool _isLoading = false;
  bool _addingToCart = false;
  TextEditingController _reviewController = TextEditingController();
  int _rating = 5;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    setState(() => _isLoading = true);
    final dbHelper = DatabaseHelper();
    final reviews = await dbHelper.getProductReviews(widget.product.id);
    setState(() {
      _reviews = reviews;
      _isLoading = false;
    });
  }

  Future<void> _addToCart() async {
    setState(() => _addingToCart = true);

    final dbHelper = DatabaseHelper();
    try {
      await dbHelper.addToCart(widget.user.id, widget.product.id, _quantity);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to cart successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add to cart: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => _addingToCart = false);
  }

  Future<void> _submitReview() async {
    if (_reviewController.text.isEmpty) return;

    final review = Review(
      id: 0,
      userId: widget.user.id,
      productId: widget.product.id,
      rating: _rating,
      comment: _reviewController.text,
      createdAt: DateTime.now(),
      userName: widget.user.name,
    );

    final dbHelper = DatabaseHelper();
    await dbHelper.addReview(review);

    _reviewController.clear();
    _loadReviews();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Review submitted!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            // In cart icon onPressed, change to:
            onPressed: () {
              Navigator.pushNamed(context, '/cart', arguments: widget.user);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey[200],
              child: Center(
                child: Icon(
                  Icons.shopping_bag,
                  size: 100,
                  color: Colors.blueGrey,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),

                  // Rating and Stock
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text('${widget.product.rating.toStringAsFixed(1)}'),
                      SizedBox(width: 16),
                      Icon(Icons.inventory, color: Colors.blue, size: 20),
                      SizedBox(width: 4),
                      Text(
                        widget.product.stock > 0
                            ? 'In Stock (${widget.product.stock})'
                            : 'Out of Stock',
                        style: TextStyle(
                          color: widget.product.stock > 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Description
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),

                  SizedBox(height: 24),

                  // Quantity Selector
                  Text(
                    'Quantity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _quantity > 1
                            ? () => setState(() => _quantity--)
                            : null,
                      ),
                      Container(
                        width: 60,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _quantity.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _quantity < widget.product.stock
                            ? () => setState(() => _quantity++)
                            : null,
                      ),
                      Spacer(),
                      Text(
                        'Total: \$${(widget.product.price * _quantity).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: widget.product.stock > 0 && !_addingToCart
                          ? _addToCart
                          : null,
                      icon: _addingToCart
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Icon(Icons.shopping_cart),
                      label: _addingToCart
                          ? Text('Adding...')
                          : Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 32),

                  // Reviews Section
                  Text(
                    'Reviews',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  // Add Review
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add Your Review',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          // Rating Stars
                          Row(
                            children: List.generate(5, (index) {
                              return IconButton(
                                icon: Icon(
                                  index < _rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _rating = index + 1;
                                  });
                                },
                              );
                            }),
                          ),
                          TextField(
                            controller: _reviewController,
                            decoration: InputDecoration(
                              hintText: 'Write your review...',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: _submitReview,
                              child: Text('Submit Review'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Reviews List
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _reviews.isEmpty
                      ? Center(
                          child: Text(
                            'No reviews yet',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _reviews.length,
                          itemBuilder: (context, index) {
                            final review = _reviews[index];
                            return Card(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          review.userName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: List.generate(5, (
                                            starIndex,
                                          ) {
                                            return Icon(
                                              starIndex < review.rating
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              color: Colors.amber,
                                              size: 16,
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(review.comment),
                                    SizedBox(height: 8),
                                    Text(
                                      review.createdAt.toString().split(' ')[0],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
