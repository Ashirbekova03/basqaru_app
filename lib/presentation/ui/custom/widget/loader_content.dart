import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class LoaderContentWidget extends StatelessWidget {

  final double height;
  const LoaderContentWidget({
    super.key,
    this.height = 400
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: const SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          color: AppColor.secondary,
        ),
      ),
    );
  }
}