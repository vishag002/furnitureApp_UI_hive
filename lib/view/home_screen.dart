// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping_cart_hive/model/furniture.dart';
import 'package:shopping_cart_hive/view/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //hive
  late Box<Map> cartBox;
  late Box<Map> furnitureBox;
  // List<Furniture> myList = [];
  //

  //
  List<Furniture> cartList = [];

  //list
  List<Furniture> myList = [
    Furniture(
        title: "Single chair yhomebaby",
        imagrurl:
            "https://th.bing.com/th/id/R.1762b01444917ccd99451d21849244fb?rik=Si6GjuFKk5LjQw&riu=http%3a%2f%2fwww.yhomebaby.com%2fcdn%2fshop%2fproducts%2f7DE0D71B7688F0B9943856E94E5711F7.jpg%3fv%3d1646119422&ehk=USzL0%2bhx%2bGFFsSjyKpbk8JZIZq%2b4hr31SCHV006AjPo%3d&risl=&pid=ImgRaw&r=0",
        price: 500),
    Furniture(
        title: "Modway Dining Armchair",
        imagrurl:
            "https://slimages.macysassets.com/is/image/MCY/products/7/optimized/10247387_fpx.tif?op_sharpen=1&wid=700&hei=855&fit=fit,1",
        price: 299),
    Furniture(
        title: "Grey Carver Dining Chair",
        imagrurl:
            "https://img.zcdn.com.au/lf/8/hash/39258/19720789/4/custom_image.jpg",
        price: 299),
    Furniture(
        title: "Pyramid Dining Armchair",
        imagrurl:
            "https://i.pinimg.com/originals/5d/3f/4b/5d3f4beddcc6d66f6d3791641380dbae.jpg",
        price: 299),
    //add to cart
  ];
  //
  void toggleCart(Furniture item) {
    setState(() {
      if (cartList.contains(item)) {
        cartList.remove(item);
      } else {
        cartList.add(item);
      }
    });
  }

//add to cart
  void addToCart(Furniture furniture) {
    setState(() {
      cartList.add(furniture);
    });
  }

  /* ///hive
  @override
  void initState() {
    super.initState();
    cartBox = Hive.box<Map>('cartBox');
    furnitureBox = Hive.box<Map>('furnitureBox');
    loadFurnitureList();
    loadCartList();
  } */
  //load furniture list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Furniture Shop",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 24),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartList: cartList),
                    ));
              },
              icon: Padding(
                padding: const EdgeInsets.only(top: 15, right: 10),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                  size: 30,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      "data",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: myList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 330,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => Container(
                  //  color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 250,
                            width: double.maxFinite,
                            color: Colors.grey,
                            child: Image.network(
                              myList[index].imagrurl,
                              fit: BoxFit.cover,
                              scale: 1.0,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton.outlined(
                              icon: Icon(
                                cartList.contains(myList[index])
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.black,
                                size: 30,
                              ),
                              onPressed: () {
                                toggleCart(myList[index]);
                                //  addToCart(myList[index]);
                                // Add to cart functionality
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          myList[index].title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 8),
                        child: Row(
                          children: [
                            Text(
                              "\$",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                myList[index].price.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
