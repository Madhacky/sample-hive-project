import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoLocation extends StatefulWidget {
  List apiDataArray = [];
  GeoLocation(this.apiDataArray, {Key? key}) : super(key: key);

  @override
  _GeoLocationState createState() => _GeoLocationState();
}

class _GeoLocationState extends State<GeoLocation> {
  Completer<GoogleMapController> _controller = Completer();
  var coords;
// on below line we have specified camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(17.422278747662556, 78.38183384724246),
    zoom: 16.4746,
  );

// on below line we have created the list of markers
  late List<Marker> dataMarkers = widget.apiDataArray.map<Marker>((value) {
    List<double> coords = value['BU_DH_CUST_COL34']
        .split(',')
        .map<double>((c) => double.parse(c))
        .toList();
    return Marker(
      markerId: MarkerId(value['RECORD_NO']),
      position: LatLng(coords[0], coords[1]),
    );
  }).toList();
  /*void _updatePosition(CameraPosition _position) {
    Position newMarkerPosition = Position(
        latitude: _position.target.latitude,
        longitude: _position.target.longitude);
    Marker marker = markers["1"];

    setState(() {
      markers["1"] = marker.copyWith(
          positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
    });
  }*/

// created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  titleAppBar() {
    String coordsArg = '';
    if (coords != null)
      coordsArg =
          'location: (${coords.latitude.toStringAsFixed(7)},${coords.longitude.toStringAsFixed(7)})';
    return Text(coordsArg);
  }

  void initState() {
    super.initState();
    print(widget.apiDataArray.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF0F9D58),
        // on below line we have given title of app
        title: titleAppBar(),
      ),
      body: Container(
        child: SafeArea(
          // on below line creating google maps
          child: GoogleMap(
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            // on below line we are setting markers on the map
            markers: Set<Marker>.of(dataMarkers),
            // on below line specifying map type.
            mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,

            //onCameraMove: ((_position) => _updatePosition(_position)),

            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
      // on pressing floating action button the camera will take to user current location
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getUserCurrentLocation().then((value) async {
            print(value.latitude.toString() + " " + value.longitude.toString());
            // marker added for current users location
            dataMarkers.add(
              Marker(
                markerId: MarkerId("2"),
                draggable: true,
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(
                  title: 'My Current Location',
                ),
              ),
            );
            print(value.latitude.toString() + " " + value.longitude.toString());

            // specified current users location
            CameraPosition cameraPosition = new CameraPosition(
              target: LatLng(value.latitude, value.longitude),
              zoom: 16,
            );

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: Icon(Icons.local_activity),
      ),
    );
  }
  /*void _updatePosition(CameraPosition) {
    Position newMarkerPosition = LatLng as Position;
    Marker marker = dataMarkers as Marker;

    setState(() {
      marker = marker.copyWith(
          positionParam: LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
    });
  }*/
}
