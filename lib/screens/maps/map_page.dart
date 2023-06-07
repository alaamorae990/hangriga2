import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ZoneLimitScreen extends StatefulWidget {
  @override
  _ZoneLimitScreenState createState() => _ZoneLimitScreenState();
}

class _ZoneLimitScreenState extends State<ZoneLimitScreen> {
  final double zoneLatitude = 56.032208313635344; // Zone center latitude
  final double zoneLongitude = 14.154133498371024; // Zone center longitude
  final double zoneRadiusInMeters = 10; // Zone radius in meters

  @override
  void initState() {
    super.initState();
    checkZoneLimits();
  }

  Future<void> checkZoneLimits() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
//56.024549, 14.148405
    double distanceInMeters = await Geolocator.distanceBetween(
      56.024549,
      14.148405,
      zoneLatitude,
      zoneLongitude,
    );

    if (distanceInMeters > zoneRadiusInMeters)
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Zone Limit Exceeded'),
            content: Text('Sorry, this site is outside the allowed zone.'),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      else
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('you can order'),
            content: Text('yes, this site is outside the allowed zone.'),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );


    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zone Limit Example'),
      ),
      body: Center(
        child: Text('Your app content here'),
      ),
    );
  }
  }



