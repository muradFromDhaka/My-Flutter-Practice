class Product {
  int id;
  String name;
  String description;
  double price;
  int categoryId;
  String? imageUrl;
  int stock;
  double rating;
  DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    this.imageUrl,
    required this.stock,
    required this.rating,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'image_url': imageUrl,
      'stock': stock,
      'rating': rating,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'] is int ? map['price'].toDouble() : map['price'],
      categoryId: map['category_id'],
      imageUrl: map['image_url'],
      stock: map['stock'],
      rating: map['rating'] is int ? map['rating'].toDouble() : map['rating'],
      createdAt: DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}