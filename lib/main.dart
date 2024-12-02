import 'package:flutter/material.dart';
void main() => runApp(PrimeiroApp());
class PrimeiroApp extends StatelessWidget {
  const PrimeiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Oi Flutter',
        home: Scaffold(
        appBar: AppBar(
        title: const Text('Oi Flutter'),
    ),
    body: const Center( child: Text('Hello World'),
    ),
        ),
    );
  }
}