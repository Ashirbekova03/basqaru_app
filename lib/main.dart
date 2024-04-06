import 'package:basqary/presentation/ui/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(
      const MaterialApp(
        home: SplashPage(),
      )
  );
}