import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {

  final String text;
  final Function? onPressed;

  const ButtonText(this.text, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed?.call(),
      borderRadius: const BorderRadius.all(Radius.circular(7)),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7))
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppColor.secondary,
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }

}