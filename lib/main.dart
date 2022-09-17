import 'package:flutter/material.dart';
import 'package:unitconverter/pages/home_page.dart';
import 'package:unitconverter/settings/scroll_behavior.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      scrollBehavior: ScrollGlow(),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}
