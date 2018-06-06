import 'package:flutter/material.dart';
import 'package:travel_map_f/models/Places.dart';


const API_KEY = "AIzaSyDgObRr_huAXQ-ssfiJoMLpxMiDX_UgsZs";

class PlaceSearchPage extends StatefulWidget {
  @override
  _PlaceSearchState createState() => new _PlaceSearchState();
}

class _PlaceSearchState extends State<PlaceSearchPage> {
    List<Place> places = [];
    bool hasLoaded = true;
  @override
  void initState() {
    print("hey");
    super.initState();
    listenforplaces();


  }

  listenforplaces() async {

    setState(() =>
    hasLoaded = false,

    );
    places.clear();
    //var stream = await getPlaces(45.815011, 15.981919, "");
    var stream = await getPlaces(44.119371, 15.231364799999938, false);
    stream.listen((place) {
      if(place.rating != -1.0 && !place.name.contains("Hotel")) {
        places.add(place);
      }
    }).onDone((){
      setState(() =>
      hasLoaded = true
      );
    });

  }

  listenformore() async {
    setState(() =>
    hasLoaded = false,

    );
    var stream = await getPlaces(44.119371, 15.231364799999938, true);
    stream.listen((place) {
      if(place.rating != -1.0 && !place.name.contains("Hotel")) {
        places.add(place);
      }
    }).onDone((){
      setState(() =>
      hasLoaded = true
      );
    });


  }
    void printem() {
      for (var j = 0; j< places.length; j++){
        print(places[j].name);
      }
    }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          /*RaisedButton(
            onPressed: () {
              printem();
            },
          ),*/
          hasLoaded ? Container() : CircularProgressIndicator(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: places.length,
              itemBuilder: (BuildContext context, int index) {
                return new PlaceWidget(place: places[index]);
              },
            ), // ListView Builder
          ), // Expanded
        ],
      ),
    );
  }




}

class PlaceWidget extends StatelessWidget  {

  final Place place;

  PlaceWidget({
    this.place});

  Color getColor(double rating) {
    return Color.lerp(Colors.red, Colors.green, rating / 5);
  }


  @override
  Widget build(BuildContext context) {
    // return new ListTile(
    return   new Padding(
      padding: const EdgeInsets.only(top:10.0, bottom: 10.0),
      child: new Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white)
          ),
        ),
        padding: EdgeInsets.only(top:10.0, bottom: 10.0),
        child: new ListTile(

                        //onTap: ,
                        leading:
                        Container(
                          width: 50.0,
                          child: Column(
                            children: [
                              new CircleAvatar(
                                child: new Text(
                                    place.rating.toString(),
                                  style: TextStyle(
                                    color: Colors.black
                                  ),),
                                backgroundColor: getColor(place.rating),
                              ),
                              IconButton(
                                icon: Icon(Icons.favorite_border),
                                onPressed: () {},
                              )
                            ],
                          ),

                        ),
                        title: Container(
                          child: Row(
                              children: <Widget>[
                          place.photo_ref != null
                              ? Hero(
                            child: Image.network(
                                "https://maps.googleapis.com/maps/api/place/photo?maxwidth=120&photoreference=${place.photo_ref}"
                                + "&key=$API_KEY"
                            ), // Image Asset
                            tag: place.placeid,
                          ) // Hero
                              : Container(width: 120.0,), // Container
                          new Expanded(
                              child: Column(
                                children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  text: place.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0,
                                  )
                                ),
                                overflow: TextOverflow.clip,
                                maxLines: 3,
                                textAlign: TextAlign.center,

                         ),
        RichText(
          text: TextSpan(
              text: place.address,
          ),
          overflow: TextOverflow.clip,
          maxLines: 3,
          textAlign: TextAlign.center,

        ),
    ],
                              ),
                          ),

        ],
                          ),
                        ), // new Text(place.name),
                        //subtitle: new Text(place.address),



          // feedback:
        ),
      ),
    );
  }
}
