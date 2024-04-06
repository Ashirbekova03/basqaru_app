import 'package:basqary/presentation/ui/custom/formatter/formatter.dart';
import 'package:basqary/presentation/ui/custom/widget/description_text.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:flutter/material.dart';

class AvailableBalanceWidget extends StatelessWidget {

  final double balance;
  const AvailableBalanceWidget({
    super.key,
    required this.balance
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DescriptionText(
            "Available balance",
            style: DescriptionText.defaultStyle.apply(
                color: Colors.white
            ),
          ),
          HeaderText(
            Formatter.formatCurrency(balance),
            style: HeaderText.defaultStyle.apply(
                color: Colors.white,
                fontSizeFactor: 2
            ),
          )
        ],
      ),
    );
  }
}