import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/network/shared_prefs.dart';
import 'firebase_options.dart';
import 'presentation/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    name: Platform.isAndroid.toString(),
  );

  await _initializeSharedPrefs();
  _initialiseCrashlytics();
  MobileAds.instance.initialize();

  LanguageCode savedLanguage = getSavedLanguage();
  runApp(AppWidget(languageCode: savedLanguage));
}

LanguageCode getSavedLanguage() {
  final prefs = SharedPreferencesHelper.instance;
  return prefs.getLanguageCode();
}

Future<void> _initializeSharedPrefs() async {
  await SharedPreferencesHelper.instance.init();
  await SharedPreferences.getInstance();
}

void _initialiseCrashlytics() async {
  if (!kDebugMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
