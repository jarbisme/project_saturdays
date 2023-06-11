class Sabbath {
  final DateTime startDateTime;
  final DateTime endDateTime;

  Sabbath({
    required this.startDateTime,
    required this.endDateTime,
  });

  toJSONEncodable() {
    Map<String, dynamic> s = new Map();

    s['startDateTime'] = startDateTime.toString();
    s['endDateTime'] = endDateTime.toString();

    return s;
  }
}
