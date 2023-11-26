import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../utils/navigation.dart';
import '../utils/shared_storage.dart';
import 'buttons/main_elevated_button.dart';
import 'custom_google_maps.dart';
 import 'package:google_maps_webservice/places.dart';

class AddressSelection extends StatefulWidget {
  const AddressSelection({
    Key? key,
    required this.onMarkerSelected,
    this.initialLat,
    this.initialLong,
  }) : super(key: key);
  final Function(LatLng) onMarkerSelected;
  final double? initialLat;
  final double? initialLong;

  @override
  State<AddressSelection> createState() => _AddressSelectionState();
}

class _AddressSelectionState extends State<AddressSelection> {
  LatLng? selectedLocation;
  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: 'AIzaSyDySfX1lMgwJqgptq44BrdwEAuUOsGj_jQ');
  final TextEditingController controller = TextEditingController();
  GoogleMapController? googleMapController;

  void setSelectedAddress({String? address, LatLng? latLng}) async {
    final response = await _places.autocomplete(address!);
    print("addressaddress");
    print(address);
    print(response.status);
    print(response.predictions.isNotEmpty);
    if (response.status == 'OK' && response.predictions.isNotEmpty) {
      final prediction = response.predictions.first;
      final placeDetails =
          await _places.getDetailsByPlaceId(prediction.placeId!);
      print("sssssssssssssssssss");
      print(placeDetails.status);
      if (placeDetails.status == 'OK') {
        final latLng = placeDetails.result.geometry!.location;
        print("ddddddddddddaaaaaaaddddddddddeeeeeee");
        print(latLng.lat);
        print(latLng.lng);
        setState(() {
          selectedLocation = LatLng(latLng.lat, latLng.lng);
          googleMapController!
              .animateCamera(CameraUpdate.newLatLngZoom(selectedLocation!, 8));
          controller.text = address;
        });
      }
    } else if (response.status == 'ZERO_RESULTS') {
      try {
        List<Placemark> placemarks =
            await GeocodingPlatform.instance.placemarkFromCoordinates(
          latLng!.latitude,
          latLng.longitude,
          localeIdentifier: "en_US",
        );
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;

          controller.text = placemark.locality!;
          if (placemark.locality!.isEmpty) {
            controller.text = placemark.administrativeArea!;
          }
          print("fffffffffffffff");
          print(controller.text);
          print(placemark.locality);
          print(placemark.administrativeArea);
        }
      } on PlatformException catch (e) {
        print('Error getting location: ${e.message}');
      }
    } else {
      controller.text = 'Error: Unable to retrieve address';
    }
  }

  @override
  Widget build(BuildContext context) {
    print("selectedLocationdddddddddddddddd");
    print(selectedLocation);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: AppColors.transparent,
              padding: const EdgeInsets.all(16.0),
              child: Scrollable(
                viewportBuilder:
                    (BuildContext context, ViewportOffset position) =>
                        TypeAheadFormField<Prediction>(
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: AppStyles.inputDecoration.copyWith(
                      hintText: 'search'.tr(),
                    ),
                    controller: controller,
                  ),
                  suggestionsCallback: (pattern) async {
                    PlacesAutocompleteResponse response =
                        await _places.autocomplete(pattern,
                            language: SharedStorage
                                .getLanguage() // Replace with your desired latitude and longitude
                            );

                    return response.predictions;
                  },
                  itemBuilder: (context, Prediction suggestion) {
                    return ListTile(
                        onTap: () {
                          print("ddddd");
                          setState(() {
                            setSelectedAddress(
                                address: suggestion.description!);
                          });
//                          controller.text = suggestion.description!;
                        },
                        title: Text(suggestion.description!));
                  },
                  onSuggestionSelected: (Prediction suggestion) {
                    print("ddddddddddddddddddddddddddd");

                    setSelectedAddress(address: suggestion.description!);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 35,
              child: CustomGoogleMaps(
                controllerMap: (controller) {
                  setState(() {
                    googleMapController = controller;
                  });
                },
                onTap: (latLng) async {
                  setState(() {
                    final location = '${latLng.latitude}, ${latLng.longitude}';
                    setSelectedAddress(latLng: latLng, address: location);
                    widget.onMarkerSelected(latLng);
                  });
                },
                initPosition:
                    selectedLocation ?? const LatLng(25.276987, 55.296249),
                marker: Marker(
                    markerId: const MarkerId('marketId'),
                    position: (widget.initialLat != null &&
                            widget.initialLong != null)
                        ? LatLng(widget.initialLat!, widget.initialLong!)
                        : const LatLng(25.276987, 55.296249)),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            MainElevatedButton(
              text: 'Continue',
              onPressed: () {
                Navigation.pop(context);
              },
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
