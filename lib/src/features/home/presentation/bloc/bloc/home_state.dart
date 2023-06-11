part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  final bool sabbatExist;
  final Sabbath? sabbath;
  final bool isSaturday;

  const HomeState({
    this.sabbatExist = false,
    this.sabbath,
    this.isSaturday = false,
  });

  @override
  List<Object> get props => [sabbatExist, sabbath!, isSaturday];
}

class HomeInitial extends HomeState {
  const HomeInitial() : super(sabbatExist: false);
}

class SetHomeState extends HomeState {
  const SetHomeState({required Sabbath sabbath, required bool isSaturday})
      : super(sabbatExist: true, sabbath: sabbath, isSaturday: isSaturday);
}

class ErrorHomeSate extends HomeState {
  final String errorMessage;

  const ErrorHomeSate({required this.errorMessage}) : super(sabbatExist: false);

  @override
  List<Object> get props => [sabbatExist, sabbath!, isSaturday, errorMessage];
}
