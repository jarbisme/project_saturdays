import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:project_saturdays/src/features/home/data/repositories/saturday_repository.dart';

import 'package:project_saturdays/src/features/home/domain/sabbath.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _saturdayRepository = SaturdayRepository();

  HomeBloc() : super(const HomeInitial()) {
    on<InitializeHome>((event, emit) async {
      final date = DateTime(2023, 2, 17, 18, 36);
      // final date = DateTime(2023, 2, 12, 18, 36);
      final sabbath = await _saturdayRepository.getSabbath();
      if (sabbath != null) {
        emit(
          SetHomeState(
            // sabbath: Sabbath(
            //   startDateTime: date,
            //   endDateTime: date.add(const Duration(days: 1)),
            // ),
            sabbath: sabbath,
            isSaturday: date.difference(DateTime.now()).isNegative ? true : false,
          ),
        );
      } else {
        emit(const ErrorHomeSate(errorMessage: 'Error trying to tech the data'));
      }
    });
    on<SabbathStarted>((event, emit) {
      print('SabbathStarted');
      emit(SetHomeState(sabbath: state.sabbath!, isSaturday: true));
    });
    on<SabbathEnded>((event, emit) {
      print('SabbathEnded');
      emit(SetHomeState(sabbath: state.sabbath!, isSaturday: false));
    });
  }
}
