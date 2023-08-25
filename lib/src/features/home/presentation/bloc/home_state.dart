part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  final Sabbath? sabbath;
  final bool isSaturday;

  const HomeState({
    this.sabbath,
    this.isSaturday = false,
  });

  @override
  List<Object> get props => [sabbath!, isSaturday];
}

class HomeInitial extends HomeState {
  const HomeInitial() : super();
}

class HomeLoading extends HomeState {
  const HomeLoading() : super(sabbath: null);
}

class SetHomeState extends HomeState {
  const SetHomeState({required Sabbath sabbath, required bool isSaturday})
      : super(sabbath: sabbath, isSaturday: isSaturday);
}

class ErrorHomeSate extends HomeState {
  final String errorMessage;

  const ErrorHomeSate({required this.errorMessage}) : super();

  @override
  List<Object> get props => [sabbath!, isSaturday, errorMessage];
}
