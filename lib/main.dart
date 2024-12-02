import 'package:flutter/material.dart';
void main() => runApp(const PrimeiroApp());
class PrimeiroApp extends StatelessWidget {
  const PrimeiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Oi Flutter',
        home: Home()
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}