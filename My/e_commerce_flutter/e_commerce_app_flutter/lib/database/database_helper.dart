import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import '../models/user.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import '../models/review.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ecommerce.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        phone TEXT,
        address TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Categories table
    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        image_url TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Products table
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        category_id INTEGER,
        image_url TEXT,
        stock INTEGER DEFAULT 0,
        rating REAL DEFAULT 0,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES categories(id)
      )
    ''');

    // Cart items table
    await db.execute('''
      CREATE TABLE cart_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity INTEGER DEFAULT 1,
        added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (product_id) REFERENCES products(id),
        UNIQUE(user_id, product_id)
      )
    ''');

    // Orders table
    await db.execute('''
      CREATE TABLE orders(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        total_amount REAL NOT NULL,
        status TEXT DEFAULT 'Pending',
        delivery_address TEXT,
        order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id)
      )
    ''');

    // Order items table
    await db.execute('''
      CREATE TABLE order_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        FOREIGN KEY (order_id) REFERENCES orders(id),
        FOREIGN KEY (product_id) REFERENCES products(id)
      )
    ''');

    // Reviews table
    await db.execute('''
      CREATE TABLE reviews(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        rating INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 5),
        comment TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (product_id) REFERENCES products(id)
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    // Insert sample user
    await db.insert('users', {
      'name': 'John Doe',
      'email': 'john@example.com',
      'password': 'john123',
      'phone': '01712345678',
      'address': '123 Main Street, Dhaka',
    });

    // Insert sample categories
    await db.insert('categories', {
      'name': 'Electronics',
      'image_url': 'assets/electronics.png',
    });
    await db.insert('categories', {
      'name': 'Fashion',
      'image_url': 'assets/fashion.png',
    });
    await db.insert('categories', {
      'name': 'Groceries',
      'image_url': 'assets/groceries.png',
    });

    // Insert sample products for Electronics
    await db.insert('products', {
      'name': 'Smartphone',
      'description': 'Latest smartphone with great features',
      'price': 699.99,
      'category_id': 1,
      'image_url': 'assets/smartphone.png',
      'stock': 50,
      'rating': 4.5,
    });
    
    await db.insert('products', {
      'name': 'Laptop',
      'description': 'High-performance laptop',
      'price': 1299.99,
      'category_id': 1,
      'image_url': 'assets/laptop.png',
      'stock': 30,
      'rating': 4.7,
    });

    await db.insert('products', {
      'name': 'Headphones',
      'description': 'Wireless noise-canceling headphones',
      'price': 199.99,
      'category_id': 1,
      'image_url': 'assets/headphones.png',
      'stock': 100,
      'rating': 4.3,
    });

    // Insert sample products for Fashion
    await db.insert('products', {
      'name': 'T-Shirt',
      'description': 'Cotton t-shirt',
      'price': 19.99,
      'category_id': 2,
      'image_url': 'assets/tshirt.png',
      'stock': 100,
      'rating': 4.2,
    });

    await db.insert('products', {
      'name': 'Jeans',
      'description': 'Blue denim jeans',
      'price': 49.99,
      'category_id': 2,
      'image_url': 'assets/jeans.png',
      'stock': 75,
      'rating': 4.4,
    });

    await db.insert('products', {
      'name': 'Sneakers',
      'description': 'Sports shoes',
      'price': 79.99,
      'category_id': 2,
      'image_url': 'assets/sneakers.png',
      'stock': 60,
      'rating': 4.6,
    });

    // Insert sample products for Groceries
    await db.insert('products', {
      'name': 'Apple',
      'description': 'Fresh red apples',
      'price': 2.99,
      'category_id': 3,
      'image_url': 'assets/apple.png',
      'stock': 200,
      'rating': 4.1,
    });

    await db.insert('products', {
      'name': 'Milk',
      'description': 'Fresh milk 1L',
      'price': 3.49,
      'category_id': 3,
      'image_url': 'assets/milk.png',
      'stock': 150,
      'rating': 4.0,
    });

    await db.insert('products', {
      'name': 'Bread',
      'description': 'Whole wheat bread',
      'price': 1.99,
      'category_id': 3,
      'image_url': 'assets/bread.png',
      'stock': 120,
      'rating': 4.2,
    });
  }

  // User operations
  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUserByEmail(String email) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateUser(User user) async {
    Database db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Category operations
  Future<List<Category>> getCategories() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) => Category.fromMap(maps[i]));
  }

  // Product operations
  Future<List<Product>> getProductsByCategory(int categoryId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'category_id = ?',
      whereArgs: [categoryId],
    );
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<Product?> getProductById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Product>> searchProducts(String query) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<List<Product>> getProducts() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  // Cart operations
  Future<int> addToCart(int userId, int productId, int quantity) async {
    Database db = await database;
    return await db.insert('cart_items', {
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
    });
  }

  Future<List<CartItem>> getCartItems(int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT ci.*, p.name, p.price, p.image_url 
      FROM cart_items ci 
      JOIN products p ON ci.product_id = p.id 
      WHERE ci.user_id = ?
    ''', [userId]);
    return List.generate(maps.length, (i) => CartItem.fromMap(maps[i]));
  }

  Future<int> updateCartQuantity(int cartItemId, int quantity) async {
    Database db = await database;
    return await db.update(
      'cart_items',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [cartItemId],
    );
  }

  Future<int> removeFromCart(int cartItemId) async {
    Database db = await database;
    return await db.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [cartItemId],
    );
  }

  Future<int> clearCart(int userId) async {
    Database db = await database;
    return await db.delete(
      'cart_items',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  // Order operations
  Future<int> createOrder(Order order, List<CartItem> items) async {
    Database db = await database;
    return await db.transaction((txn) async {
      // Create order
      int orderId = await txn.insert('orders', order.toMap());
      
      // Create order items
      for (var item in items) {
        await txn.insert('order_items', {
          'order_id': orderId,
          'product_id': item.productId,
          'quantity': item.quantity,
          'price': item.price,
        });
      }
      
      // Clear cart
      await txn.delete(
        'cart_items',
        where: 'user_id = ?',
        whereArgs: [order.userId],
      );
      
      return orderId;
    });
  }

  Future<List<Order>> getOrders(int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'orders',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'order_date DESC',
    );
    return List.generate(maps.length, (i) => Order.fromMap(maps[i]));
  }

  // Review operations
  Future<int> addReview(Review review) async {
    Database db = await database;
    return await db.insert('reviews', review.toMap());
  }

  Future<List<Review>> getProductReviews(int productId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT r.*, u.name as user_name 
      FROM reviews r 
      JOIN users u ON r.user_id = u.id 
      WHERE r.product_id = ?
      ORDER BY r.created_at DESC
    ''', [productId]);
    return List.generate(maps.length, (i) => Review.fromMap(maps[i]));
  }

  Future<double> getProductAverageRating(int productId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT AVG(rating) as avg_rating 
      FROM reviews 
      WHERE product_id = ?
    ''', [productId]);
    return (maps.first['avg_rating'] as num?)?.toDouble() ?? 0.0;
  }
}