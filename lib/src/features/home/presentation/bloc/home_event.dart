part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitializeHome extends HomeEvent {}

class RefreshHome extends HomeEvent {}

class SabbathStarted extends HomeEvent {}

class SabbathEnded extends HomeEvent {}
