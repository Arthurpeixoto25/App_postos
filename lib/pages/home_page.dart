import 'dart:async';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_map_tracker/controllers/postos_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({Key ? key}) : super (key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State <HomePage> {

  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init(){
    _cameraPosition = CameraPosition(target: LatLng(11.576262, 104.92222), zoom: 15
    );
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body:ChangeNotifierProvider<PostosController>(
        create: (context) => PostosController(),
        child: Builder(builder:(context){
             return _buildBody();
        })
      )
    );
  }

  Widget _buildBody(){
    return _getMap();
  }

  Widget _getMap() {
  return Consumer<PostosController>(
    builder: (context, local, child) {
      return GoogleMap(
        initialCameraPosition: _cameraPosition!,
        mapType: MapType.normal,
        myLocationEnabled: true,
        markers: local.markers,
        onMapCreated: (GoogleMapController controller) {
          if (!_googleMapController.isCompleted) {
            _googleMapController.complete(controller);
          }
        },
      );
    },
  );
}

}