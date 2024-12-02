import 'package:flutter/material.dart';
void main() => runApp(PrimeiroApp());
class PrimeiroApp extends StatelessWidget {
  const PrimeiroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.cyan,
        hintColor: Colors.blue,
      ),
        home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Lista de Contatos",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
               )
            ],
        )
      ],
      ),
      body: Column(
        children: <Widget>[
          TopBar(),
        ],
      ),
    );
  }
}
