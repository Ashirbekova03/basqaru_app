import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class ProfileChangeButton extends StatelessWidget {

  final String title;
  final String description;
  final IconData icon;
  final Function onClick;
  final Color color;
  final Color titleColor;

  const ProfileChangeButton({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onClick,
    this.color = AppColor.secondary,
    this.titleColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () {
          onClick.call();
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.normal
                    ),
                  ),
                  if (description.isNotEmpty)
                  Text(
                    description,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

}