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

  Map<String, dynamic> toJson() {
    return {
      'startDateTime': startDateTime.toIso8601String(),
      'endDateTime': endDateTime.toIso8601String(),
      'source': source.name,
    };
  }

  factory Sabbath.fromJson(Map<String, dynamic> json) {
    return Sabbath(
      startDateTime: DateTime.parse(json['startDateTime']),
      endDateTime: DateTime.parse(json['endDateTime']),
      source: Source.values.firstWhere(
        (e) => e.name == json['source'],
        orElse: () => Source.local,
      ),
    );
  }

  Sabbath copyWith({
    DateTime? startDateTime,
    DateTime? endDateTime,
    Source? source,
  }) {
    return Sabbath(
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      source: source ?? this.source,
    );
  }
}
