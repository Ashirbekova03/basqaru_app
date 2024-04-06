import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {

  final String text;
  final TextAlign textAlign;
  final TextStyle? style;

  static TextStyle defaultStyle = const TextStyle(
    color: AppColor.secondaryText,
    fontFamily: 'Inter',
    fontSize: 14
  );

  const DescriptionText(
    this.text, {
      super.key,
      this.textAlign = TextAlign.start,
      this.style
    }
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style ?? defaultStyle,
    );
  }
}