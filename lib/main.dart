import 'package:flutter/material.dart';
import 'package:sixteenoct/splashscreen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Splashscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
