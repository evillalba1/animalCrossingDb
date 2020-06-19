import 'package:intl/intl.dart';

import 'list_management.dart';
import 'object_class.dart';
import 'database_helper.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;



class FishesPage extends StatefulWidget {
  @override
  _FishesPageState createState() => _FishesPageState();
}

class _FishesPageState extends State<FishesPage> {
  List<Map<String, dynamic>> fishes;
  List<Fish> fishList = new  List<Fish>();
  List<Fish> filteredFishList = new  List<Fish>();
  List<Fish> unfilteredFishList = new  List<Fish>();
  double completionPercent = 0;
  var percentToDisplay = '';
  bool isSorted;

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
        isSorted = false;
        fishes = queryRows;
        fishList = mapFishList(queryRows);
        unfilteredFishList = fishList;
        filteredFishList = fishList;
        getCompletionPercent();
      });
    }
  }

  getCompletionPercent() {
    var countAll = fishList.length;
    var countDonated = fishList.where((c) => c.donated == "Y").toList().length;
    completionPercent = roundDouble(countDonated / countAll, 2);
    percentToDisplay = (completionPercent * 100).toStringAsFixed(0);
  }

  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
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
          title: Text("Fishes"),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 160.0),
              child: CircularPercentIndicator(
                radius: 50.0,
                lineWidth: 5.0,
                percent: completionPercent == 0 ? 0 : completionPercent,
                center: new Text(percentToDisplay + '%'),
                progressColor: Colors.black,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    _showDialog();
                  },
                  child: Icon(
                    Icons.filter_list,
                    size: 26.0,
                    color: isSorted == true ? Colors.red : Colors.black,
                  ),
                )
            ),
          ],
        ),
        body:
        Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/AnimalCrossingGrass.png"),
                        fit: BoxFit.cover))
            ),
            fishList == null ? Center(child: CircularProgressIndicator(),) :
            ListView.builder(itemBuilder: (context, index) {
              return Card (
                child: Container(
                  //color: Colors.red,
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            //color: Colors.yellow,
                            width: 110,
                            //margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 50,
                                  //backgroundImage: AssetImage('assets/fish.png'),
                                  backgroundImage: NetworkImage(fishList[index].imageUrl),
                                  backgroundColor: Colors.transparent,

                                  //https://img.game8.jp/4175032/2a5cdb43c0280c5943633c235ab83618.jpeg/show
                                )
                                //Image.network(villagers[index]['imageUrl'], height: 100, width: 100,fit: BoxFit.fill,),
                              ],
                            ) ,
                          ),
                          Expanded(
                           // color: Colors.blue,
                            //width: 150,
                            //margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(fishList[index].name, style: TextStyle(fontWeight: FontWeight.bold, ),),
                                SizedBox(height: 25,),
                                Text('Value: \$ ' + fishList[index].value, style: TextStyle(fontWeight: FontWeight.bold)),
                                //Image.network(villagers[index]['imageUrl'], height: 100, width: 100,fit: BoxFit.fill,),
                              ],
                            ) ,
                          ),
                          //SizedBox(width: 10,),
                          Expanded(
                            // color: Colors.purple,
                            // width: 120,
                            // height: 200,
                            //margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text('Donated: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Switch (
                                    value: fishList[index].donated == 'N' ? false : true,
                                    onChanged: (value) {
                                      setState(() {
                                        fishList[index].donated = value == false ? 'N' : 'Y';
                                        //call dbHelper update
                                        DatabaseHelper.instance.updateDonatedFish(fishList[index].number, fishList[index].donated);
                                        getCompletionPercent();
                                      });
                                    },
                                    //activeColor: Colors.lightGreen,
                                    //inactiveThumbColor: Colors.redAccent,
                                  )

                                ],),

                              ],
                            ) ,
                          ),
                        ]
                    )
                ),
              );
            },
              itemCount: fishList == null ? 0 : fishList.length,
            ),],

        )

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
              child: Text('Donated'),
              onPressed: () {
                setState(() {
                  isSorted = true;
                  filteredFishList.sort((a, b) =>
                      b.donated.compareTo(a.donated));
                  fishList = filteredFishList;
                });
              }),
          MaterialButton(
              height: 40.0, 
              minWidth: 150.0, 
              color: Colors.black, 
              textColor: Colors.white, 
              splashColor: Theme.of(context).primaryColor,
              child: Text('Value'),
              onPressed: () {
                setState(() {
                  isSorted = true;
                  filteredFishList.sort((a, b) =>
                      int.parse(b.value.replaceAll(',', '')).compareTo(
                          int.parse(a.value.replaceAll(',', ''))));
                  fishList = filteredFishList;
                });
              }),
          MaterialButton(
            height: 40.0, 
            minWidth: 150.0, 
            color: Colors.black, 
            textColor: Colors.white, 
            splashColor: Theme.of(context).primaryColor,
            child: Text('Active North'),
            onPressed: () {
              setState(() {
                  var now = new DateTime.now();
                  var formatter = new DateFormat('MMMM');
                  String month = formatter.format(now);
                  month = 'december';
                  filteredFishList = getActiveListNorth(unfilteredFishList, month.toLowerCase());
                  fishList = filteredFishList;
              });
            }),
          MaterialButton(
            height: 40.0, 
            minWidth: 150.0, 
            color: Colors.black, 
            textColor: Colors.white, 
            splashColor: Theme.of(context).primaryColor,
            child: Text('Active South'),
            onPressed: () {
              setState(() {
                var now = new DateTime.now();
                  var formatter = new DateFormat('MMMM');
                  String month = formatter.format(now);
                  month = 'december';
                  filteredFishList = getActiveListSouth(unfilteredFishList, month.toLowerCase());
                  fishList = filteredFishList;
              });
            }),
            MaterialButton( 
              height: 40.0, 
              minWidth: 150.0, 
              color: Colors.black, 
              textColor: Colors.white, 
              splashColor: Theme.of(context).primaryColor,
              child: Text("Reset"), 
              onPressed: () => {
                setState(() {
                  fetchFishes();
                })
              }, 
            )
        ],
      ),
      barrierColor: Colors.black.withOpacity(0.7),
      pillColor: Colors.black,
      backgroundColor: Colors.lightGreen,
    );
  }


  List<Fish> getActiveListNorth(List<Fish> list, String month) {
  switch(month) { 
    case 'january': return List<Fish>.from(list.where((element) => element.january == "Y")); 
    case 'february': return List<Fish>.from(list.where((element) => element.february == "Y")); 
    case 'march': return List<Fish>.from(list.where((element) => element.march == "Y")); 
    case 'april': return List<Fish>.from(list.where((element) => element.april == "Y")); 
    case 'may': return List<Fish>.from(list.where((element) => element.may == "Y")); 
    case 'june': return List<Fish>.from(list.where((element) => element.june == "Y")); 
    case 'july': return List<Fish>.from(list.where((element) => element.july == "Y")); 
    case 'august': return List<Fish>.from(list.where((element) => element.august == "Y")); 
    case 'september': return List<Fish>.from(list.where((element) => element.september == "Y")); 
    case 'october': return List<Fish>.from(list.where((element) => element.october == "Y")); 
    case 'november': return List<Fish>.from(list.where((element) => element.november == "Y")); 
    case 'december': return List<Fish>.from(list.where((element) => element.december == "Y")); 
    default: return List<Fish>.from(list);
  } 
}

List<Fish> getActiveListSouth(List<Fish> list, String month) {
  switch(month) { 
    case 'january': return List<Fish>.from(list.where((element) => element.januaryS == "Y")); 
    case 'february': return List<Fish>.from(list.where((element) => element.februaryS == "Y")); 
    case 'march': return List<Fish>.from(list.where((element) => element.marchS == "Y")); 
    case 'april': return List<Fish>.from(list.where((element) => element.aprilS == "Y")); 
    case 'may': return List<Fish>.from(list.where((element) => element.mayS == "Y")); 
    case 'june': return List<Fish>.from(list.where((element) => element.juneS == "Y")); 
    case 'july': return List<Fish>.from(list.where((element) => element.julyS == "Y")); 
    case 'august': return List<Fish>.from(list.where((element) => element.augustS == "Y")); 
    case 'september': return List<Fish>.from(list.where((element) => element.septemberS == "Y")); 
    case 'october': return List<Fish>.from(list.where((element) => element.octoberS == "Y")); 
    case 'november': return List<Fish>.from(list.where((element) => element.novemberS == "Y")); 
    case 'december': return List<Fish>.from(list.where((element) => element.decemberS == "Y")); 
    default: return List<Fish>.from(list);
  } 
}








}
