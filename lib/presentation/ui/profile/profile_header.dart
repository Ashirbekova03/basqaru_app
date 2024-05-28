import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/notification/notification_page.dart';
import 'package:basqary/presentation/ui/settings/change_profile_page.dart';
import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatefulWidget {

  final BuildContext pageContext;

  const ProfileHeaderWidget({
    super.key,
    required this.pageContext,
  });

  @override
  State<StatefulWidget> createState() => _ProfileHeaderWidget();
}

class _ProfileHeaderWidget extends State<ProfileHeaderWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.only(top: AppSize.topMargin, left: AppSize.horizontal, right: AppSize.horizontal),
      child: Row(
        children: [
          ButtonIcon(
              Icons.settings,
              onPressed: () {
                NavigationUtils.push(widget.pageContext, const SettingsPage());
              }
          ),
          Expanded(
            child: HeaderText(
              AppLocalizations.of(context)!.profile,
              textAlign: TextAlign.center,
              style: HeaderText.defaultStyle.apply(
                  color: Colors.white
              ),
            ),
          ),
          Container(width: 35)
        ]
      ),
    );
  }
}