import 'dart:convert';

import 'package:animalcrossingdb/list_management.dart';
import 'package:animalcrossingdb/object_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlowerPage extends StatefulWidget {
  @override
  _FlowerPageState createState() => _FlowerPageState();
}

class _FlowerPageState extends State<FlowerPage> {
  List<Flower> flowerList = new List<Flower>();
  List flowerRawList;
  fetchFlowers() async {
    String flowersJson = await rootBundle.loadString('assets/flowers.json');
      setState(() {
          flowerList = mapFlowersList(flowersJson);
      });
  }

  Future fetchData() async {
    fetchFlowers();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flower Guide'),),
        body: flowerList == null ? Center(child: CircularProgressIndicator(),) :ListView.builder(
            itemCount: flowerList.length,
            itemBuilder: (context, index){
              return ExpansionTile(title: Text(flowerList[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                children: flowerList[index].imageUrl == "" ? buildTextChild(flowerList[index].combinations) : buildImageChild(flowerList[index].imageUrl),
              );
            }
        )
    );
  }

  List<Widget> buildTextChild(List<Combination> combinations) {
    List<Widget> widgets = new List<Widget>();
    combinations.forEach((val){
      widgets.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(val.combination),
        )
      );
    });
    return widgets;
  }
  List<Widget> buildImageChild(String Url) {
    List<Widget> widgets = new List<Widget>();

      widgets.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image: AssetImage("assets/$Url"),),
          )
      );

    return widgets;
  }
}
