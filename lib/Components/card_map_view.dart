import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:travel_map_f/database/database.dart';
import 'package:travel_map_f/models/Places.dart';
import 'package:travel_map_f/models/card_data.dart';
import 'dart:async';
import 'package:map_view/map_view.dart';

var API_KEY = "AIzaSyDgObRr_huAXQ-ssfiJoMLpxMiDX_UgsZs";//"AIzaSyACynrRng0a2GrO18sZGV2FEzSWC8vuyp0";


class cardmapView extends StatefulWidget {
  final CardViewModel card;

  cardmapView({
    this.card
  });

  @override
  _cardmapViewState createState() => new _cardmapViewState();
}


class _cardmapViewState extends State<cardmapView> {
  CameraPosition cameraPosition;
  var compositeSubscription = new CompositeSubscription();
  var staticMapProvider = new StaticMapProvider(API_KEY);
  Uri staticMapUri;
  //List<Marker> markers = [];
  MapView mapView = new MapView();


  @override
  void initState() {
    MapView.setApiKey(API_KEY);
    super.initState();

    staticMapUri = staticMapProvider.getStaticUri(
        Location(widget.card.lat,widget.card.lng), 6, width: 900, height: 400);
  }



  showMap() {
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: new CameraPosition(
                new Location(widget.card.lat, widget.card.lng), 8.0),
            title: "Recently Visited"),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    var sub = mapView.onMapReady.listen((_) {
      //mapView.setMarkers(markers);
      // mapView.addMarker(new Marker("3", "10 Barrel", 45.5259467, -122.687747,
      //  color: Colors.purple));
      //  mapView.zoomToFit(padding: 100);
    });
    compositeSubscription.add(sub);

    sub = mapView.onLocationUpdated
        .listen((location) => print("Location updated $location"));
    compositeSubscription.add(sub);

    sub = mapView.onTouchAnnotation
        .listen((annotation) => print("annotation tapped"));
    compositeSubscription.add(sub);

    sub = mapView.onMapTapped
        .listen((location) => print("Touched location $location"));
    compositeSubscription.add(sub);

    sub = mapView.onCameraChanged.listen((cameraPosition) =>
        this.setState(() => this.cameraPosition = cameraPosition));
    compositeSubscription.add(sub);

    sub = mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        _handleDismiss();
      }
    });
    compositeSubscription.add(sub);

    sub = mapView.onInfoWindowTapped.listen((marker) {
      print("Info Window Tapped for ${marker.title}");
    });
    compositeSubscription.add(sub);
  }


  _handleDismiss() async {
    double zoomLevel = await mapView.zoomLevel;
    Location centerLocation = await mapView.centerLocation;
    List<Marker> visibleAnnotations = await mapView.visibleAnnotations;
    print("Zoom Level: $zoomLevel");
    print("Center: $centerLocation");
    print("Visible Annotation Count: ${visibleAnnotations.length}");
    var uri = await staticMapProvider.getImageUriFromMap(mapView,
        width: 900, height: 400);
    setState(() => staticMapUri = uri);
    mapView.dismiss();
    compositeSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 250.0,
      //child: new Stack(
      child: Column(
        children: <Widget>[

          /* new Center(
              child: new Container(
                child: new Text(
                  "You are supposed to see a map here.\n\nAPI Key is not valid.\n\n"
                      "To view maps in the example application set the "
                      "API_KEY variable in example/lib/main.dart. "
                      "\n\nIf you have set an API Key but you still see this text "
                      "make sure you have enabled all of the correct APIs "
                      "in the Google API Console. See README for more detail.",
                  textAlign: TextAlign.center,
                ),
                padding: const EdgeInsets.all(20.0),
              )),*/
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: new Center(
                child: new Image.network(staticMapUri.toString()),
              ),
              onTap: showMap,
            ),
          ) //: CircularProgressIndicator(),
        ],
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