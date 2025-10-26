// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get helloWorld => '¡Hola Mundo!';

  @override
  String get titleWidget => 'Sábado';

  @override
  String get fridaySunset => 'Viernes atardecer';

  @override
  String get saturdaySunset => 'Sábado atardecer';

  @override
  String get saturdayStartsIn => 'Sábado empieza en';

  @override
  String get saturdayEndsIn => 'Sábado termina en';

  @override
  String get notificationsTitle => 'Notificationes';

  @override
  String get notificationsDescription =>
      '¿Cuántos minutos antes te gustaría recibir un recordatorio?';

  @override
  String get noConnectionBannerFirstText =>
      'Parece que no hay conexión a internet. ';

  @override
  String get noConnectionBannerSecondText =>
      'Desliza hacia abajo para actualizar';
}
