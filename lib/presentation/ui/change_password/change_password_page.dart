import 'package:basqary/domain/api/profile.dart';
import 'package:basqary/domain/data/user/request/PasswordChangeRequest.dart';
import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/message_hint.dart';
import 'package:basqary/presentation/ui/custom/widget/password_text_field.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_button.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePasswordPage extends StatefulWidget {

  const ChangePasswordPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePasswordPage();
}

class _ChangePasswordPage extends State<ChangePasswordPage> {

  final ProfileAPI _profileAPI = ProfileAPI();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confPasswordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();

  void _changeProfile() {
    if (_passwordController.text.isNotEmpty && _confPasswordController.text.isNotEmpty) {
      if (_passwordController.text != _confPasswordController.text) {
        MessageHint.showMessage(AppLocalizations.of(context)!.password_mismatch);
      } else {
        _profileAPI.changePassword(
          PasswordChangeRequest(
            password: _passwordController.text,
            oldPassword: _oldPasswordController.text
          )
        ).then((value) => _success()).onError((response, error) => _wrongOldPassword());
      }
    }
  }

  void _success() {
    MessageHint.showMessage(AppLocalizations.of(context)!.saved);
    Navigator.of(context).pop();
  }

  void _wrongOldPassword() {
    MessageHint.showMessage(AppLocalizations.of(context)!.wrong_old_password);
  }

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
    return Scaffold(
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
                Expanded(
                  child: HeaderText(
                    AppLocalizations.of(context)!.change_password,
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
                  PasswordTextField(
                    hint: AppLocalizations.of(context)!.old_password,
                    controller: _oldPasswordController,
                    action: TextInputAction.next,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: PasswordTextField(
                      hint: AppLocalizations.of(context)!.password,
                      controller: _passwordController,
                      action: TextInputAction.next,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: PasswordTextField(
                      hint: AppLocalizations.of(context)!.confirm_password,
                      controller: _confPasswordController,
                      action: TextInputAction.done,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: AppSize.bottomMargin),
            child: PrimaryButton(
              AppLocalizations.of(context)!.save,
              onPressed: () {
                _changeProfile();
              },
            ),
          )
        ],
      ),
    );
  }
}