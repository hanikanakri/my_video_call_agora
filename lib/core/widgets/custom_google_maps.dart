import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMaps extends StatefulWidget {
  final LatLng initPosition;
  final ArgumentCallback<LatLng>? onTap;
  final Marker? marker;
  final ValueChanged<GoogleMapController>? controllerMap;
  const CustomGoogleMaps({
    Key? key,
    required this.initPosition,
    this.onTap,
    this.marker,
    this.controllerMap,
  }) : super(key: key);

  @override
  State<CustomGoogleMaps> createState() => CustomGoogleMapsState();
}

class CustomGoogleMapsState extends State<CustomGoogleMaps> {
  final Completer<GoogleMapController> _controller = Completer();
  late List<Marker> _markers = <Marker>[];

  late CameraPosition kInitCameraPosition;

  @override
  void initState() {
    if (widget.marker != null) {
      _markers = <Marker>[widget.marker!];
    } else {
      _markers = <Marker>[];
    }

    super.initState();
    kInitCameraPosition = CameraPosition(
      target: widget.initPosition,
      zoom: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildGoogleMap();
  }

  buildGoogleMap() {
    return AspectRatio(
      aspectRatio: 400 / 200,
      child: GoogleMap(
        initialCameraPosition: kInitCameraPosition,
        scrollGesturesEnabled: true,
        zoomControlsEnabled: true,
        rotateGesturesEnabled: true,
        compassEnabled: true,
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: true,
        mapType: MapType.normal,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          widget.controllerMap!(controller);
        },
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<PanGestureRecognizer>(() => PanGestureRecognizer()),
          Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
          Factory<TapGestureRecognizer>(() => TapGestureRecognizer()),
          Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer()),
        },
          /*gestureRecognizers: Set()
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
            ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
            ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),*/
        markers: Set<Marker>.of(_markers),
        onTap: (LatLng latLng) async {
          widget.onTap!(latLng);
          _markers = <Marker>[];
          _markers.add(
              Marker(markerId: MarkerId("index$latLng"), position: latLng));
          setState(() {});
        },
      ),
    );
  }
}
