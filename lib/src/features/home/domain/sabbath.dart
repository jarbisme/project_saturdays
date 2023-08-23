enum Source {
  remote,
  local,
}

class Sabbath {
  final DateTime startDateTime;
  final DateTime endDateTime;
  final Source source;

  Sabbath({
    required this.startDateTime,
    required this.endDateTime,
    required this.source,
  });

  toJSONEncodable() {
    Map<String, dynamic> s = new Map();

    s['startDateTime'] = startDateTime.toString();
    s['endDateTime'] = endDateTime.toString();
    s['source'] = source.toString();

    return s;
  }
}
