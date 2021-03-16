import 'package:geolocator/geolocator.dart';

class Location {

  double longitude;
  double latitude;

  void getPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.'
        );
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      longitude = double.parse(position.longitude.toString());
      latitude = double.parse(position.latitude.toString());
// longitude = double.parse(position.longitude.toStringAsFixed(4));
//       latitude = double.parse(position.latitude.toStringAsFixed(4));

    } catch (e) {}
  }
}
