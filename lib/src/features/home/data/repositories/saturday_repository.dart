import 'package:project_saturdays/src/features/home/data/data_sources/saturday_local_data_source.dart';
import 'package:project_saturdays/src/features/home/domain/sabbath.dart';

import '../data_sources/saturday_remote_data_source.dart';

class SaturdayRepository {
  final remoteDataSource = SaturdayRemoteDataSource();
  final localDataSource = SaturdayLocalDataSource();

  Future<Sabbath?> getSabbath() async {
    // throw Exception('Not implemented');
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
