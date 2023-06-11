part of 'sabbath_bloc.dart';

@immutable
abstract class SabbathState {
  final bool sabbatExist;
  final Sabbath? sabbath;

  const SabbathState({this.sabbath, this.sabbatExist = false});
}

class SabbathInitial extends SabbathState {
  const SabbathInitial() : super(sabbatExist: false, sabbath: null);
}

class SetSabbathState extends SabbathState {
  const SetSabbathState({required Sabbath sabbath}) : super(sabbatExist: true, sabbath: sabbath);
}
