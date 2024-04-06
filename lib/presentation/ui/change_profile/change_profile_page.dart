import 'package:basqary/domain/api/profile.dart';
import 'package:basqary/domain/data/user/request/ChangeProfileRequest.dart';
import 'package:basqary/domain/data/user/response/ProfileResponse.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/message_hint.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_button.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeProfilePage extends StatefulWidget {

  final ProfileViewModel profile;

  const ChangeProfilePage({super.key, required this.profile});

  @override
  State<StatefulWidget> createState() => _ChangeProfilePage();
}

class _ChangeProfilePage extends State<ChangeProfilePage> {

  final ProfileAPI _profileAPI = ProfileAPI();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _changeProfile() {
    if (_usernameController.text.isNotEmpty && _emailController.text.isNotEmpty) {
      _profileAPI.changeProfile(
          ChangeProfileRequest(
              username: _usernameController.text,
              email: _emailController.text
          )
      ).then((value) =>
      {
        MessageHint.showMessage("New profile data saved"),
        Navigator.of(context).pop()
      }).onError((error, stackTrace) =>
      {
        MessageHint.showMessage("Email already registered"),
        setState(() {
          _emailController.text = "";
        })
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _emailController.text = widget.profile.email;
    _usernameController.text = widget.profile.fullName;
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
        body: Column(
          children: [
            Container(
              height: 35,
              margin: const EdgeInsets.only(top: AppSize.topMargin, left: AppSize.horizontal, right: AppSize.horizontal),
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
                      "Change profile",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(width: 35),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, top: 20),
                child: Column(
                  children: [
                    PrimaryTextField(
                      hint: "Username",
                      controller: _usernameController,
                      action: TextInputAction.next,
                      keyboardType: TextInputType.name,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: PrimaryTextField(
                        hint: "Email",
                        controller: _emailController,
                        action: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: AppSize.bottomMargin),
              child: PrimaryButton(
                "Save",
                onPressed: () {
                  _changeProfile();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}