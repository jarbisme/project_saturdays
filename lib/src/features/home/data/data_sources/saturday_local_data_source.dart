import 'package:localstorage/localstorage.dart';
import 'package:project_saturdays/src/features/home/data/data_sources/saturday_helper.dart';
import 'package:project_saturdays/src/features/home/domain/sabbath.dart';

class SaturdayLocalDataSource {
  final LocalStorage storage = LocalStorage('saturdays');

  Future<Sabbath?> getSabbath() async {
    final sabbath = storage.getItem('sabbath');

    return Sabbath(
      startDateTime: _formatCurrentDate(SaturdayHelper.getFriday(), DateTime.parse(sabbath['startDateTime'])),
      endDateTime: _formatCurrentDate(SaturdayHelper.getSaturday(), DateTime.parse(sabbath['endDateTime'])),
    );
  }

  void saveSabbath(Sabbath sabbath) async {
    storage.setItem('sabbath', sabbath.toJSONEncodable());
  }

  DateTime _formatCurrentDate(DateTime date, DateTime time) {
    return DateTime.utc(date.year, date.month, date.day, time.hour, time.minute, time.second);
  }
}
