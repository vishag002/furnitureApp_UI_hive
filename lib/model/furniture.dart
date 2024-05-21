class Furniture {
  String title;
  String imagrurl;
  int price;
  int quantity;

  Furniture({
    required this.title,
    required this.imagrurl,
    required this.price,
    this.quantity = 1,
  });
  /////convert Furniture object into Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imagrurl': imagrurl,
      'price': price,
      'quantity': quantity
    };
  }

  ////covert a Map into Furniture Object
  factory Furniture.fromMap(Map<String, dynamic> map) {
    return Furniture(
      title: map['title'],
      imagrurl: map['imagrurl'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
