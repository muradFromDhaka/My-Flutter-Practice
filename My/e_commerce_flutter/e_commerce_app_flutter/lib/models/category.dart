class Category {
  final int? id;
  final String name;
  final String imageUrl;

  final Category? parent;
  final List<Category> subCategories;

  Category({
    this.id,
    required this.name,
    required this.imageUrl,
    this.parent,
    List<Category>? subCategories,
  }) : subCategories = subCategories ?? [];

  /// JSON → Category
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      parent:
          json['parent'] != null ? Category.fromJson(json['parent']) : null,
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
              .map((e) => Category.fromJson(e))
              .toList()
          : [],
    );
  }

  /// Category → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'parent': parent?.toJson(),
      'subCategories': subCategories.map((e) => e.toJson()).toList(),
    };
  }
}

