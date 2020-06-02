import 'fish_view.dart';
import 'insects_view.dart';
import 'villagers_view.dart';
import 'database_helper.dart';
import 'flowers_view.dart';
import 'fossils_view.dart';
import 'package:flutter/material.dart';
import 'package:awesome_button/awesome_button.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  createDB() async {
    print('Creating DB');
    await DatabaseHelper.instance.createDB();
  }

  @override
  void initState() {
    createDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                //color: Colors.red,
                  height: height * .3,
                  padding: EdgeInsets.only(bottom: 30, top: 30),
                  child: MenuHeader(headerText: 'Welcome Villager', imageUrl: 'assets/Tom_Nook.png',)),
              Container(
                //color: Colors.yellow,
                height: height * .55,
                padding: EdgeInsets.only(bottom: 10, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MenuButton(
                        page: FossilPage(),
                        bntColor: Colors.brown[300],
                        btnIcon: Icons.account_balance,
                        btnText: 'Fossils'),
                    SizedBox(height: 10,),
                    MenuButton(
                        page: FishesPage(),
                        bntColor: Colors.blue[300],
                        btnIcon: Icons.beach_access,
                        btnText: 'Fishes'),
                    SizedBox(height: 10,),
                    MenuButton(
                        page: InsectsPage(),
                        bntColor: Colors.green[300],
                        btnIcon: Icons.bug_report,
                        btnText: 'Insects'),
                    SizedBox(height: 10,),
                    MenuButton(
                        page: VillagersPage(),
                        bntColor: Colors.orange[300],
                        btnIcon: Icons.account_circle,
                        btnText: 'Villagers'),
                    SizedBox(height: 10,),
                    MenuButton(
                        page: FlowerPage(),
                        bntColor: Colors.pink[300],
                        btnIcon: Icons.filter_vintage,
                        btnText: 'Flowers'),
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

class MenuButton extends StatelessWidget {
  const MenuButton(
      {Key key, this.page, this.bntColor, this.btnIcon, this.btnText})
      : super(key: key);
  final page;
  final bntColor;
  final btnIcon;
  final String btnText;

  @override
  Widget build(BuildContext context) {

    return AwesomeButton(
      blurRadius: 10.0,
      splashColor: Color.fromRGBO(255, 255, 255, .4),
      borderRadius: BorderRadius.circular(37.5),
      height: 50.0,
      width: 200.0,
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page)),
      color: bntColor,

      child: Container(
        padding: EdgeInsets.only(left: 15),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
//          SizedBox(
//            width: 15,
//          ),
            Icon(
              btnIcon,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              btnText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({Key key, this.headerText, this.imageUrl}) : super(key: key);
  final String headerText;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(imageUrl),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          headerText,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ],
    );
  }
}
