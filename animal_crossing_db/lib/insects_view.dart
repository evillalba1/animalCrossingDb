import 'list_management.dart';
import 'object_class.dart';
import 'database_helper.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;



class InsectsPage extends StatefulWidget {
  @override
  _InsectsPageState createState() => _InsectsPageState();
}

class _InsectsPageState extends State<InsectsPage> {
  List<Map<String, dynamic>> insects;
  List<Insect> insectList = new List<Insect>();
  List<Insect> filteredInsectList = new List<Insect>();
  List<Insect> sortedInsectList = new List<Insect>();
  List<Insect> unfilteredInsectList = new List<Insect>();
  double completionPercent = 0;
  var percentToDisplay = '';
  bool isSorted;

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
        isSorted = false;
        insects = queryRows;
        insectList = mapInsectList(queryRows);
        unfilteredInsectList = insectList;
        filteredInsectList = insectList;
        sortedInsectList = insectList;
        getCompletionPercent();
      });
    }
  }

  getCompletionPercent() {
    var countAll = insectList.length;
    var countDonated = insectList.where((c) => c.donated == "Y").toList().length;
    completionPercent = roundDouble(countDonated / countAll, 2);
    percentToDisplay = (completionPercent * 100).toStringAsFixed(0);
  }

  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
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
          title: Text("Insects"),
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
        body: insectList == null ? Center(child: CircularProgressIndicator(),) :
        Stack(
          children: <Widget>[
            // Container(
            //     decoration: BoxDecoration(
            //         image: DecorationImage(
            //             image: AssetImage("assets/AnimalCrossingGrass.png"),
            //             fit: BoxFit.cover))
            // ),
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
                                  //backgroundImage: AssetImage('assets/insect.png'),
                                  backgroundImage: NetworkImage(insectList[index].imageUrl),
                                  backgroundColor: Colors.transparent,
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
                                Text(insectList[index].name, style: TextStyle(fontWeight: FontWeight.bold, ),),
                                SizedBox(height: 25,),
                                Text('Value: \$ ' + insectList[index].value, style: TextStyle(fontWeight: FontWeight.bold)),
                                //Image.network(villagers[index]['imageUrl'], height: 100, width: 100,fit: BoxFit.fill,),
                              ],
                            ) ,
                          ),
                          //SizedBox(width: 10,),
                          Expanded(
                            // color: Colors.purple,
                            //width: 120,
                            //height: 200,
                            //margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text('Donated: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Switch (
                                    value: insectList[index].donated == 'N' ? false : true,
                                    onChanged: (value) {
                                      setState(() {
                                        insectList[index].donated = value == false ? 'N' : 'Y';
                                        //call dbHelper update
                                        DatabaseHelper.instance.updateDonatedInsect(insectList[index].number, insectList[index].donated);
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
              itemCount: insectList == null ? 0 : insectList.length,
            ),],

        )

    );
  }


  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Column(
        children: <Widget>[
          Text("Sort List",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
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
                sortedInsectList.sort((a, b) => b.donated.compareTo(a.donated));
                insectList = sortedInsectList;
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
                sortedInsectList.sort((a, b) => int.parse(b.value.replaceAll(',', '')).compareTo(int.parse(a.value.replaceAll(',', ''))));
                insectList = sortedInsectList;
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
                  filteredInsectList = getActiveListNorth(unfilteredInsectList, month.toLowerCase());
                  insectList = filteredInsectList;
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
                  filteredInsectList = getActiveListSouth(unfilteredInsectList, month.toLowerCase());
                  insectList = filteredInsectList;
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
                  fetchInsects();
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


  List<Insect> getActiveListNorth(List<Insect> list, String month) {
    switch(month) { 
      case 'january': return List<Insect>.from(list.where((element) => element.january == "Y")); 
      case 'february': return List<Insect>.from(list.where((element) => element.february == "Y")); 
      case 'march': return List<Insect>.from(list.where((element) => element.march == "Y")); 
      case 'april': return List<Insect>.from(list.where((element) => element.april == "Y")); 
      case 'may': return List<Insect>.from(list.where((element) => element.may == "Y")); 
      case 'june': return List<Insect>.from(list.where((element) => element.june == "Y")); 
      case 'july': return List<Insect>.from(list.where((element) => element.july == "Y")); 
      case 'august': return List<Insect>.from(list.where((element) => element.august == "Y")); 
      case 'september': return List<Insect>.from(list.where((element) => element.september == "Y")); 
      case 'october': return List<Insect>.from(list.where((element) => element.october == "Y")); 
      case 'november': return List<Insect>.from(list.where((element) => element.november == "Y")); 
      case 'december': return List<Insect>.from(list.where((element) => element.december == "Y")); 
      default: return List<Insect>.from(list);
    } 
  }

  List<Insect> getActiveListSouth(List<Insect> list, String month) {
    switch(month) { 
      case 'january': return List<Insect>.from(list.where((element) => element.januaryS == "Y")); 
      case 'february': return List<Insect>.from(list.where((element) => element.februaryS == "Y")); 
      case 'march': return List<Insect>.from(list.where((element) => element.marchS == "Y")); 
      case 'april': return List<Insect>.from(list.where((element) => element.aprilS == "Y")); 
      case 'may': return List<Insect>.from(list.where((element) => element.mayS == "Y")); 
      case 'june': return List<Insect>.from(list.where((element) => element.juneS == "Y")); 
      case 'july': return List<Insect>.from(list.where((element) => element.julyS == "Y")); 
      case 'august': return List<Insect>.from(list.where((element) => element.augustS == "Y")); 
      case 'september': return List<Insect>.from(list.where((element) => element.septemberS == "Y")); 
      case 'october': return List<Insect>.from(list.where((element) => element.octoberS == "Y")); 
      case 'november': return List<Insect>.from(list.where((element) => element.novemberS == "Y")); 
      case 'december': return List<Insect>.from(list.where((element) => element.decemberS == "Y")); 
      default: return List<Insect>.from(list);
    } 
  }
}
