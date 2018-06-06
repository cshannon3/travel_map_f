import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travel_map_f/models/Places.dart';
import 'dart:async';
import 'dart:io';

import '../models/models.dart';


class TravelDatabase{
  // want to create an instance of our movie db inside our moviedb class
  static final TravelDatabase _instance = TravelDatabase._internal();
  //factory allows you to create many instances of your database
  factory TravelDatabase() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  TravelDatabase._internal();

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDB = await openDatabase(path, version: 4, onCreate: _onCreate);
    return theDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE Destinations(id STRING PRIMARY KEY, place_name TEXT, country TEXT, image_path TEXT, lat REAL, lng REAL, overview TEXT, favored BIT )''');
    //image_path TEXT, lat TEXT, lng TEXT, overview TEXT
   /* await db.execute(
        '''"CREATE TABLE Lodging(id STRING PRIMARY KEY, Destintions_id STRING, place_name TEXT, price TEXT, rating REAL, image_path TEXT, site_link TEXT, overview TEXT, favored BIT)"''');

    await db.execute(
        '''"CREATE TABLE Routes(id STRING PRIMARY KEY, place_name TEXT, country TEXT, image_path TEXT, lat_long TEXT, overview TEXT, favored BIT)"''');

    await db.execute(
        '''"CREATE TABLE Events(id STRING PRIMARY KEY, place_name TEXT, country TEXT, image_path TEXT, lat_long TEXT, overview TEXT, favored BIT)"''');

*/
    print("Database was Created!");
  }
// Get
  Future<List<Destination>> getDestinations() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Destinations");
    return res.map((m) => Destination.fromOfflineDb(m)).toList();
  }

  Future<Destination> getDestination(String placename) async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Destinations", where: "place_name = ?", whereArgs: [placename]);
    if (res.length == 0) return null;
    return Destination.fromOfflineDb(res[0]);
  }

 /* Future<List<Place>> getPlaces() async {
    var dbClient = await db;
    List<Map> res = await dbClient.query("Lodging");
    return res.map((m) => Place.fromOfflineDb(m)).toList();

  }*/

  Future<int> addDest(Destination dest) async  {
    var dbClient = await db;
    try {
      print("Dest");
      int res = await dbClient.insert("Destinations", dest.toMap());
      print("Destination Added $res");
      return res;
    }catch (e) {
      int res = await updateDestination(dest);
      return res;
    }
  }


  Future<int> updateDestination(Destination dest) async{
    var dbClient = await db;
    var res = await dbClient
        .update("Destinations", dest.toMap(), where: "id = ?", whereArgs: [dest.id]);
    print("Dest Updated $res");
    return res;
  }
  Future<int> deleteDes() async{
    var dbClient = await db;
    var res = await dbClient.delete("Destinations", where: "lat = ?", whereArgs: ["44.119371"]);
    print("Destination Deleted $res");
    return res;
  }

  Future<int> deleteDest(String placeid) async{
    var dbClient = await db;
    var res = await dbClient.delete("Destinations", where: "id = ?", whereArgs: [placeid]);
    print("Destination Deleted $res");
    return res;
  }

  Future closeDb() async {
    var dbClient = await db;
    dbClient.close();
  }

}