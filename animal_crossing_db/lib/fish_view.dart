import 'package:flutter/material.dart';

import 'database_helper.dart';

class FishesPage extends StatefulWidget {
  @override
  _FishesPageState createState() => _FishesPageState();
}

class _FishesPageState extends State<FishesPage> {
  List<Map<String, dynamic>> fishes;

  fetchFishes() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll('fish');
    if (queryRows.length == 0) {
      DatabaseHelper.instance.insertAllFishes();
      Future.delayed(const Duration(milliseconds: 2000), () {
        fetchFishes();
      });
    } else {
      setState(() {
        setState(() {
          debugPrint(queryRows.length.toString());
          fishes = queryRows;
        }); // Here you can write your code for open new view
      });
    }
  }

  Future fetchData() async {
    fetchFishes();
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
      body: fishes == null ? Center(child: CircularProgressIndicator(),) : ListView.builder(itemBuilder: (context, index) {
        
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
                      Text(fishes[index]['name'], style: TextStyle(fontWeight: FontWeight.bold)),
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
      itemCount: fishes == null ? 0 : fishes.length,
      ),
    );
  }
}
