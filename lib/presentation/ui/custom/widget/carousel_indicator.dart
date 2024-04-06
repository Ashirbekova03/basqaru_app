import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselIndicator extends StatelessWidget {

  final int length;
  final int selected;

  const CarouselIndicator({super.key, required this.length, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Container(
          margin: length - 1 == index ? EdgeInsets.zero : const EdgeInsets.only(right: 5),
          height: 10,
          width: selected == index ? 30 : 10,
          decoration: BoxDecoration(
            color: AppColor.secondary,
            borderRadius: BorderRadius.circular(100)
          ),
        )
      ),
    );
  }
}