// ignore_for_file: dead_code, avoid_print

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
    // * START: For Testing
    var imTesting = false;
    // // final date = DateTime(2023, 11, 5, 20, 7);
    // // final date = DateTime(2023, 2, 12, 18, 36);
    final date = DateTime.now();
    final testSabbath = Sabbath(
      startDateTime: date.add(const Duration(seconds: 30)),
      endDateTime: date.add(const Duration(seconds: 600)),
      source: Source.remote,
    );
    // * END

    on<InitializeHome>((event, emit) async {
      Sabbath? sabbath;
      if (imTesting) {
        sabbath = testSabbath;
      } else {
        sabbath = await _saturdayRepository.getSabbath();
      }

      if (sabbath != null) {
        emit(
          SetHomeState(
            sabbath: sabbath,
            // isSaturday: date.difference(DateTime.now()).isNegative ? true : false,
            isSaturday: false,
          ),
        );
      } else {
        emit(const ErrorHomeSate(errorMessage: 'Error trying to fech the data'));
      }
    });
    on<RefreshHome>((event, emit) async {
      print('RefreshHome');
      emit(const HomeLoading());
      Sabbath? sabbath;
      if (imTesting) {
        sabbath = testSabbath;
      } else {
        sabbath = await _saturdayRepository.getSabbath();
      }

      if (sabbath != null) {
        emit(
          SetHomeState(
            sabbath: sabbath,
            // isSaturday: date.difference(DateTime.now()).isNegative ? true : false,
            isSaturday: false,
          ),
        );
      } else {
        emit(const ErrorHomeSate(errorMessage: 'Error trying to fech the data'));
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
