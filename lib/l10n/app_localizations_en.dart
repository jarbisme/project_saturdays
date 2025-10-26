// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get titleWidget => 'Saturday';

  @override
  String get fridaySunset => 'Friday sunset';

  @override
  String get saturdaySunset => 'Saturday sunset';

  @override
  String get saturdayStartsIn => 'Satuday starts in';

  @override
  String get saturdayEndsIn => 'Satuday ends in';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsDescription =>
      'How many minutes in advance would you like to be reminded?';

  @override
  String get noConnectionBannerFirstText =>
      'It appears that there is not an internet connection. ';

  @override
  String get noConnectionBannerSecondText => 'Pull down to refresh';
}
