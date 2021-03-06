import 'package:awesome_button/awesome_button.dart';

import 'list_management.dart';
import 'object_class.dart';
import 'database_helper.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;
import 'package:percent_indicator/percent_indicator.dart';



class FossilPage extends StatefulWidget {
  @override
  _FossilPageState createState() => _FossilPageState();
}

class _FossilPageState extends State<FossilPage> {
  List<Map<String, dynamic>> fossils;
  List<Fossil> fossilList = new List<Fossil>();
  List<Fossil> filteredFossilList = new List<Fossil>();
  List<Fossil> unfilteredFossilList = new List<Fossil>();
  Fossil fos = new Fossil();
  double completionPercent = 0;
  var percentToDisplay = '';
  bool isSorted;

  fetchFossils() async {
    List<Map<String, dynamic>> queryRows =
        await DatabaseHelper.instance.queryAll('fossils');
    if (queryRows.length == 0) {
      DatabaseHelper.instance.insertAllFossil();
      Future.delayed(const Duration(milliseconds: 2000), () {
        fetchFossils();
      });
    } else {
      setState(() {
        isSorted = false;
        fossils = queryRows;
        fossilList = mapFossilsList(queryRows);
        unfilteredFossilList = fossilList;
        filteredFossilList = fossilList;
        getCompletionPercent();// Here you can write your code for open new view
      });
    }
  }

  getCompletionPercent() {
    var countAll = fossilList.length;
    var countDonated = fossilList.where((c) => c.donated == "Y").toList().length;
    completionPercent = roundDouble(countDonated / countAll, 2);
    percentToDisplay = (completionPercent * 100).toStringAsFixed(0);
  }

  double roundDouble(double value, int places){
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  filterByDonated() {

  }

  Future fetchData() async {
    fetchFossils();

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
      body: fossilList == null ? Center(child: CircularProgressIndicator(),) :
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
                        Text(fossilList[index].name, style: TextStyle(fontWeight: FontWeight.bold, ),),
                        SizedBox(height: 25,),
                        Text('Value: \$ ' + fossilList[index].price, style: TextStyle(fontWeight: FontWeight.bold)),
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
                            value: fossilList[index].donated == 'N' ? false : true,
                            onChanged: (value) {
                              setState(() {
                                fossilList[index].donated = value == false ? 'N' : 'Y';
                                //call dbHelper update
                                DatabaseHelper.instance.updateDonatedFossil(fossilList[index].number, fossilList[index].donated);
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
                              initialValue:fossilList[index].quantity,
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
                                  fossilList[index].quantity = value;
                                  //call dbHelper update
                                  DatabaseHelper.instance.updateQuantityFossil(fossilList[index].number, fossilList[index].quantity);
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
        itemCount: fossilList == null ? 0 : fossilList.length,
        ),],

      )

    );
  }


  void _showDialog() {
    slideDialog.showSlideDialog(
      context: context,
      child: Column (
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
            onPressed: (){
              setState(() {
                isSorted = true;
                filteredFossilList.sort((a, b) => b.donated.compareTo(a.donated));
                fossilList = filteredFossilList;
              });
            }),
          MaterialButton(
            height: 40.0, 
            minWidth: 150.0, 
            color: Colors.black, 
            textColor: Colors.white, 
            splashColor: Theme.of(context).primaryColor,
            child: Text('Value'),
            onPressed: (){
              setState(() {
                isSorted = true;
                filteredFossilList.sort((a, b) => int.parse(b.price.replaceAll(',', '')).compareTo(int.parse(a.price.replaceAll(',', ''))));
                fossilList = filteredFossilList;
              });
            }),
          MaterialButton(
            height: 40.0, 
            minWidth: 150.0, 
            color: Colors.black, 
            textColor: Colors.white, 
            splashColor: Theme.of(context).primaryColor,
            child: Text('Reset'),
            onPressed: (){
              setState(() {
                fetchFossils();
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
