import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_swish_payment/flutter_swish_payment.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:uuid/uuid.dart';
import 'package:google_api_headers/google_api_headers.dart';
import '../../consts/contss.dart';
import '../../widgets/back_widget.dart';
import '../cart/cart2/cart_show.dart';
import '../payment/make_payment_delivery.dart';
import 'Services/location_services.dart';
import 'Services/polyline_services.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_webservice/places.dart';
class MapScreen extends StatefulWidget {
  final double long;
  final double laut;
  final SwishClient swishClient;
  const MapScreen({Key? key, required this.long, required this.laut, required this.swishClient}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final loc.Location location = loc.Location();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Constants.apiKey);
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _initialCameraPosition;
  LatLng currentLocation = LatLng(0, 0);
  BitmapDescriptor? _locationIcon;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  Set<Circle> _circles = {};
  final double zoneLatitude = 56.031510438310555; // Zone center latitude
  final double zoneLongitude = 14.153970338463237; // Zone center longitude
  final double zoneRadiusInMeters = 10000; // Zone radius in meters
  bool _isLoading = false;
  @override
  void initState() {
    _initialCameraPosition = CameraPosition(
      target: LatLng(widget.laut, widget.long),
      zoom: 14.4746,
    );

    _buildMarkerFromAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const SizedBox(
            width: 300,
          ),
          IconButton(
            onPressed: () {
              _showSearchDialog(context);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            mapType: MapType.normal,
            onMapCreated: (controller) async {
              String style = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
              //customize your map style at: https://mapstyle.withgoogle.com/
              controller.setMapStyle(style);
              _controller.complete(controller);
            },
            onCameraMove: (e) => currentLocation = e.target,
            markers: _markers,
            polylines: _polylines,
            circles: _circles, // Added circles
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset(
              'assets/images/location_icon.png',
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         _isLoading? FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: (){
              Navigator.of(context).push(

                MaterialPageRoute(
                  builder: (BuildContext context) => MakePaymentDeliv(
                    selectedLocation: currentLocation,
                     swishClient: widget.swishClient,
                    markers: _markers,
                  ),
                ),
              );
            },
            child: Icon(Icons.check_circle_rounded),
          ):SizedBox.shrink(),
          SizedBox(height: 30,),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () => _setMarker(currentLocation),
            child: Icon(Icons.location_on),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 20,
        alignment: Alignment.center,
        child: Text(
          "lat: ${currentLocation.latitude}, long: ${currentLocation.longitude}",
        ),
      ),
    );
  }

  Marker? _marker;

  void _setMarker(LatLng _location) {
    if (_marker != null) {
      // If a marker already exists, remove it from the map
      _markers.remove(_marker);
    }

    double distanceInMeters = Geolocator.distanceBetween(
      _location.latitude,
      _location.longitude,
      zoneLatitude,
      zoneLongitude,
    );

    Marker newMarker = Marker(
      markerId: MarkerId(_location.toString()),
      icon: BitmapDescriptor.defaultMarker,
      position: _location,
      infoWindow: InfoWindow(
        title: "Title",
        snippet: "${_location.latitude}, ${_location.longitude}",
      ),
    );

    if (distanceInMeters > zoneRadiusInMeters) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //Zone Limit Exceeded
            title: Text('Zongränsen har överskridits'),
            //Sorry, this site is outside the allowed zone.
            content: Text('Tyvärr, den här webbplatsen är utanför den tillåtna zonen..'),
            actions: [
              FlatButton(
                child: Text('Okej'),
                onPressed: () {
                  setState(() {
                    _isLoading=false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //You can order
            title: Text('Du kan beställa'),
            //Yes, this site is within the allowed zone.
            content: Text('Ja, den här webbplatsen ligger inom den tillåtna zonen..'),
            actions: [
              FlatButton(
                child: Text('Okej'),
                onPressed: () {
                  setState(() {
                    _isLoading=true;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    _marker = newMarker; // Set the current marker to the new marker
    _markers.add(newMarker);
    setState(() {});
  }

  Future<void> _buildMarkerFromAssets() async {
    if (_locationIcon == null) {
      _locationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)),
        'assets/images/location_icon.png',
      );
      setState(() {});
    }
  }

  Future<void> _showSearchDialog(BuildContext context) async {
    final sessionToken = Uuid().v4();// Generate a unique session token for each autocomplete request

    try {
      Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: Constants.apiKey,
        mode: Mode.overlay,
        language: "en",
        components: [
          Component(Component.country, "SE"),
        ],
        types: ['(regions)'],
        sessionToken: sessionToken,
      );

      if (p != null) {
        PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);

        _animateCamera(
          LatLng(
            detail.result.geometry!.location.lat,
            detail.result.geometry!.location.lng,
          ),
        );

        // Update the UI with the selected place details
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(detail.result.name ?? ''),
              content: Text(detail.result.formattedAddress ?? ''),
              actions: [
                FlatButton(
                  child: Text('Save'),
                  onPressed: () {
                    // Save the location or perform any desired action
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error occurred during search: $e');
      // Handle any errors that occur during the search process
    }
  }




  Future<void> _getLocationFromPlaceId(String placeId) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: Constants.apiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);

    _animateCamera(
      LatLng(
        detail.result.geometry!.location.lat,
        detail.result.geometry!.location.lng,
      ),
    );
  }

  Future<void> _getMyLocation() async {
    LocationData _myLocation = await LocationService().getLocation();
    _animateCamera(
      LatLng(_myLocation.latitude!, _myLocation.longitude!),
    );
  }

  Future<void> _animateCamera(LatLng _location) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _cameraPosition = CameraPosition(
      target: _location,
      zoom: 13.00,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }
}
