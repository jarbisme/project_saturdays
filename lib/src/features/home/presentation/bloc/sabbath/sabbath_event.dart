part of 'sabbath_bloc.dart';

@immutable
abstract class SabbathEvent {}

// class Initialize extends SabbathEvent {}

class LoadSabbath extends SabbathEvent {}

class LoadingSabbath extends SabbathEvent {}

class SyncSabbath extends SabbathEvent {}
