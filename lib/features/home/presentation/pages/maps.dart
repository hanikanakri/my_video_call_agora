import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_video_call_agora/features/home/presentation/widgets/general_home_scaffold.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({
    Key? key,
  }) : super(key: key);

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  @override
  void initState() {
    super.initState();
    isLocation();
  }

  bool location = true;
  late double lat;
  late double long;

  Future isLocation() async {
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).then((value) {
      print(value);
      setState(() {
        lat = value.latitude;
        long = value.longitude;
        location = false;
      });
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return GeneralHomeScaffold(
      body: location
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  lat,
                  long,
                ),
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
      /*floatingActionButton: FloatingActionButton.extended(
          onPressed: (){},
          label: const Text('To the lake!'),
          icon: const Icon(Icons.directions_boat),
        ),*/
    );
  }
}
