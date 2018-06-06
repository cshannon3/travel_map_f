import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/destinations.dart';
import 'screens/map.dart';
import 'screens/destination_page.dart';

import 'package:travel_map_f/models/card_data.dart';
// TODO convert hardcoded country data to database
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Travel App',
      theme: new ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("My Travel App"),

          ), // App Bar
          body: Center(
    child: Column(
          children: <Widget>[
          new Expanded(
            child: TabBarView(
              children: <Widget>[
                HomePage(
                  countrydata: demoCards,
                ),
                MapPage(),
               DestinationPage(
                 countrydata: demoCards,
               ),
              ],
            ),
          ),// Tabbar View
            TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home Page',
                ), // Tab
                Tab(
                  icon: Icon(Icons.map),
                  text: 'Map',
                ), // Tab
                Tab(
                  icon: Icon(Icons.favorite),
                  text: "Favorites",
                ), // Tab
              ],
            ),
          ],
    ), // Column
          ), // Center
        ), // Scaffold
      ), // Tab controller
    ); // Material App
  }
}

