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
              return ExpansionTile(title: Text(flowerList[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                children: flowerList[index].name == "Legend" ? buildLegendChild(flowerList[index].combinations) : buildTextChild(flowerList[index].combinations),
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
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Text(val.combination, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),)
                  
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  SizedBox(width: 20,),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(val.imageUrl1),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 20,),
                  Text("+", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(width: 20,),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(val.imageUrl2),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 20,),
                  Text("=", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(width: 20,),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(val.imageUrl3),
                    backgroundColor: Colors.transparent,
                  )
                ],
              )
            ],
          ),
        )
      );
    });
    return widgets;
  }
  List<Widget> buildImageChild(String url) {
    List<Widget> widgets = new List<Widget>();

      widgets.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(image: AssetImage("assets/$url"),),
          )
      );

    return widgets;
  }

  List<Widget> buildLegendChild(List<Combination> combinations) {
    List<Widget> widgets = new List<Widget>();
    combinations.forEach((val) {
      widgets.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(val.combination),
          )
      );
    });

    return widgets;
  }
}
