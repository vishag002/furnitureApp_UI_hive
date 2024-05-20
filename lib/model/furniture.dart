import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Furniture extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String imagrurl;

  @HiveField(2)
  double price;

  @HiveField(3)
  int quantity;

  Furniture({
    required this.title,
    required this.imagrurl,
    required this.price,
    this.quantity = 1,
  });

  // Convert a Furniture object to a map.
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imagrurl': imagrurl,
      'price': price,
      'quantity': quantity,
    };
  }

  // Convert a map to a Furniture object.
  factory Furniture.fromMap(Map<String, dynamic> map) {
    return Furniture(
      title: map['title'],
      imagrurl: map['imagrurl'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
