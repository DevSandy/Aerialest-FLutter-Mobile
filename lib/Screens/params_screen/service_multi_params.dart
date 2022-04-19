import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Service_multi_params extends StatefulWidget {
  Service_multi_params(this.servicedata, this.address, this.locations, this.markers, {Key? key}) : super(key: key);
  Map servicedata;
  String address;
  List<Location> locations;
  Set<Marker> markers;
  @override
  _Service_multi_paramsState createState() => _Service_multi_paramsState();
}

class _Service_multi_paramsState extends State<Service_multi_params> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
