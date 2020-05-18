import 'dart:convert';

import 'package:animalcrossingdb/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class VillagersPage extends StatefulWidget {
  @override
  _VillagersPageState createState() => _VillagersPageState();
}

class _VillagersPageState extends State<VillagersPage> {
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> villagers;

  fetchVillagers() async {
    debugPrint("fetching Villagers");
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll('villagers');
    // var query = await DatabaseHelper.instance.queryAll("villagers");
    if (queryRows.length == 0) {
      debugPrint("lenght = o");
      DatabaseHelper.instance.insertAllVillagers();
      //fetchVillagers();
      Future.delayed(const Duration(milliseconds: 2000), () {
        fetchVillagers();
      });
    } else {
      setState(() {
        setState(() {
          debugPrint(queryRows.length.toString());
          villagers = queryRows;
        }); // Here you can write your code for open new view
      });
    }
  }

  Future fetchData() async {
    fetchVillagers();
  }

  @override
  void initState() {
    debugPrint('initState Villagers');
    fetchData();
    super.initState();
    print(villagers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Villagers"),
      ),
      body: villagers == null ? Center(child: CircularProgressIndicator(),) : ListView.builder(itemBuilder: (context, index) {
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
                      Text(villagers[index]['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10,),
                      Image.network(villagers[index]['imageUrl'], height: 100, width: 100,fit: BoxFit.fill,),
                    ],
                  ) ,
                )
              ]
            )
          ),
        );
      },
      itemCount: villagers == null ? 0 : villagers.length,
      ),
    );
  }
}
