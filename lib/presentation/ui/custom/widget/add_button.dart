import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {

  final Function onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: InkWell(
        onTap: () {
          onPressed.call();
        },
        child: Container(
          width: 35,
          height: 35,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.primary
          ),
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}