// ignore_for_file: dead_code

import 'package:project_saturdays/src/features/home/data/data_sources/saturday_local_data_source.dart';
import 'package:project_saturdays/src/features/home/domain/sabbath.dart';

import '../data_sources/saturday_remote_data_source.dart';

class SaturdayRepository {
  final remoteDataSource = SaturdayRemoteDataSource();
  final localDataSource = SaturdayLocalDataSource();

  Future<Sabbath?> getSabbath() async {
    // * START: For Testing
    var imTesting = false;
    // // final date = DateTime(2023, 11, 5, 20, 7);
    // // final date = DateTime(2023, 2, 12, 18, 36);
    final date = DateTime.now();
    var testSabbath = Sabbath(
      startDateTime: date.add(const Duration(seconds: 10)),
      endDateTime: date.add(const Duration(seconds: 20)),
      source: Source.remote,
    );

    if (imTesting) {
      return testSabbath;
    }
    // * END

    try {
      var sabbath = await remoteDataSource.getSabbath();

      if (sabbath != null) {
        localDataSource.saveSabbath(sabbath);
        return sabbath;
      } else {
        return await localDataSource.getSabbath();
      }
    } catch (e) {
      throw Exception('An error ocurred: $e');
    }
  }
}
