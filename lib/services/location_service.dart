import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/common/ui.dart';
class LocationService extends GetxService{
  final currentLocation = {}.obs;
  final locationAddress = "".obs;
  void onInit() async {
    print('called');

    determinePosition();

    super.onInit();
  }
  Future<Map> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: 'Please enable location permission'.tr, title: 'Error'.tr));
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position =
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude,
        localeIdentifier: "en");
    Placemark place = placemarks[0];
    String city = '${place.locality == '' ? place.administrativeArea : place.locality}';
    String locality = '${place.locality == '' ? place.subLocality : place.subLocality}';
    String adminastritive = '${place.locality == '' ? place.subAdministrativeArea : place.subAdministrativeArea}';
    String local = '${place.locality == '' ? place.locality : place.locality}';
    String street = '${place.locality == '' ? place.street : place.street}';
    String name = '${place.locality == '' ? place.name : place.name}';
    Map m = {
      'lat': position.latitude,
      'lng': position.longitude,
      'city': city,
      'local' : local,
      'locality': locality,
      'sub' : adminastritive,
      'street' : street,
      'name': name
    };
    currentLocation.value = m;
    locationAddress.value = currentLocation.value['street'] +" "+currentLocation.value['city'];
    return m;
  }
}

