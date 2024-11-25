import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../core/router/app_router.dart';
import '../l10n/l10n.dart';

class AppWidget extends StatefulWidget {
  final LanguageCode languageCode;

  const AppWidget({super.key, required this.languageCode});

  @override
  State<AppWidget> createState() => _AppWidgetState();

  static _AppWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<_AppWidgetState>();
  }
}

class _AppWidgetState extends State<AppWidget> {
  late Locale _locale = Locale(widget.languageCode.name);

  void setLocale(LanguageCode value) {
    setState(() => _locale = Locale.fromSubtags(languageCode: value.name));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Khumoyiddin Bakhodirov',
      debugShowCheckedModeBanner: false,
      routeInformationProvider: AppRouter.router.routeInformationProvider,
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: _locale,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(),
      ),
    );
  }
}

enum LanguageCode { en, ar }
