class CartItem {
  int id;
  int userId;
  int productId;
  int quantity;
  DateTime addedAt;
  String productName;
  double price;
  String? productImageUrl;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    required this.addedAt,
    required this.productName,
    required this.price,
    this.productImageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'added_at': addedAt.toIso8601String(),
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      userId: map['user_id'],
      productId: map['product_id'],
      quantity: map['quantity'],
      addedAt: DateTime.parse(map['added_at'] ?? DateTime.now().toIso8601String()),
      productName: map['name'],
      price: map['price'] is int ? map['price'].toDouble() : map['price'],
      productImageUrl: map['image_url'],
    );
  }

  double get totalPrice => price * quantity;
}