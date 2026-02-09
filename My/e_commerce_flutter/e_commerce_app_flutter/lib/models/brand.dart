class Brand {
  int? id;
  String name;
  String description;
  String logoUrl;

  // Constructor
  Brand({
    this.id,
    required this.name,
    required this.description,
    required this.logoUrl,
  });

  // Convert Brand object to Map (for DB or API)
  Map<String, dynamic> toJson() {
    return {
      if(id != null) 'id': id,
      'name': name,
      'description': description,
      if(logoUrl.isNotEmpty) 'logoUrl': logoUrl,
    };
  }

  // Factory constructor to create Brand from Map (DB or API)
  factory Brand.fromJson(Map<String, dynamic> map) {
    return Brand(
      id: map['id'],
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
    );
  }
}

