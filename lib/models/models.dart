/*import 'dart:async';

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
*/
/*
class Destination {
  Destination({
    this.placename,
    this.country,
    this.latlng,
    this.imagPath,
    this.overview,
    this.favored,
    this.isExpanded,
  });
  String placename, imagPath, id, overview, country, latlng;
  bool favored, isExpanded;
  Destination.fromJson(Map json)
      : placename = json["place_name"],
        country = json["country"],
        imagPath = json["image_path"],
        id = json["id"].toString(),
        overview = json["overview"],
        latlng = json["lat_long"],
        favored = false;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
   map['id']= id;
    map['place_name']= placename;
    map['country']= country;
    map['image_path'] = imagPath;
    map['lat_long'] = latlng;
    map['overview']= overview;
    map['favored']= favored;
    return map;
  }
   Made this method to deal with the DB not having bool and using binary instead
  Destination.fromOfflineDb(Map map)
      : placename = map["place_name"],
        imagPath = map["image_path"],
        id = map["id"].toString(),
        overview = map["overview"],
        latlng = map["lat_long"],
        favored = false;
}

Future<Stream<Destination>> getPlacesFromAsset() async {
  return new Stream.fromFuture(rootBundle.loadString('assets/places.json'))
      .transform(json.decoder)
      .expand((jsonBody) => (jsonBody as Map)['results'])
      .map((jsonPlace) => new Destination.fromJson(jsonPlace));
}*/