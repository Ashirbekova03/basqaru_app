import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class SalomonBottomBar extends StatelessWidget {

  const SalomonBottomBar({
    Key? key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutQuint,
  }) : super(key: key);
  final List<SalomonBottomBarItem> items;
  final int currentIndex;
  final Function(int)? onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? selectedColorOpacity;
  final ShapeBorder itemShape;
  final EdgeInsets margin;
  final EdgeInsets itemPadding;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(0.0, 12.0),
            blurRadius: 30,
            spreadRadius: 30,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(60),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: items.length <= 2
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.spaceBetween,
          children: [
            for (final item in items)
              TweenAnimationBuilder<double>(
                tween: Tween(
                  end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
                ),
                curve: curve,
                duration: duration,
                builder: (context, t, _) {
                  const selectedColor = AppColor.primary;
                  return Material(
                    color: Color.lerp(
                        selectedColor.withOpacity(0.0),
                        selectedColor.withOpacity(1),
                        t),
                    borderRadius: BorderRadius.circular(60),
                    child: InkWell(
                      onTap: () => onTap?.call(items.indexOf(item)),
                      borderRadius: BorderRadius.circular(8),
                      focusColor: selectedColor.withOpacity(0.1),
                      highlightColor: selectedColor.withOpacity(0.1),
                      splashColor: selectedColor.withOpacity(0.1),
                      hoverColor: selectedColor.withOpacity(0.1),
                      child: Padding(
                        padding: itemPadding -
                            (Directionality.of(context) == TextDirection.ltr
                                ? EdgeInsets.only(right: itemPadding.right * t)
                                : EdgeInsets.only(left: itemPadding.left * t)),
                        child: Row(
                          children: [
                            IconTheme(
                              data: IconThemeData(
                                color: Color.lerp(
                                    AppColor.inactive,
                                    Colors.white,
                                    t),
                                size: 24,
                              ),
                              child: item.icon,
                            ),
                            ClipRect(
                              clipBehavior: Clip.antiAlias,
                              child: SizedBox(
                                height: 20,
                                child: Align(
                                  alignment: const Alignment(-0.2, 0.0),
                                  widthFactor: t,
                                  child: Padding(
                                    padding: Directionality.of(context) ==
                                        TextDirection.ltr
                                        ? EdgeInsets.only(
                                        left: itemPadding.left / 2,
                                        right: itemPadding.right)
                                        : EdgeInsets.only(
                                        left: itemPadding.left,
                                        right: itemPadding.right / 2),
                                    child: DefaultTextStyle(
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      child: item.title,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class SalomonBottomBarItem {

  final Widget icon;
  final Widget? activeIcon;
  final Widget title;
  final Color? selectedColor;
  final Color? unselectedColor;

  SalomonBottomBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });
}
