import 'dart:async';

import 'package:basqary/domain/api/base.dart';
import 'package:basqary/domain/api/profile.dart';
import 'package:basqary/domain/provider/UserProvider.dart';
import 'package:basqary/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:basqary/presentation/ui/main/main_page.dart';
import 'package:basqary/presentation/ui/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashPage> {

  void _startOnBoarding() {
    NavigationUtils.put(context, const OnBoardingPage());
  }

  void _checkToken() {
    ProfileAPI().getProfile().then((value) => {
      NavigationUtils.put(context, const MainPage())
    }).onError((error, stackTrace) => {
      _startOnBoarding()
    });
  }

  void _startMain() {
    BaseAPI.reloadHeader().then((value) => {
      _checkToken()
    }).onError((error, stackTrace) => {
      _startOnBoarding()
    });
  }

  void _checkAccount() {
    UserProvider().getAuthToken().then((value) => _startMain()).onError((error, stackTrace) => _startOnBoarding());
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      timer.cancel();
      _checkAccount();
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(
            "assets/images/logo.png",
            height: 180,
          ),
        )
      )
    );
  }
}