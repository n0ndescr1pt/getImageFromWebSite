import 'package:flutter/material.dart';
import 'package:test_app/pages/page1.dart';
import 'package:test_app/pages/page2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Page1(),
      routes: {
        '/page2': (context) => const Page2(),
      },
    );
  }
}

