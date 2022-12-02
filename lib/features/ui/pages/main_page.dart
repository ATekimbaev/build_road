import 'dart:async';

import 'package:build_route/features/ui/bloc/get_directions_bloc.dart';
import 'package:build_route/features/ui/pages/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _MainPageState extends State<MainPage> {
  double latStart = 42.882004;
  double lngStart = 74.582748;
  double latEnd = 42.882004;
  double lngEnd = 74.582748;
  Map<PolylineId, Polyline> polylines = {};
  final String apiKey = 'AIzaSyDEeVdpmfjk8uA6Xa76rV68JtR6zbFq0Bg';
  final Mode mode = Mode.overlay;
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Polyline> _polyline = <Polyline>{};
  int _polylineIdCounter = 1;

  final CameraPosition bishkek = const CameraPosition(
    target: LatLng(42.882004, 74.582748),
    zoom: 14.4746,
  );

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdValue = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;
    _polyline.add(
      Polyline(
        polylineId: PolylineId(polylineIdValue),
        width: 2,
        color: Colors.green,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> markers = <Marker>{
      Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Start'),
        markerId: const MarkerId('start'),
        position: LatLng(latStart, lngStart),
      ),
      Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'End'),
        markerId: const MarkerId('End'),
        position: LatLng(latEnd, lngEnd),
      ),
    };
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: const Text('Build Route'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: _handlePressButtonStart,
                      child: const Text('Start adress'),
                    ),
                    ElevatedButton(
                      onPressed: _handlePressButtonEnd,
                      child: const Text('end adress'),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  var directions = await LocationService()
                      .getDirections('$latStart,$lngStart', '$latEnd,$lngEnd');

                  _goToPlace(
                    directions['start_location']['lat'],
                    directions['start_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );
                  _setPolyline(directions['polyline_decoded']);
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          Expanded(
            child: GoogleMap(
              markers: markers,
              polylines: _polyline,
              mapType: MapType.normal,
              initialCameraPosition: bishkek,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(
    double lat,
    double lng,
    Map<String, dynamic> boudnsNe,
    Map<String, dynamic> boudnsSw,
  ) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            lat,
            lng,
          ),
          zoom: 16,
        ),
      ),
    );
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(boudnsSw['lat'], boudnsSw['lng']),
              northeast: LatLng(boudnsNe['lat'], boudnsNe['lng'])),
          25),
    );
  }

  Future<void> _handlePressButtonStart() async {
    Prediction? p = await PlacesAutocomplete.show(
      components: [Component(Component.country, 'kg')],
      startText: 'Bishkek,',
      types: [''],
      context: context,
      apiKey: apiKey,
      onError: onError,
      mode: mode,
      language: 'en',
      strictbounds: false,
      decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white))),
    );
    displayPredictionStart(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse resonse) {}
  Future<void> displayPredictionStart(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: apiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    latStart = lat;
    lngStart = lng;

    setState(() {});
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }

  Future<void> _handlePressButtonEnd() async {
    Prediction? p = await PlacesAutocomplete.show(
      components: [Component(Component.country, 'kg')],
      startText: 'Bishkek,',
      types: [''],
      context: context,
      apiKey: apiKey,
      onError: onError,
      mode: mode,
      language: 'en',
      strictbounds: false,
      decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white))),
    );
    displayPredictionStart(p!, homeScaffoldKey.currentState);
  }

  Future<void> displayPredictionEnd(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: apiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    latEnd = lat;
    lngEnd = lng;

    setState(() {});
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }
}
