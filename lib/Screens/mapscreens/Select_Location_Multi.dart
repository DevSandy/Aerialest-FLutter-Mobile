import 'dart:async';

import 'package:aerial_est_mobile/Utils/aecolors.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../params_screen/service_multi_params.dart';
class Select_Location_Multi extends StatefulWidget {
  Select_Location_Multi(this.servicedata,this.address, this.locations,{Key? key}) : super(key: key);

  Map servicedata;
  String address;
  List<Location> locations;
  @override
  _Select_Location_MultiState createState() => _Select_Location_MultiState();
}

class _Select_Location_MultiState extends State<Select_Location_Multi> {

  Completer<GoogleMapController> _controller = Completer();
  static LatLng _center = const LatLng(45.521563, -122.677433);
  // static const LatLng _center = const LatLng(45.521563, -122.677433);
  Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.satellite;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _center = LatLng(widget.locations[0].latitude, widget.locations[0].longitude);
    setState(() {});
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }


  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
            onTap: (){
              deletemarker(
                  Marker(
                    // This marker id can be anything that uniquely identifies each marker.
                    markerId: MarkerId(_lastMapPosition.toString()),
                    position: _lastMapPosition,
                    infoWindow: InfoWindow(
                        title: "Location : "+(_markers.length+1).toString(),
                        snippet: "Delete"
                    ),
                    icon: BitmapDescriptor.defaultMarker,
                  )
              );
            },
            title: "Location : "+(_markers.length+1).toString(),
            snippet: "Delete"
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void deletemarker(Marker marker) {
    _markers.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Locations'),
        backgroundColor: aecolors.primary,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            rotateGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 18.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          GestureDetector(
              onTap: _onAddMarkerButtonPressed ,
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.add,size: 50,color: Colors.white,),
                      Text('Drag To Move And Click To Mark',style: TextStyle(backgroundColor: Colors.white70,wordSpacing: 2,letterSpacing: 2),),
                    ],
                  ))),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: FloatingActionButton(
                      onPressed: (){
                        print(_markers.length);
                        _controller.isCompleted;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Service_multi_params(widget.servicedata,widget.address,widget.locations,_markers)),
                        );
                      },
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: aecolors.primary,
                      child: const Icon(Icons.arrow_forward_outlined, size: 36.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
