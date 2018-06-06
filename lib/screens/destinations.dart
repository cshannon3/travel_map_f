import 'package:flutter/material.dart';
import 'package:travel_map_f/database/database.dart';
import 'package:travel_map_f/models/Places.dart';
import 'package:travel_map_f/Components/map_view.dart';
import 'dart:async';
import 'package:map_view/map_view.dart';
//import 'package:mongo_dart/mongo_dart.dart';

var API_KEY = "AIzaSyACynrRng0a2GrO18sZGV2FEzSWC8vuyp0";

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => new _MapPageState();
}

class _MapPageState extends State<MapPage> {

    List<Destination> dests = [];
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    String country, place, lat, lng;

    Destination destination = new Destination();
    TravelDatabase db;

    @override
    void initState() {
      MapView.setApiKey(API_KEY);
      super.initState();
    }
    void _submitForm() {
      final FormState form = _formKey.currentState;

      if (!form.validate()) {
       // showMessage('Form is not valid!  Please review and correct.');
      } else {
        form.save();
        //submitted = true;
       listenfordest();
      }
    }
      void onPressed(){
        TravelDatabase db = TravelDatabase();
        //db.initDB();
        setState(() => destination.favored = !destination.favored);
        destination.favored == true
            ? db.addDest(destination)
           : db.deleteDest(destination.id);
      }

    listenfordest() async {

      var stream = await getDestinationLoc(destination.placename, destination.country);
      stream.listen((dest) {
        print(dest.placename);
        print(dest.lat);
        print(dest.lng);
        setState(() {
          destination = dest;
        });
      });
    }
@override
  Widget build(BuildContext context) {
    return new Container(

      child: Center(
        child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
            new TextFormField(
            decoration: const InputDecoration(
            icon: const Icon(Icons.place),
          hintText: 'Enter place name',
          labelText: 'Place',
        ),
       // inputFormatters: [new LengthLimitingTextInputFormatter(30)],
        validator: (val) => val.isEmpty ? 'Name is required' : null,
        onSaved: (val) => destination.placename = val,
      ),
      new TextFormField(
        decoration: const InputDecoration(
          icon: const Icon(Icons.map),
          hintText: 'Enter Country',
          labelText: 'Country',
        ),
        // inputFormatters: [new LengthLimitingTextInputFormatter(30)],
        validator: (val) => val.isEmpty ? 'Name is required' : null,
        onSaved: (val) => destination.country = val,
      ),

    new Container(
    padding: const EdgeInsets.only(left: 40.0, top: 20.0),
    child: new RaisedButton(
    child: const Text('Submit'),
    onPressed: _submitForm,
    )),
            new Container(
                padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    onPressed();
                  },
                )),
          mapView(),

          ],
        ),
        ),
      ),
    );
  }
}

class CompositeSubscription {
  Set<StreamSubscription> _subscriptions = new Set();

  void cancel() {
    for (var n in this._subscriptions) {
      n.cancel();
    }
    this._subscriptions = new Set();
  }

  void add(StreamSubscription subscription) {
    this._subscriptions.add(subscription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptions.toList();
  }
}