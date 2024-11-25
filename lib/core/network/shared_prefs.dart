import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/app_widget.dart';
import '../helpers/birthday_helper.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();

  static final SharedPreferencesHelper instance = SharedPreferencesHelper._();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setNickname(String value) async {
    await _prefs.setString('nickname', value);
  }

  String? getNickname() {
    return _prefs.getString('nickname');
  }

  Future<void> setBirthdayDay(String value) async {
    await _prefs.setString('birthday_day', value);
  }

  Future<void> setBirthdayMonth(String value) async {
    await _prefs.setString('birthday_month', value);
  }

  Future<void> setBirthdayYear(String value) async {
    await _prefs.setString('birthday_year', value);
  }

  String getBirthdayDay() {
    return _prefs.getString('birthday_day') ?? '';
  }

  String getBirthdayMonth() {
    return _prefs.getString('birthday_month') ?? '';
  }

  String getBirthdayYear() {
    return _prefs.getString('birthday_year') ?? '';
  }

  Future<void> setBirthdayDate({
    required String day,
    required String month,
    required String year,
  }) async {
    await setBirthdayDay(day);
    await setBirthdayMonth(month);
    await setBirthdayYear(year);
  }

  String getBirthdayDate() {
    final birthdayHelper = BirthdayHelper();
    String day = getBirthdayDay();
    String month = getBirthdayMonth();
    String year = getBirthdayYear();
    String formattedBirthday = birthdayHelper.formatBirthday(day, month, year);
    return formattedBirthday;
  }

  Future<void> setIsAppUnlocked(bool value) async {
    await _prefs.setBool('is_app_unlocked', value);
  }

  bool getIsAppUnlocked() {
    return _prefs.getBool('is_app_unlocked') ?? false;
  }

  Future<void> setLanguageCode(LanguageCode value) async {
    await _prefs.setString('language_code', value.name);
  }

  LanguageCode getLanguageCode() {
    String language = _prefs.getString('language_code') ?? 'en';

    return language == LanguageCode.ar.name ? LanguageCode.ar : LanguageCode.en;
  }
}
