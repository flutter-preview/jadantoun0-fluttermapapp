import 'dart:convert';
import 'package:googlemapsapp/models/Location.dart';
import 'package:http/http.dart' as http;


const String baseUrl = "http://192.168.1.9:3001";


Future<List<Location>> retrieveLocations() async { 

  final http.Response response = await http.get(Uri.parse("$baseUrl/locations"));

  if (response.statusCode == 200) {

    final data = response.body;

    List<dynamic> jsonArray = jsonDecode(data); 

    List<Location> locations = [];
    for (var json in jsonArray) {
      Map<String, dynamic> locationJson = json; // parsing json from dynamic to Map
      Location location = Location.fromJson(locationJson);
      locations.add(location);
    }

    return locations; 
  } 
  else {
    final errorData = jsonDecode(response.body);
    final String errorMessage = errorData["errorMessage"];
    throw Exception(errorMessage);
  }

}