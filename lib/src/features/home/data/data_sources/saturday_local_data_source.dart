import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:project_saturdays/src/features/home/domain/sabbath.dart';

class SaturdayLocalDataSource {
  static const String _sabbathKey = 'sabbath';

  Future<Sabbath?> getSabbath() async {
    final sabbathData = localStorage.getItem(_sabbathKey);

    if (sabbathData != null) {
      return _fromLocalStorage(sabbathData);
    }

    return null;
  }

  Future<void> saveSabbath(Sabbath sabbath) async {
    localStorage.setItem(_sabbathKey, _toLocalStorage(sabbath));
  }

  /// Converts JSON string from local storage to Sabbath model
  Sabbath _fromLocalStorage(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);

    var startDateTime = DateTime.parse(json['startDateTime']);
    var endDateTime = DateTime.parse(json['endDateTime']);

    // If the startDateTime is after endDateTime, we need to subtract 7 days
    if (startDateTime.isAfter(endDateTime)) {
      startDateTime = startDateTime.subtract(const Duration(days: 7));
    }

    // If the endDateTime is NOT after now; meaning that it's a past sabbath, we need to get next week's sabbath
    if (!endDateTime.isAfter(DateTime.now())) {
      startDateTime = startDateTime.add(const Duration(days: 7));
      endDateTime = endDateTime.add(const Duration(days: 7));
    }

    return Sabbath(
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      source: Source.local,
    );
  }

  /// Converts Sabbath model to JSON string for local storage
  String _toLocalStorage(Sabbath sabbath) {
    return jsonEncode(sabbath.toJson());
  }
}
