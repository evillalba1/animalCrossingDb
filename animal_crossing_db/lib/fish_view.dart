import 'package:flutter/material.dart';

class FishesPage extends StatefulWidget {
  @override
  _FishesPageState createState() => _FishesPageState();
}

class _FishesPageState extends State<FishesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fishes"),),
      body: Text("Fishes"),
    );
  }
}
