import 'dart:ffi';

class Book {
  int id;
  String name;
  String image;
  final double price;  

  Book({required this.id, required this.name, required this.image, required this.price});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : double.tryParse('${json['price']}') ?? 0.0,
    );
  }
}