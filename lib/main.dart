import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'view/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('cartBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
