import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_cart_hive/model/furniture.dart';

class CartScreen extends StatefulWidget {
  final Box<Furniture> cartBox;
  const CartScreen({Key? key, required this.cartBox}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Box<Furniture> _cartBox;

  @override
  void initState() {
    super.initState();
    _cartBox = widget.cartBox;
  }

  void add(Furniture item) {
    setState(() {
      item.quantity++;
      _cartBox.put(item.title, item); // Save the updated item to Hive
    });
  }

  void remove(Furniture item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
        _cartBox.put(item.title, item); // Save the updated item to Hive
      } else {
        _cartBox.delete(item.title); // Remove the item from Hive
      }
    });
  }

  double get totalPrice {
    double total = 0;
    for (var item in _cartBox.values) {
      total += item.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            )),
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "My Cart",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24),
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: _cartBox.listenable(),
        builder: (context, Box<Furniture> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text("Cart is empty"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final item = box.getAt(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 149,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(31, 182, 124, 49),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                            ),
                            child: Image.network(
                              item!.imagrurl,
                              fit: BoxFit.fill,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 15),
                          child: Container(
                            width: 190,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      item.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("\$${item.price}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900)),
                                      Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white54),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () => remove(item),
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.orange[600],
                                                )),
                                            Text(item.quantity.toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            IconButton(
                                                onPressed: () => add(item),
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.orange[600],
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orange[300]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Total",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "\$${totalPrice}",
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
