import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:imovie/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'imovie',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFf3f2f6),
          primaryColor: const Color(0xFF343156),
          textTheme: const TextTheme(
              headline1: TextStyle(
                  color: Color(0xFF343156),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              headline2: TextStyle(
                  color: Color(0xFF343156),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              headline3: TextStyle(color: Color(0xFF343156), fontSize: 16))),
      home: const HomePage(),
    );
  }
}
