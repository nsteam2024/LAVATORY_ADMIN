import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    hide LatLng;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/web.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../util/value_validator.dart';
import 'custom_alert_dialog.dart';
import 'custom_button.dart';
import 'custom_text_formfield.dart';

class CustomMap extends StatefulWidget {
  final LatLng? selectedLocation;
  const CustomMap({super.key, this.selectedLocation});

  @override
  State<CustomMap> createState() => CustomMapState();
}

class CustomMapState extends State<CustomMap> {
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GoogleMapController? _controller;

  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(11.869233461086624, 75.36959870700144),
    zoom: 14.4746,
  );

  Set<Marker> marker = {};

  @override
  void initState() {
    if (widget.selectedLocation != null) {
      _kGooglePlex = CameraPosition(
        target: widget.selectedLocation!,
        zoom: 14.4746,
      );
      marker = {
        Marker(
          markerId: const MarkerId('selected_marker'),
          position: widget.selectedLocation!,
        ),
      };
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 510,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _latController,
                        validator: latitudeValidator,
                        decoration:
                            InputDecoration(labelText: "Enter Latitude"),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _lngController,
                        validator: longitudeValidator,
                        decoration:
                            InputDecoration(labelText: "Enter Longitude"),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CustomButton(
                      label: 'LatLng',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          double templat =
                              double.parse(_latController.text.trim());
                          double templng =
                              double.parse(_lngController.text.trim());
                          await _controller?.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(templat, templng),
                                zoom: 14.4746,
                              ),
                            ),
                          );
                          marker = {
                            Marker(
                              markerId: const MarkerId('selected_marker'),
                              position: LatLng(templat, templng),
                            ),
                          };
                          setState(() {});
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: CustomButton(
          //     iconData: Icons.search,
          //     label: 'LatLng',
          //     onPressed: () async {
          //       Map? tempLatLng = await showDialog(
          //         context: context,
          //         builder: (context) => const LatLngDialog(),
          //       );
          //       if (tempLatLng != null &&
          //           tempLatLng['lat'] != null &&
          //           tempLatLng['lng'] != null) {
          //         Logger().e(tempLatLng);

          //         await _controller?.animateCamera(
          //           CameraUpdate.newCameraPosition(
          //             CameraPosition(
          //               target: LatLng(tempLatLng['lat'], tempLatLng['lng']),
          //               zoom: 14.4746,
          //             ),
          //           ),
          //         );
          //         marker = {
          //           Marker(
          //             markerId: const MarkerId('selected_marker'),
          //             position: LatLng(tempLatLng['lat'], tempLatLng['lng']),
          //           ),
          //         };
          //         setState(() {});
          //       }
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CustomButton(
              iconData: Icons.search,
              label: 'Search',
              onPressed: () async {
                Map? tempLatLng = await showDialog(
                  context: context,
                  builder: (context) => const MapSearch(),
                );
                if (tempLatLng != null &&
                    tempLatLng['lat'] != null &&
                    tempLatLng['lng'] != null) {
                  Logger().e(tempLatLng);

                  await _controller?.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(tempLatLng['lat'], tempLatLng['lng']),
                        zoom: 14.4746,
                      ),
                    ),
                  );
                  marker = {
                    Marker(
                      markerId: const MarkerId('selected_marker'),
                      position: LatLng(tempLatLng['lat'], tempLatLng['lng']),
                    ),
                  };
                  setState(() {});
                }
              },
            ),
          ),
          if (marker.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CustomButton(
                label: 'View in Google Maps',
                iconData: Icons.map,
                onPressed: () async {
                  String? googleMapLink =
                      "https://www.google.com/maps/search/?api=1&query=${marker.first.position.latitude},${marker.first.position.longitude}";
                  if (await canLaunchUrlString(googleMapLink)) {
                    await launchUrlString(googleMapLink);
                  }
                },
              ),
            ),
          if (marker.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: CustomButton(
                label: 'Save Location',
                iconData: Icons.done,
                onPressed: () {
                  Navigator.pop(context, marker.first.position);
                },
              ),
            ),
        ],
      ),
      body: GoogleMap(
        markers: marker,
        onTap: (LatLng latlng) {
          marker = {
            Marker(
              markerId: const MarkerId('selected_marker'),
              position: latlng,
            )
          };
          setState(() {});
        },
        mapType: MapType.hybrid,
        compassEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}

class MapSearch extends StatefulWidget {
  const MapSearch({super.key});

  @override
  State<MapSearch> createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {
  final TextEditingController _searchController = TextEditingController();
  final FlutterGooglePlacesSdk places =
      FlutterGooglePlacesSdk('AIzaSyCuzNUy2712IWGsruPcHOWErPcfZtmmxGY');
  List<Map> predictions = [];

  Timer? _debounceTimer;

  @override
  void initState() {
    _searchController.addListener(() {
      if (_debounceTimer?.isActive ?? false) {
        _debounceTimer?.cancel();
      }
      if (_searchController.text.trim().isNotEmpty) {
        _debounceTimer = Timer(
          const Duration(seconds: 1),
          () {
            searchPlaces(_searchController.text);
          },
        );
      }
    });
    super.initState();
  }

  void searchPlaces(String query) async {
    final response = await places.findAutocompletePredictions(query);
    predictions = response.predictions
        .map(
          (prediction) =>
              {'name': prediction.primaryText, 'placeId': prediction.placeId},
        )
        .toList();
    setState(() {});
  }

  @override
  void dispose() {
    _debounceTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: "Search",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Search"),
          const SizedBox(
            height: 5,
          ),
          DropdownMenu(
            label: const Text("Search"),
            width: 360,
            controller: _searchController,
            dropdownMenuEntries: List.generate(
              predictions.length,
              (index) => DropdownMenuEntry(
                  value: predictions[index]['placeId'],
                  label: predictions[index]['name']),
            ),
            onSelected: (value) {
              places.fetchPlace(value, fields: [PlaceField.Location]).then(
                  (data) {
                Logger().e(data.place?.latLng);
                Navigator.pop(context, {
                  'lat': data.place?.latLng?.lat,
                  'lng': data.place?.latLng?.lng,
                });
              });
            },
          ),
          const SizedBox(
            height: 350,
          ),
        ],
      ),
    );
  }
}

class LatLngDialog extends StatefulWidget {
  const LatLngDialog({super.key});

  @override
  State<LatLngDialog> createState() => _LatLngDialogState();
}

class _LatLngDialogState extends State<LatLngDialog> {
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: "LatLng",
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Latitude"),
            const SizedBox(
              height: 5,
            ),
            CustomTextFormField(
              prefixIconData: Icons.map,
              labelText: "Enter Latitude",
              controller: _latController,
              validator: latitudeValidator,
              isLoading: false,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Longitude"),
            const SizedBox(
              height: 5,
            ),
            CustomTextFormField(
              isLoading: false,
              prefixIconData: Icons.map,
              labelText: "Enter Longitude",
              controller: _lngController,
              validator: longitudeValidator,
            ),
          ],
        ),
      ),
      secondaryButton: 'Reset',
      primaryButton: 'Save',
      onPrimaryPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.pop(context, {
            'lat': double.parse(_latController.text.trim()),
            'lng': double.parse(_lngController.text.trim()),
          });
        }
      },
      onSecondaryPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
