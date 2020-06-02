import 'database_helper.dart';
import 'list_management.dart';
import 'object_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class VillagersPage extends StatefulWidget {
  @override
  _VillagersPageState createState() => _VillagersPageState();
}

class _VillagersPageState extends State<VillagersPage> {
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> villagers;
  List<Villager> villagerList = new List<Villager>();
  //List<Fossil> fossilList = new List<Fossil>();

  fetchVillagers() async {
    debugPrint("fetching Villagers");
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll('villagers');
    // var query = await DatabaseHelper.instance.queryAll("villagers");
    if (queryRows.length == 0) {
      DatabaseHelper.instance.insertAllVillagers();
      //fetchVillagers();
      Future.delayed(const Duration(milliseconds: 2000), () {
        fetchVillagers();
      });
    } else {
      setState(() {
        debugPrint(queryRows.length.toString());
        villagers = queryRows;
        villagerList = mapVillagersList(queryRows);
      });
    }
  }

  Future fetchData() async {
    fetchVillagers();
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
        title: Text("Villagers"),
      ),
      body: villagerList == null ? Center(child: CircularProgressIndicator(),) : ListView.builder(itemBuilder: (context, index) {
        return Card (
          child: Container(
            height: 130,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: <Widget>[
                Container(
                  width: 180,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(villagerList[index].name, style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 10,),
                      Image.network(villagerList[index].imageUrl, height: 100, width: 100,fit: BoxFit.fill,),
                    ],
                  ) ,
                ),
                //SizedBox(width: 40,),
                Container(
                  // color: Colors.purple,
                  width: 150,
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text('Resident: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Switch (
                          value: villagerList[index].resident == 'N' ? false : true,
                          onChanged: (value) {
                            setState(() {
                              villagerList[index].resident = value == false ? 'N' : 'Y';
                              //call dbHelper update
                              DatabaseHelper.instance.updateResidentVillager(villagerList[index].number, villagerList[index].resident);
                            });
                          },
                          //activeColor: Colors.lightGreen,
                          //inactiveThumbColor: Colors.redAccent,
                        )

                      ],),
                      Row (children: <Widget>[
                        Text('Birthday: ' , style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(villagerList[index].birthday),
                      ],)
                    ],
                  ) ,
                )
                ]
            ),
          ),
        );
      },
      itemCount: villagerList == null ? 0 : villagerList.length,
      ),
    );
  }
}
