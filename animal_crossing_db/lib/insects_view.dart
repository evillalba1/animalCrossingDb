import 'package:flutter/material.dart';

import 'database_helper.dart';

class InsectsPage extends StatefulWidget {
  @override
  _InsectsPageState createState() => _InsectsPageState();
}

class _InsectsPageState extends State<InsectsPage> {
  List<Map<String, dynamic>> insects;

  fetchInsects() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll('insect');
    if (queryRows.length == 0) {
      DatabaseHelper.instance.insertAllInsects();
      Future.delayed(const Duration(milliseconds: 2000), () {
        fetchInsects();
      });
    } else {
      setState(() {
        setState(() {
          debugPrint(queryRows.length.toString());
          insects = queryRows;
        }); // Here you can write your code for open new view
      });
    }
  }

  Future fetchData() async {
    fetchInsects();
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
      body: insects == null ? Center(child: CircularProgressIndicator(),) : ListView.builder(itemBuilder: (context, index) {
        
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
                      Text(insects[index]['name'], style: TextStyle(fontWeight: FontWeight.bold)),
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
      itemCount: insects == null ? 0 : insects.length,
      ),
    );
  }
}
