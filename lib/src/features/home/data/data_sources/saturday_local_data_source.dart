import 'package:localstorage/localstorage.dart';
import 'package:project_saturdays/src/features/home/data/data_sources/saturday_helper.dart';
import 'package:project_saturdays/src/features/home/domain/sabbath.dart';

class SaturdayLocalDataSource {
  final LocalStorage storage = LocalStorage('saturdays');

  Future<Sabbath?> getSabbath() async {
    final sabbath = storage.getItem('sabbath');
    var startDateTime = _formatCurrentDate(SaturdayHelper.getFriday(), DateTime.parse(sabbath['startDateTime']));
    var endDateTime = _formatCurrentDate(SaturdayHelper.getSaturday(), DateTime.parse(sabbath['endDateTime']));

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

  void saveSabbath(Sabbath sabbath) async {
    storage.setItem('sabbath', sabbath.toJSONEncodable());
  }

  DateTime _formatCurrentDate(DateTime date, DateTime time) {
    return DateTime.utc(date.year, date.month, date.day, time.hour, time.minute, time.second);
  }
}
