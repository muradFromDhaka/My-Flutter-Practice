class Order {
  int id;
  int userId;
  double totalAmount;
  String status;
  String deliveryAddress;
  DateTime orderDate;

  Order({
    required this.id,
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.orderDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'total_amount': totalAmount,
      'status': status,
      'delivery_address': deliveryAddress,
      'order_date': orderDate.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['user_id'],
      totalAmount: map['total_amount'] is int 
          ? map['total_amount'].toDouble() 
          : map['total_amount'],
      status: map['status'],
      deliveryAddress: map['delivery_address'],
      orderDate: DateTime.parse(map['order_date'] ?? DateTime.now().toIso8601String()),
    );
  }

  String get formattedDate {
    return '${orderDate.day}/${orderDate.month}/${orderDate.year}';
  }
}