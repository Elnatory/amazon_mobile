class Product {
  final String? createdAt;
  final String? description;
  final String? id;
  final String? imageCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? quantity;
  final double? ratingsAverage;
  final int? ratingsQuantity;
  final String? slug;
  final int? sold;
  final String? title;
  final String? updatedAt;

  final String? brandId;
  final String? brandImage;
  final String? brandName;
  final String? brandSlug;

  Product({
    required this.createdAt,
    required this.description,
    required this.id,
    required this.imageCover,
    required this.images,
    required this.price,
    required this.priceAfterDiscount,
    required this.quantity,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.slug,
    required this.sold,
    required this.title,
    required this.updatedAt,
    required this.brandId,
    required this.brandImage,
    required this.brandName,
    required this.brandSlug,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      createdAt: json['createdAt'] as String?,
      description: json['description'] as String?,
      id: json['id'] as String?,
      imageCover: json['imageCover'] as String?,
      images: (json['images'] as List<dynamic>?)?.cast<String>(),
      price: _parseNullableInt(json['price']),
      priceAfterDiscount: _parseNullableInt(json['priceAfterDiscount']),
      quantity: _parseNullableInt(json['quantity']),
      ratingsAverage: _parseNullableDouble(json['ratingsAverage']),
      ratingsQuantity: _parseNullableInt(json['ratingsQuantity']),
      slug: json['slug'] as String?,
      sold: _parseNullableInt(json['sold']),
      title: json['title'] as String?,
      updatedAt: json['updatedAt'] as String?,
      brandId: json['brand']?['_id'] as String?,
      brandImage: json['brand']?['image'] as String?,
      brandName: json['brand']?['name'] as String?,
      brandSlug: json['brand']?['slug'] as String?,
    );
  }

  static int? _parseNullableInt(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static double? _parseNullableDouble(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'description': description,
      'id': id,
      'imageCover': imageCover,
      'images': images,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'quantity': quantity,
      'ratingsAverage': ratingsAverage,
      'ratingsQuantity': ratingsQuantity,
      'slug': slug,
      'sold': sold,
      'title': title,
      'updatedAt': updatedAt,
      'brand': {
        '_id': brandId,
        'image': brandImage,
        'name': brandName,
        'slug': brandSlug,
      }
    };
  }
}
