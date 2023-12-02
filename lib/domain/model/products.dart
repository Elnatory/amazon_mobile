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
  int? qty;
  bool? isFavourite;

  final String? brandId;
  final String? brandImage;
  final String? brandName;
  final String? brandSlug;

  final String? catId;
  final String? catImage;
  final String? catName;
  final String? catSlug;

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
    required this.catId,
    required this.catImage,
    required this.catName,
    required this.catSlug,
    required this.qty,
    required this.isFavourite,
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
      catId: json['category']?['_id'] as String?,
      catImage: json['category']?['image'] as String?,
      catName: json['category']?['name'] as String?,
      catSlug: json['category']?['slug'] as String?,
      qty: json['qty'],
      isFavourite: json['isFavourite'],
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
      },
      'category': {
        '_id': catId,
        'image': catImage,
        'name': catName,
        'slug': catSlug,
      },
      'qty': qty,
      'isFavourite': isFavourite,
    };
  }

  @override
  Product copyWith({
    int? qty,
  }) =>
      Product(
        createdAt: createdAt ,
        description: description ,
        id: id ,
        imageCover: imageCover ,
        images: images ,
        price: price ,
        priceAfterDiscount: priceAfterDiscount ,
        quantity: quantity ,
        ratingsAverage: ratingsAverage ,
        ratingsQuantity: ratingsQuantity ,
        slug: slug ,
        sold: sold ,
        title: title ,
        updatedAt: updatedAt ,
        brandId: brandId ,
        brandImage: brandImage ,
        brandName: brandName ,
        brandSlug: brandSlug,
        catId: catId ,
        catImage: catImage ,
        catName: catName ,
        catSlug: catSlug,
        qty: qty ?? this.qty,
        isFavourite: isFavourite,
      );




      factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      createdAt: map['createdAt'],
      description: map['description'],
      id: map['id'],
      imageCover: map['imageCover'],
      images: (map['images'] as List<dynamic>?)?.cast<String>(),
      price: map['price'],
      priceAfterDiscount: map['priceAfterDiscount'],
      quantity: map['quantity'],
      ratingsAverage: map['ratingsAverage'],
      ratingsQuantity: map['ratingsQuantity'],
      slug: map['slug'],
      sold: map['sold'],
      title: map['title'],
      updatedAt: map['updatedAt'],
      brandId: map['brandId'],
      brandImage: map['brandImage'],
      brandName: map['brandName'],
      brandSlug: map['brandSlug'],
      catId: map['catId'],
      catImage: map['catImage'],
      catName: map['catName'],
      catSlug: map['catSlug'],
      qty: map['qty'],
      isFavourite: map['isFavourite'],
    );
  }
}
