
import 'dart:convert';

CartsListModel cartsListModelFromJson(String str) => CartsListModel.fromJson(json.decode(str));

String cartsListModelToJson(CartsListModel data) => json.encode(data.toJson());

class CartsListModel {
  int? id;
  int? userId;
  List<Product>? products;

  CartsListModel({
    this.id,
    this.userId,
    this.products,
  });

  factory CartsListModel.fromJson(Map<String, dynamic> json) => CartsListModel(
    id: json["id"],
    userId: json["userId"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: json["category"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
  };
}
