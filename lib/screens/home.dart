import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:travel_map_f/models/Places.dart';


import 'dart:convert';

import 'package:travel_map_f/models/card_data.dart';
import 'package:travel_map_f/models/place_data.dart';

const key = '54bd8ffe8112b6a52753bcf473763a8c';
class HomePage extends StatefulWidget {
  final List<CardViewModel> countrydata;

  HomePage({
    this.countrydata
  });

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: widget.countrydata.length,
      itemBuilder: (BuildContext context, int index){
      return new countryTile(
          viewModel: widget.countrydata[index]
      );
      },

      ),
    );
  }
}

class countryTile extends StatelessWidget {
  final CardViewModel viewModel;

  countryTile({this.viewModel});


  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
      title: Text(viewModel.country),
      leading: Container(
        height: 50.0,
        width: 100.0,
        //color: Colors.red,
        child: new Image.asset(
          viewModel.flagAssetPath,
          fit: BoxFit.cover,
        ), //Image asset
      ), // Container,
      children: <Widget>[

        placeTile(place: demoPlaces[0],)
      ],
    );
  }
}

class placeTile extends StatelessWidget {
  final PlaceViewModel place;

  placeTile({this.place});
  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
      title: Text(place.destination),
      children: [
        Text(place.name)
      ],
    );
  }
}

