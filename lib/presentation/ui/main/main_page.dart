import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/analytics/analytics_page.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/navigation/salomon_navigation.dart';
import 'package:basqary/presentation/ui/lessons/lessons_page.dart';
import 'package:basqary/presentation/ui/profile/profile_page.dart';
import 'package:basqary/presentation/ui/wallet/wallet_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {

  int _currentIndex = 0;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _getBody(),
      floatingActionButton: _getNavigation(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _getBody() {
    if (_currentIndex == 1) {
      return const WalletPage();
    } else if (_currentIndex == 2) {
      return const AnalyticsPage();
    } else if (_currentIndex == 3) {
      return const ProfilePage();
    }
    return const LessonsPage();
  }

  Widget _getNavigation() {
    return SalomonBottomBar(
      backgroundColor: Colors.white,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.folder_copy_outlined),
          title: Text(AppLocalizations.of(context)!.lesson),
          selectedColor: AppColor.primary,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.wallet_rounded),
          title: Text(AppLocalizations.of(context)!.wallet),
          selectedColor: AppColor.primary,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.bar_chart_rounded),
          title: Text(AppLocalizations.of(context)!.analytics),
          selectedColor: AppColor.primary,
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.person_outline_rounded),
          title: Text(AppLocalizations.of(context)!.profile),
          selectedColor: AppColor.primary,
        ),
      ],
    );
  }
}