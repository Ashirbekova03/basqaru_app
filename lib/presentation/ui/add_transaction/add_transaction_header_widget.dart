import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:flutter/material.dart';

class AddTransactionHeaderWidget extends StatelessWidget {

  final BuildContext pageContext;

  const AddTransactionHeaderWidget(this.pageContext, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.only(top: AppSize.topMargin, left: AppSize.horizontal, right: AppSize.horizontal),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonIcon(
              Icons.arrow_back_ios_new_rounded,
              onPressed: () {
                Navigator.of(pageContext).pop();
              }
          ),
          Expanded(
            child: HeaderText(
              AppLocalizations.of(context)!.add_transactions,
              textAlign: TextAlign.center,
              style: HeaderText.defaultStyle.apply(
                  color: Colors.white
              ),
            ),
          ),
          Container(width: 35),
        ],
      ),
    );
  }

}