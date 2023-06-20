import 'package:flutter/material.dart';
import './pages/landing_page.dart';
void main() {
  // runApp(const LandingPage());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.lightBlue),
      home: const LandingPage(),
      routes: {
        // HomePage.routeName: (ctx) => const HomePage(),
        LandingPage.routeName: (ctx) => const LandingPage(),
      },
    );
  }
}