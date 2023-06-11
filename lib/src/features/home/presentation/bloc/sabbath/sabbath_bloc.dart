import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_saturdays/src/features/home/domain/sabbath.dart';

part 'sabbath_event.dart';
part 'sabbath_state.dart';

class SabbathBloc extends Bloc<SabbathEvent, SabbathState> {
  SabbathBloc() : super(SabbathInitial()) {
    on<LoadSabbath>((event, emit) {
      // TODO: implement event handler
      print('LoadSabbath event');
      emit(SetSabbathState(
        sabbath: Sabbath(
          startDateTime: DateTime.now(),
          endDateTime: DateTime.now().add(const Duration(days: 1)),
        ),
      ));
    });
  }
}
