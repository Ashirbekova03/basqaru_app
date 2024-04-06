import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {

  final String text;
  final Function? onPressed;

  const PrimaryButton(
    this.text, {
      super.key,
      this.onPressed
    }
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onPressed?.call();
        },
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.primary,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: AppColor.primary.withOpacity(0.5),
                offset: const Offset(0.0, 5.0),
                blurRadius: 30,
                spreadRadius: 0,
              )
            ],
          ),
          child: Container(
            width: double.infinity,
            height: 54,
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        )
    );
  }
}