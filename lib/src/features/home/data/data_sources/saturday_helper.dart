class SaturdayHelper {
  static DateTime getFriday() {
    var day = 5;
    var now = new DateTime.now();

    while (now.weekday != day) {
      now = now.add(new Duration(days: 1));
    }

    return now;
  }

  static DateTime getSaturday() {
    var day = 6;
    var now = new DateTime.now();

    while (now.weekday != day) {
      now = now.add(new Duration(days: 1));
    }

    return now;
  }
}
