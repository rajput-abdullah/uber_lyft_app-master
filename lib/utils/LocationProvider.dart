import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider {

  int distance;

  LocationAccuracy locationAccuracy;

  LocationProvider({this.locationAccuracy=LocationAccuracy.high,this.distance=10});

  Future<Position> provideLastKnownLocation() async {
    return await Geolocator.getLastKnownPosition();
  }

  Future<Position> provideCurrentLocation() async {
    Position _position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    if (_position == null) {
      _position = await provideLastKnownLocation();
    }
    return _position;
  }


  provideLocationStream(Function listener) {
    var geolocator = Geolocator();
    var locationOptions =
    LocationSettings(
      accuracy: locationAccuracy,
      distanceFilter: distance,
    );

    //StreamSubscription<Position> positionStream =
    // geolocator.getPositionStream(locationOptions).listen((Position position) {
    //   if (position != null) listener(position);
    // });
    Geolocator.getPositionStream(locationSettings: locationOptions).listen(
            (Position position) {
          print(position == null ? 'Unknown' : '${position.latitude.toString()}, ${position.longitude.toString()}');
        });

    /*var myResult = "";
    mySlowMethod((result) {
      myResult = result;
      print(myResult);
    });*/
  }

  Future<bool> checkForLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled =
        await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;
    return true;
  }

  // Future<placemarkFromAddress > getLocationFromAddress(String address) async {
  //   List<Placemark> placemark =
  //       await placemarkFromCoordinates(address);
  //   if (placemark != null && !placemark.isEmpty) return placemark.removeLast();
  //   return null;
  // }

  Future<Placemark> getAddressFromLocation(double lat, double lon) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(lat, lon);
    if (placemark != null && !placemark.isEmpty) return placemark.removeLast();
    return null;
  }
}
