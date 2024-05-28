import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/widget/description_text.dart';
import 'package:flutter/material.dart';

class EmptyContentWidget extends StatelessWidget {

  const EmptyContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      alignment: Alignment.center,
      child: DescriptionText(AppLocalizations.of(context)!.empty_content),
    );
  }
}