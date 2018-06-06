import 'package:flutter/material.dart';
import 'package:travel_map_f/models/Places.dart';

class PlaceView extends StatefulWidget {
  PlaceView(this.place);

  final Place place;

  @override
  _PlaceViewState createState() => new _PlaceViewState();
}

class _PlaceViewState extends State<PlaceView> {
  Place placeState;

  @override
  void initState() {
    super.initState();
    placeState = widget.place;
  }

  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}
