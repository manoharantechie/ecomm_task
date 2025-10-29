const String prdTable = 'products';

class ProductFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, title, price, description, category,image,rate,count
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String title = 'title';
  static const String price = 'price';
  static const String description = 'description';
  static const String category = 'category';
  static const String image = 'image';
  static const String rate = 'rate';
  static const String count = 'count';

}

class ProductDetails {
  final int? id;
  final bool isImportant;
  final String title;
  final String price;
  final String description;
  final String category;
  final String image;
  final String rate;
  final String count;



  const ProductDetails({
    this.id,
    required this.isImportant,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rate,
    required this.count,


  });

  ProductDetails copy({
    int? id,
    bool? isImportant,
    String? title,
    String? price,
    String? description,
    String? category,
    String? image,
    String? rate,
    String? count,


  }) =>
      ProductDetails(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        rate: rate ?? this.rate,
        count: rate ?? this.count,


      );

  static ProductDetails fromJson(Map<String, Object?> json) => ProductDetails(
    id: json[ProductFields.id] as int?,
    isImportant: json[ProductFields.isImportant] == 1,
    title: json[ProductFields.title] as String,
    price: json[ProductFields.price] as String,
    description: json[ProductFields.description] as String,
    category: json[ProductFields.category] as String,
    image: json[ProductFields.image] as String,
    rate: json[ProductFields.rate] as String,
    count: json[ProductFields.count] as String,


  );

  Map<String, Object?> toJson() => {
    ProductFields.id: id,
    ProductFields.title: title,
    ProductFields.isImportant: isImportant ? 1 : 0,
    ProductFields.price: price,
    ProductFields.description: description,
    ProductFields.category: category,
    ProductFields.image: image,
    ProductFields.rate: rate,
    ProductFields.count: count,


  };
}