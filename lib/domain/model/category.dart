class Category {
  late String id;
  late String createdAt;
  late String image;
  late String name;
  late String slug;
  late String updatedAt;

  Category({
    required this.id,
    required this.createdAt,
    required this.image,
    required this.name,
    required this.slug,
    required this.updatedAt,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['_id'],
      createdAt: map['createdAt'],
      image: map['image'],
      name: map['name'],
      slug: map['slug'],
      updatedAt: map['updatedAt'],
    );
  }
}