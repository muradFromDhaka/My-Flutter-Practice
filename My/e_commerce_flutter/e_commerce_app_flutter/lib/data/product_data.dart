import '../models/product.dart';

const List<Product> products = [
  Product(
    id: '1',
    name: 'Wireless Headphones',
    description: 'Noise cancelling headphones',
    price: 129.99,
    imageUrl: 'https://picsum.photos/400',
    rating: 4.5,
    reviewCount: 120,
    vendorName: 'AudioTech',
  ),
  Product(
    id: '2',
    name: 'Smart Watch',
    description: 'Fitness tracker',
    price: 249.99,
    imageUrl: 'https://picsum.photos/401',
    rating: 4.7,
    reviewCount: 80,
    vendorName: 'TechGear',
  ),
];
