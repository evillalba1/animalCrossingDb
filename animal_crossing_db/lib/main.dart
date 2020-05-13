import 'package:flutter/material.dart';
import 'package:animalcrossingdb/object_class.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatelessWidget {
  FossilTbl tbl = new FossilTbl();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(tbl.table),),
    );
  }
}