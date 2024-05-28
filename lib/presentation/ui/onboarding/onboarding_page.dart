import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:basqary/presentation/ui/custom/widget/button_text.dart';
import 'package:basqary/presentation/ui/custom/widget/carousel_indicator.dart';
import 'package:basqary/presentation/ui/custom/widget/description_text.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_button.dart';
import 'package:basqary/presentation/ui/login/login_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {

  const OnBoardingPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OnBoardingPage();
  }
}

class _OnBoardingPage extends State<OnBoardingPage> {

  int _carouselIndex = 0;
  late double _carouselSize;
  final CarouselController _carouselController = CarouselController();

  void _startAuthorization() {
    NavigationUtils.put(context, const LoginPage());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _carouselSize = MediaQuery.of(context).size.height - 300;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: AppSize.topMargin, right: AppSize.horizontal),
            child: ButtonText(
              "Skip",
              onPressed: () {
                _startAuthorization();
              },
            ),
          ),
          Expanded(
            child: CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      _carouselIndex = index;
                    });
                  },
                  height: _carouselSize,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  viewportFraction: 1,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  _firstOnboarding(),
                  _secondOnboarding()
                ]
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 53, top: 10),
            child: CarouselIndicator(
              length: 2,
              selected: _carouselIndex,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: AppSize.bottomMargin),
            child: PrimaryButton(
              _carouselIndex == 1 ? AppLocalizations.of(context)!.start : AppLocalizations.of(context)!.next,
              onPressed: () {
                if (_carouselIndex == 1) {
                  _startAuthorization();
                } else {
                  _carouselController.nextPage();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _firstOnboarding() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.horizontal),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              "assets/images/onboarding_1.png"
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 15),
            child: HeaderText(AppLocalizations.of(context)!.welcome),
          ),
          DescriptionText(
            AppLocalizations.of(context)!.welcome_text,
            textAlign: TextAlign.center,
            style: DescriptionText.defaultStyle.apply(
              color: Colors.black.withOpacity(0.7)
            ),
          )
        ],
      ),
    );
  }

  Widget _secondOnboarding() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.horizontal),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
                "assets/images/onboarding_2.png"
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 15),
            child: const HeaderText("Basqaru"),
          ),
          DescriptionText(
            AppLocalizations.of(context)!.about,
            textAlign: TextAlign.center,
            style: DescriptionText.defaultStyle.apply(
                color: Colors.black.withOpacity(0.7)
            ),
          )
        ],
      ),
    );
  }

}