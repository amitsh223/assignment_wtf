import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Util{
  Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 
  return await Geolocator.getCurrentPosition();
}

double? catculateDistance(double lat1,double long1,double lat2,double long2){
  double distanceInMeters = Geolocator.distanceBetween(lat1, long1, lat2, long2);
}


}