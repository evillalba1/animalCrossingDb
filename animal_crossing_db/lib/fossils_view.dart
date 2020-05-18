import 'package:flutter/material.dart';

import 'database_helper.dart';

class FossilPage extends StatefulWidget {
  @override
  _FossilPageState createState() => _FossilPageState();
}

class _FossilPageState extends State<FossilPage> {
  List<Map<String, dynamic>> fossils;

  fetchFossils() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll('fossils');
    if (queryRows.length == 0) {
      DatabaseHelper.instance.insertAllFossil();
      Future.delayed(const Duration(milliseconds: 2000), () {
        fetchFossils();
      });
    } else {
      setState(() {
        setState(() {
          debugPrint(queryRows.length.toString());
          fossils = queryRows;
        }); // Here you can write your code for open new view
      });
    }
  }

  Future fetchData() async {
    fetchFossils();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fossils"),
      ),
      body: fossils == null ? Center(child: CircularProgressIndicator(),) : 
      Stack(
        children: <Widget>[
          Container(
          //   decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage("assets/AnimalCrossingGrass.png"),
          //     fit: BoxFit.cover))
          ),
          ListView.builder(itemBuilder: (context, index) {
          return Card (
            child: Container(
              height: 130,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 200,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(fossils[index]['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        //Image.network(villagers[index]['imageUrl'], height: 100, width: 100,fit: BoxFit.fill,),
                      ],
                    ) ,
                  )
                ]
              )
            ),
          );
        },
        itemCount: fossils == null ? 0 : fossils.length,
        )],
      ) 
    );
  }
}
