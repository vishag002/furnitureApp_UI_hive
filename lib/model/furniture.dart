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
}
