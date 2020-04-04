import 'dart:ui';

class Constants {
  static Constants _instance;
  factory Constants() => _instance ??= new Constants._();
  Constants._();

  static final maxImageCount = 3;
  static final otpCodeValidTimeInSeconds = 180;
}

final backgroundColor = const Color(0xffdee8f3);
final cardBackgroundColor = const Color(0xffdbe5f0);
final darkBlue = const Color(0xff34486c);
final lightGreyTextColor = const Color(0xffb4bece);

final oneSignalAppId = "-";
