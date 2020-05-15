import 'package:flutter/material.dart';

class InsectsPage extends StatefulWidget {
  @override
  _InsectsPageState createState() => _InsectsPageState();
}

class _InsectsPageState extends State<InsectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insects"),),
      body: Text("Insects"),
    );
  }
}
