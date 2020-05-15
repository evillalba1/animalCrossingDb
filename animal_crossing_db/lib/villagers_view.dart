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
    debugPrint("fetching");
//    var query = await DatabaseHelper.instance.queryAll("villagers");
//    setState(() {
//      Villagers = query;
//    });
  }

  Future fetchData() async {
    fetchVillagers();
  }

  @override
  void initState() {
    debugPrint('initState');
    fetchData();
    super.initState();
    //print(Villagers);
  }



    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Villagers"),),
      body: Text("Villagers"),
    );
  }
}
