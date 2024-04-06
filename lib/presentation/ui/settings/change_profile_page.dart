import 'package:basqary/domain/api/profile.dart';
import 'package:basqary/domain/data/user/request/ChangeProfileRequest.dart';
import 'package:basqary/domain/data/user/response/ProfileResponse.dart';
import 'package:basqary/domain/provider/UserProvider.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/message_hint.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_button.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_text_field.dart';
import 'package:basqary/presentation/ui/login/login_page.dart';
import 'package:basqary/presentation/ui/profile/profile_change_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPage extends StatefulWidget {

  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top:AppSize.topMargin, bottom: AppSize.bottomMargin, left: AppSize.horizontal, right: AppSize.horizontal),
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonIcon(
                      Icons.arrow_back_ios_new_rounded,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.black,
                    ),
                    const Expanded(
                      child: HeaderText(
                        "Settings",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(width: 35),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      ProfileChangeButton(
                        title: "Notification",
                        description: "You can turn off notifications",
                        icon: Icons.notifications,
                        onClick: () {

                        },
                      )
                    ],
                  ),
                ),
              ),
              ProfileChangeButton(
                title: "Logout",
                description: "",
                color: AppColor.sent,
                titleColor: AppColor.sent,
                icon: Icons.logout_rounded,
                onClick: () {
                  UserProvider().setAuthToken(null).then((value) => {
                    NavigationUtils.put(context, const LoginPage())
                  });
                },
              )
            ],
          ),
        )
      ),
    );
  }
}