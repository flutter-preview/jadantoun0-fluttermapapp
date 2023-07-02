import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemapsapp/services/api_service.dart';
import '../models/Location.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final Completer<GoogleMapController> _controller = Completer();
  List<Location> locations = [];
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    getData();
  }


  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      locations = await retrieveLocations();
    } catch(error) {
        // dialog to show errorMessage
        showDialog(
          context: context, 
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(error.toString()),
              actions: [
                TextButton(
                  child: const Text('OK'), 
                  onPressed: () => Navigator.of(context).pop()
                )
              ]
            );
          }
        );
    }

    setState(() {
      _isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator(color: Colors.blue))
        : Scaffold(
            appBar: AppBar(
              title: const Text("Locations app"),
            ),
            body: GoogleMap(
              initialCameraPosition: CameraPosition(target: locations[0].toLatLng(), zoom: 9),
              markers: Set<Marker>.from(locations.map((location) {
                return Marker(
                  markerId: MarkerId(location.name) ,
                  position: location.toLatLng()
                );
              }))
              
            ),
          );
  }

}
