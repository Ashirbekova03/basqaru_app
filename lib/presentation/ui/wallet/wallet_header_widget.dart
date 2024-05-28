import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:flutter/material.dart';

class WalletHeaderWidget extends StatelessWidget {

  const WalletHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.only(top: AppSize.topMargin, left: AppSize.horizontal, right: AppSize.horizontal),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: HeaderText(
              AppLocalizations.of(context)!.my_wallet,
              textAlign: TextAlign.center,
              style: HeaderText.defaultStyle.apply(
                  color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }

}