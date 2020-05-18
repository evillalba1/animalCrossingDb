import 'package:animalcrossingdb/list_management.dart';
import 'package:animalcrossingdb/object_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:gradual_stepper/gradual_stepper.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

import 'database_helper.dart';

class FossilPage extends StatefulWidget {
  @override
  _FossilPageState createState() => _FossilPageState();
}

class _FossilPageState extends State<FossilPage> {
  List<Map<String, dynamic>> fossils;
  List<Fossil> fossilList = new List<Fossil>();
  Fossil fos = new Fossil();

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
        setState(() {
          debugPrint(queryRows.length.toString());
          fossils = queryRows;
          fossilList = mapFossilsList(queryRows);
        }); // Here you can write your code for open new view
      });
    }
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
      ),
      body: fossilList == null ? Center(child: CircularProgressIndicator(),) : 
      Stack(
        children: <Widget>[
          Container(
          //   decoration: BoxDecoration(
          // image: DecorationImage(
          //     image: AssetImage("assets/AnimalCrossingGrass.png"),
          //     fit: BoxFit.cover))
          ),
          ListView.builder(itemBuilder: (context, index) {
          return Card (
            child: Container(
              color: Colors.red,
              
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    color: Colors.blue,
                    width: 150,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(fossilList[index].name, style: TextStyle(fontWeight: FontWeight.bold, ),),
                        SizedBox(height: 25,),
                        Text('Price: \$ ' + fossilList[index].price, style: TextStyle(fontWeight: FontWeight.bold)),
                        //Image.network(villagers[index]['imageUrl'], height: 100, width: 100,fit: BoxFit.fill,),
                      ],
                    ) ,
                  ),
                  SizedBox(width: 40,),
                  Container(
                    color: Colors.purple,
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
                              onChanged: (int val) => print('New value : $val'),
                            ),
                            
                            // GradualStepper (
                            // buttonsColor: Colors.black,
                            // //backgroundColor: Colors.red,
                            // cornerRadius: 22,
                            // counterTextStyle: TextStyle(fontSize: 14),
                            // counterBackgroundColor: Colors.lightGreen,
                            // initialValue: fossilList[index].quantity,
                            // minimumValue: 0,
                            // maximumValue: 10,
                            // stepValue: 1,
                            // onChanged: (value) {
                            //   setState(() {
                            //     fossilList[index].quantity = value;
                            //   });
                            // },
                            // )
                          )
                          
                          // Counter(
                          //   key: Key(index.toString()),
                          //   initialValue: fossilList[index].quantity,
                          //   minValue: 0,
                          //   maxValue: 10,
                          //   step: 1,
                          //   decimalPlaces: 0,
                          //   color: Colors.lightGreen,
                          //   onChanged: (value) { // get the latest value from here
                          //     setState(() {
                          //       fossilList[index].quantity = value;
                          //     });
                          //   },
                          // )
                        ],)
                        
                        // Text(fossils[index]['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                        // SizedBox(height: 10,),
                        // Text('\$ ' + fossils[index]['price'], style: TextStyle(fontWeight: FontWeight.bold)),
                        //Image.network(villagers[index]['imageUrl'], height: 100, width: 100,fit: BoxFit.fill,),
                      ],
                    ) ,
                  )
                ]
              )
            ),
          );
        },
        itemCount: fossilList == null ? 0 : fossilList.length,
        )],
      ) 
    );
  }
}
