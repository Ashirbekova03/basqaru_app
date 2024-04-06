import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {

  final String text;
  final TextAlign textAlign;
  final TextStyle? style;

  static TextStyle defaultStyle = const TextStyle(
    color: AppColor.text,
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    fontSize: 22
  );

  static TextStyle smallerStyle = const TextStyle(
    color: AppColor.text,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 20
  );

  const HeaderText(
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