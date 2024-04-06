import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {

  final IconData icon;
  final Function onPressed;
  final Color color;

  const ButtonIcon(this.icon, {
    super.key,
    required this.onPressed,
    this.color = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35,
      height: 35,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          onPressed.call();
        },
        child: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2)
          ),
          child: Icon(
            icon,
            color: color,
            size: 22,
          ),
        ),
      ),
    );
  }
}