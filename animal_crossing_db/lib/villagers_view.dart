import 'database_helper.dart';
import 'list_management.dart';
import 'object_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class VillagersPage extends StatefulWidget {
  @override
  _VillagersPageState createState() => _VillagersPageState();
}

class _VillagersPageState extends State<VillagersPage> {
  // ignore: non_constant_identifier_names
  List<Map<String, dynamic>> villagers;
  List<Villager> villagerList = new List<Villager>();
  List<Villager> filteredVillagerList = new List<Villager>();

  fetchVillagers() async {
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
        villagers = queryRows;
        villagerList = mapVillagersList(queryRows);
        filteredVillagerList = villagerList;
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
        actions: <Widget>[
//          Padding(
//            padding: EdgeInsets.only(right: 160.0),
//            child: CircularPercentIndicator(
//              radius: 50.0,
//              lineWidth: 5.0,
//              percent: completionPercent == 0 ? 0 : completionPercent,
//              center: new Text(percentToDisplay + '%'),
//              progressColor: Colors.black,
//            ),
//          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _showDialog();
                },
                child: Icon(
                  Icons.filter_list,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: villagerList == null ? Center(child: CircularProgressIndicator(),) :
      Stack(
          children: <Widget>[
      // Container(
      //   decoration: BoxDecoration(
      //   image: DecorationImage(
      //   image: AssetImage("assets/AnimalCrossingGrass.png"),
      //   fit: BoxFit.cover))
      // ),
      ListView.builder(itemBuilder: (context, index) {
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
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(villagerList[index].imageUrl),
                          backgroundColor: Colors.transparent,
                        )

                       // Image.network(villagerList[index].imageUrl, height: 100, width: 100,fit: BoxFit.fill,),
                      ],
                    ) ,
                  ),
                  //SizedBox(width: 40,),
                  Expanded(
                    // color: Colors.purple,
                    // width: 150,
                    // height: 200,
                    // margin: EdgeInsets.symmetric(horizontal: 10),
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
                        ],),
                        SizedBox(height: 15,),
                        Row (children: <Widget>[
                          Text('Species: ' , style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(villagerList[index].species),
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
      ]),
    );
  }
  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Column(
        children: <Widget>[
          Text("Sort List", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
          SizedBox(height: 50,),
          MaterialButton(
            height: 40.0, 
            minWidth: 150.0, 
            color: Colors.black, 
            textColor: Colors.white, 
            splashColor: Theme.of(context).primaryColor,
              child: Text('Resident'),
              onPressed: () {
                setState(() {
                  filteredVillagerList.sort((a, b) =>
                      b.resident.compareTo(a.resident));
                  villagerList = filteredVillagerList;
                });
              }),
          MaterialButton(
            height: 40.0, 
            minWidth: 150.0, 
            color: Colors.black, 
            textColor: Colors.white, 
            splashColor: Theme.of(context).primaryColor,
              child: Text('Reset'),
              onPressed: () {
                setState(() {
                  fetchVillagers();
                });
              }),
        ],
      ),
      barrierColor: Colors.black.withOpacity(0.7),
      pillColor: Colors.black,
      backgroundColor: Colors.lightGreen,
    );
  }
}
