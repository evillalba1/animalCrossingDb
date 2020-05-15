import 'package:animalcrossingdb/fish_view.dart';
import 'package:animalcrossingdb/insects_view.dart';
import 'package:animalcrossingdb/villagers_view.dart';
import 'package:flutter/material.dart';
import 'package:animalcrossingdb/object_class.dart';
import 'package:awesome_button/awesome_button.dart';
import 'package:flutter/foundation.dart';

import 'fossils_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("fetching");
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/AnimalCrossingGrass.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Animal Crossing DB"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: height * .3,
                padding: EdgeInsets.only(bottom: 30, top: 30),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/Tom_Nook.png'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Welcome Villager", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                  ],
                ),
              ),
              Container(
                height: height * .5,
                padding: EdgeInsets.only(bottom: 30, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AwesomeButton(
                      blurRadius: 10.0,
                      splashColor: Color.fromRGBO(255, 255, 255, .4),
                      borderRadius: BorderRadius.circular(37.5),
                      height: 50.0,
                      width: 200.0,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FossilPage())),
                      color: Colors.brown[300],
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Fossils",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AwesomeButton(
                      blurRadius: 10.0,
                      splashColor: Color.fromRGBO(255, 255, 255, .4),
                      borderRadius: BorderRadius.circular(37.5),
                      height: 50.0,
                      width: 200.0,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FishesPage())),
                      color: Colors.blue[300],
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Fishes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AwesomeButton(
                      blurRadius: 10.0,
                      splashColor: Color.fromRGBO(255, 255, 255, .4),
                      borderRadius: BorderRadius.circular(37.5),
                      height: 50.0,
                      width: 200.0,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InsectsPage())),
                      color: Colors.green[300],
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Insects",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AwesomeButton(
                      blurRadius: 10.0,
                      splashColor: Color.fromRGBO(255, 255, 255, .4),
                      borderRadius: BorderRadius.circular(37.5),
                      height: 50.0,
                      width: 200.0,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VillagersPage())),
                      color: Colors.orange[300],
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 50.0,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Villagers",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
