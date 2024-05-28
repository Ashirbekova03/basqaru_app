import 'package:basqary/domain/provider/UserProvider.dart';
import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(const MyApp());
}

void restartAppAll() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final UserProvider _userProvider = UserProvider();
  Locale _locale = Locale("us");
  bool _loading = true;

  void setLocale(String lang) {
    setState(() {
      _loading = false;
      _locale = Locale(lang);
    });
  }

  @override
  void initState() {
    _userProvider.getLang().then((lang) => setLocale(lang)).onError((a, b) => setLocale("en"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_loading ? MaterialApp(
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: SplashPage(),
    ) : const MaterialApp();
  }
}
