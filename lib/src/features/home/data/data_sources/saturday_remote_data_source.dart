import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project_saturdays/src/features/home/domain/sabbath.dart';

import 'saturday_helper.dart';

class SaturdayRemoteDataSource {
  static const sunriseSunsetURL = 'https://api.sunrise-sunset.org/json';

  Future<Sabbath?> getSabbath() async {
    DateTime? friday;
    DateTime? saturday;

    final formatter = DateFormat('yyyy-MM-dd');

    try {
      friday = await _getSunset(formatter.format(SaturdayHelper.getFriday()));
      saturday = await _getSunset(formatter.format(SaturdayHelper.getSaturday()));

      if (friday != null && saturday != null) {
        Sabbath sabbath = Sabbath(startDateTime: friday!, endDateTime: saturday!);
        return sabbath;
      } else {
        // throw Exception('Error');
        return null;
      }
    } catch (e) {
      // throw Exception('Error: $e');
      return null;
    }
  }

  Future<DateTime?> _getSunset(String date) async {
    // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    Position position = await _determinePosition();

    final response = await http
        .get(Uri.parse('$sunriseSunsetURL?lat=${position.latitude}&lng=${position.longitude}&date=$date&formatted=0'));

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DateTime.parse(data['results']['sunset']);
      }
    } catch (e) {
      print(e);
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
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
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
