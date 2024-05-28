import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/description_text.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/search_text_field.dart';
import 'package:flutter/material.dart';

class LessonsTopWidget extends StatelessWidget {

  final TextEditingController searchController;
  final Function onSubmitted;

  const LessonsTopWidget({
    super.key,
    required this.searchController,
    required this.onSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: OvalBottomClipper(),
          child: Image.asset(
            "assets/images/top.png",
            width: double.infinity,
            height: 230,
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: AppSize.topMargin, left: AppSize.horizontal, right: AppSize.horizontal),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: HeaderText(
                      AppLocalizations.of(context)!.tips,
                      textAlign: TextAlign.center,
                      style: HeaderText.defaultStyle.apply(
                          color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: DescriptionText(
                  textAlign: TextAlign.center,
                  AppLocalizations.of(context)!.tips_hint,
                  style: DescriptionText.defaultStyle.apply(
                      color: Colors.white.withOpacity(0.9)
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 17),
                child: SearchTextField(
                  controller: searchController,
                  hint: AppLocalizations.of(context)!.search,
                  onSubmitted: onSubmitted,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}


class OvalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}