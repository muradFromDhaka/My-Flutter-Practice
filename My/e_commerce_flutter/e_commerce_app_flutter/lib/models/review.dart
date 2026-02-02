class Review {
  int id;
  int userId;
  int productId;
  int rating;
  String comment;
  DateTime createdAt;
  String userName;

  Review({
    required this.id,
    required this.userId,
    required this.productId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'],
      userId: map['user_id'],
      productId: map['product_id'],
      rating: map['rating'],
      comment: map['comment'],
      createdAt: DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
      userName: map['user_name'],
    );
  }
}