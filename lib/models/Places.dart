import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:travel_map_f/models/models.dart';


import 'package:flutter/services.dart';
const API_KEY = "AIzaSyDgObRr_huAXQ-ssfiJoMLpxMiDX_UgsZs";
String next_page_token;

main(){

  getPlaces(45.815011, 15.981919, false);//39.683723, -75.749657, 'burgers');

}
class Place {
  final String name;
  final double rating;
  final String address;
  final String placeid;
  final  photo_ref;
  //final String image_url;
  final double lat;
  final double lng;
  Place.fromJson(Map jsonMap):
        name = jsonMap['name'],
        rating = jsonMap['rating']?.toDouble() ?? -1.0,
        address = jsonMap['vicinity'],
        placeid = jsonMap['place_id'],
        photo_ref = jsonMap['photos'] !=null ? jsonMap['photos'][0]['photo_reference'] : null,
      //  image_url = null,
        lat  = jsonMap['geometry']['location']['lat']?.toDouble(),
        lng  = jsonMap['geometry']['location']['lng']?.toDouble();
  String toString() => //'Place:
  '$name and rating is $rating with $photo_ref';

  /*Place.fromOfflineDb(Map map)
      : name = map["place_name"],
        imagPath = map["image_path"],
        id = map["id"].toString(),
        overview = map["overview"],
        latlng = map["lat_long"],
        favored = false;*/
}
Future<Stream<Place>> getPlaces(double lat, double lng, bool more) async {
  var url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
      //restaurant'+
      //'&keyword=$keyword'+
      if (more && next_page_token != null) {
        url += "?pagetoken=$next_page_token";
      } else {
        url += '?location=$lat,$lng'+'&radius=5000&type=lodging';
      }
      url += '&key=AIzaSyDgObRr_huAXQ-ssfiJoMLpxMiDX_UgsZs';

  /* http.get(url).then(
      (res) => print(res.body)
  );*/

  var client = new http.Client();
  var streamedRes = await client.send(
      new http.Request('get', Uri.parse(url))
  );

  return streamedRes.stream
      .transform(UTF8.decoder)
      .transform(JSON.decoder)
  
  .expand((jsonBody) => (jsonBody as Map) ['results'] )
  .map((jsonPlace) => new Place.fromJson(jsonPlace));
 // .expand((JsonNext) => (JsonNext as Map) ['next_page_token'])
  //.map((jsontoken) => next_page_token = jsontoken)//;

      
    //  .listen( (data) => print(data))
   //  .onDone( () => client.close());
}

Future<Stream<Destination>> getDestinationLoc(String placenm, String country) async {
  var url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$placenm,$country&key=$API_KEY';


  var client = new http.Client();
  var streamedRes = await client.send(
      new http.Request('get', Uri.parse(url))
  );

  return streamedRes.stream
      .transform(UTF8.decoder)
      .transform(JSON.decoder)

      .expand((jsonBody) => (jsonBody as Map) ['results'] )
      .map((jsonDest) => new Destination.fromJson(jsonDest));
  // .expand((JsonNext) => (JsonNext as Map) ['next_page_token'])
  //.map((jsontoken) => next_page_token = jsontoken)//;


  //  .listen( (data) => print(data))
  //  .onDone( () => client.close());
}

class Destination {


  Destination({
    this.id,
    this.placename,
    this.country,
    this.lat,
    this.lng,
    this.imagPath,
    this.overview,
    this.favored,

  });
  String placename, imagPath, overview, country, id;
  double lat, lng;
  bool favored;

  Destination.fromJson(Map json)
      : placename = json["address_components"][0]["long_name"],
        country = json["address_components"][1]["long_name"],
        lat = json["geometry"]["location"]["lat"]?.toDouble(),
        lng = json["geometry"]["location"]["lng"]?.toDouble(),

        imagPath = "",
        id = json["place_id"].toString(),
        overview = "",
        favored = false;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id']= id;
    map['place_name']= placename;
    map['country']= country;
    map['image_path'] = imagPath;
    map['lat'] = lat ;//?.toDouble();
    map['lng'] = lng; //?.toDouble();
    map['overview']= overview;
    map['favored']= favored;
    return map;
  }
  // Made this method to deal with the DB not having bool and using binary instead
  Destination.fromOfflineDb(Map map)
      : id = map["id"],
        placename = map["place_name"],
        country = map["country"],
        imagPath = map["image_path"],
  //  id = map["id"].toString(),
        lat = double.parse(map["lat"]),
        lng = double.parse(map["lng"]),
        overview = map["overview"],
        favored = map["favored"]== 1 ? true : false;
}

Future<Stream<Destination>> getPlacesFromAsset() async {
  return new Stream.fromFuture(rootBundle.loadString('assets/places.json'))
      .transform(json.decoder)
      .expand((jsonBody) => (jsonBody as Map)['results'])
      .map((jsonPlace) => new Destination.fromJson(jsonPlace));
}