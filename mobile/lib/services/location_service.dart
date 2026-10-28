import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<String> getCountry() async {
    bool serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return "Location Off";
    }

    LocationPermission permission =
    await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
      await Geolocator.requestPermission();
    }

    Position position =
    await Geolocator.getCurrentPosition(
      desiredAccuracy:LocationAccuracy.high,
    );

    List<Placemark> placemarks =
    await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    return placemarks.first.country ??
        "Unknown";
  }
}