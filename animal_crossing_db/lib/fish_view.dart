import 'list_management.dart';
import 'object_class.dart';
import 'database_helper.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';



class FishesPage extends StatefulWidget {
  @override
  _FishesPageState createState() => _FishesPageState();
}

class _FishesPageState extends State<FishesPage> {
  List<Map<String, dynamic>> fishes;
  List<Fish> fishList = new  List<Fish>();
  double completionPercent = 0;
  var percentToDisplay = '';

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
        debugPrint(queryRows.length.toString());
        fishes = queryRows;
        fishList = mapFishList(queryRows);
        getCompletionPercent();
      });
    }
  }

  getCompletionPercent() {
    var countAll = fishList.length;
    var countDonated = fishList.where((c) => c.donated == "Y").toList().length;
    completionPercent = roundDouble(countDonated / countAll, 2);
    percentToDisplay = (completionPercent * 100).toStringAsFixed(0);
    print(completionPercent);
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
        body: fishList == null ? Center(child: CircularProgressIndicator(),) :
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
                                Text(fishList[index].name, style: TextStyle(fontWeight: FontWeight.bold, ),),
                                SizedBox(height: 25,),
                                Text('Value: \$ ' + fishList[index].value, style: TextStyle(fontWeight: FontWeight.bold)),
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
                                    value: fishList[index].donated == 'N' ? false : true,
                                    onChanged: (value) {
                                      setState(() {
                                        print(index.toString() + ' ' + fishList[index].number.toString() );
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
                                Row (children: <Widget>[
                                  Text('Quantity: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child:
                                    StepperSwipe(
                                      iconsColor: Colors.black,
                                      counterTextColor: Colors.black,
                                      withPlusMinus: true,
                                      initialValue:fishList[index].quantity,
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
                                          fishList[index].quantity = value;
                                          //call dbHelper update
                                          DatabaseHelper.instance.updateQuantityFish(fishList[index].number, fishList[index].quantity);
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
              itemCount: fishList == null ? 0 : fishList.length,
            ),],

        )

    );
  }
}
