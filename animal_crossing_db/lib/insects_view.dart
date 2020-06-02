import 'dart:math';

import 'package:animalcrossingdb/object_class.dart';
import 'package:flutter/material.dart';
import 'package:animalcrossingdb/list_management.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

import 'database_helper.dart';

class InsectsPage extends StatefulWidget {
  @override
  _InsectsPageState createState() => _InsectsPageState();
}

class _InsectsPageState extends State<InsectsPage> {
  List<Map<String, dynamic>> insects;
  List<Insect> insectList = new List<Insect>();
  double completionPercent = 0;
  var percentToDisplay = '';

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
        debugPrint(queryRows.length.toString());
        insects = queryRows;
        insectList = mapInsectList(queryRows);
        getCompletionPercent();
      });
    }
  }

  getCompletionPercent() {
    var countAll = insectList.length;
    var countDonated = insectList.where((c) => c.donated == "Y").toList().length;
    completionPercent = roundDouble(countDonated / countAll, 2);
    percentToDisplay = (completionPercent * 100).toStringAsFixed(0);
    print(completionPercent);
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
                    //_showDialog();
                  },
                  child: Icon(
                    Icons.filter_list,
                    size: 26.0,
                  ),
                )
            ),
          ],
        ),
        body: insectList == null ? Center(child: CircularProgressIndicator(),) :
        Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/AnimalCrossingGrass.png"),
                        fit: BoxFit.cover))
            ),
            ListView.builder(itemBuilder: (context, index) {
              return Card (
                child: Container(
                  //color: Colors.red,
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            //color: Colors.blue,
                            width: 150,
                            margin: EdgeInsets.symmetric(horizontal: 10),
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
                          SizedBox(width: 40,),
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
                                  Text('Donated: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Switch (
                                    value: insectList[index].donated == 'N' ? false : true,
                                    onChanged: (value) {
                                      setState(() {
                                        print(index.toString() + ' ' + insectList[index].number.toString() );
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
                                Row (children: <Widget>[
                                  Text('Quantity: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child:
                                    StepperSwipe(
                                      iconsColor: Colors.black,
                                      counterTextColor: Colors.black,
                                      withPlusMinus: true,
                                      initialValue:insectList[index].quantity,
                                      speedTransitionLimitCount: 3,
                                      firstIncrementDuration: Duration(milliseconds: 250),
                                      secondIncrementDuration: Duration(milliseconds: 100),
                                      direction: Axis.horizontal,
                                      dragButtonColor: Colors.lightGreen,
                                      withSpring: true,
                                      withNaturalNumbers: true,
                                      withBackground: false,
                                      onChanged: (int value){
                                        setState(() {
                                          print(value);
                                          insectList[index].quantity = value;
                                          //call dbHelper update
                                          DatabaseHelper.instance.updateQuantityInsect(insectList[index].number, insectList[index].quantity);
                                        });
                                      },
                                    ),
                                  )
                                ],)
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
}
