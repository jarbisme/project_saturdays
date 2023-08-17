class SaturdayHelper {
  static DateTime getFriday() {
    var day = 5;
    var now = DateTime.now();

    while (now.weekday != day) {
      now = now.add(const Duration(days: 1));
    }

    return now;
  }

  static DateTime getSaturday() {
    var day = 6;
    var now = DateTime.now();

    while (now.weekday != day) {
      now = now.add(const Duration(days: 1));
    }

    return now;
  }
}
