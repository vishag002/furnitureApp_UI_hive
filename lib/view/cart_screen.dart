// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping_cart_hive/model/furniture.dart';

class CartScreen extends StatefulWidget {
  final List<Furniture> cartList;
  const CartScreen({Key? key, required this.cartList}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //hive reference
  late Box _cartBox;
  //
  late List<Furniture> _cartList;
  //
  @override
  void initState() {
    super.initState();
    _cartBox = Hive.box('cartBox');
    _loadCartList();
    //_cartList = widget.cartList;
  }

  //
  void _loadCartList() {
    final cartMaps =
        _cartBox.get('carList', defaultValue: <Map<String, dynamic>>[]);
    _cartList =
        cartMaps.map<Furniture>((map) => Furniture.fromMap(map)).toList();
  }

  //_Save cart List
  void _saveCartList() {
    final cartMaps = _cartList.map((item) => item.toMap()).toList();
    _cartBox.put('cartList', cartMaps);
  }

  //
//item add
  void add(Furniture item) {
    setState(() {
      item.quantity++;
    });
    _saveCartList();
  }

  //item remove

  void remove(Furniture item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        _cartList.remove(item);
      }
    });
    _saveCartList();
  }

  //total amount
  double get totalPrice {
    double total = 0;
    for (var item in _cartList) {
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
              setState(() {
                Navigator.pop(context);
              });
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
      body: ListView.builder(
        addAutomaticKeepAlives: true,
        itemCount: _cartList.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        itemBuilder: (context, index) => Padding(
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
                        _cartList[index].imagrurl,
                        fit: BoxFit.fill,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Container(
                      width: 190,
                      //  color: Colors.amber,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                _cartList[index].title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("\$${_cartList[index].price}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900)),
                                Container(
                                  height: 40,
                                  //width: 104,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white54),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () =>
                                              remove(_cartList[index]),
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.orange[600],
                                          )),
                                      Text(_cartList[index].quantity.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      IconButton(
                                          onPressed: () =>
                                              add(_cartList[index]),
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
        ),
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
