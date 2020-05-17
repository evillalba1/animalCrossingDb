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
  List<Map<String, dynamic>> Villagers;

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
          Villagers = queryRows;
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
    print(Villagers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Villagers"),
      ),
      body: Column(children: <Widget>[
        
      ],),
    );
  }
}
