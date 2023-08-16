// ignore_for_file: camel_case_types, library_private_types_in_public_api, file_names, unused_import, override_on_non_overriding_member, prefer_typing_uninitialized_variables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; // Make sure to import the correct package
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Road_Information extends StatefulWidget {
  const Road_Information({Key? key}) : super(key: key);


  @override
  _Road_InformationState createState() => _Road_InformationState();
}

class _Road_InformationState extends State<Road_Information> {
  late GoogleMapController mapController;
  var test;
  late List<Placemark> placemarks;

  LatLng _center = const LatLng(25.1755, 121.4407);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  void initState() {
    super.initState();
 // Call the location function to get user's location
  }
    @override
  Widget build(BuildContext context) {
    return test2(context);
  }

  @override
  Widget test2(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
//        
      ),
    );
  }

  @override
  Widget test1(BuildContext context) {
    return const Scaffold(
      body:Text('sss') 
//        
      
    );
  }
}


