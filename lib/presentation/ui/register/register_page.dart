import 'package:basqary/domain/api/authorization.dart';
import 'package:basqary/domain/data/user/request/RegisterRequest.dart';
import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:basqary/presentation/ui/custom/widget/button_text.dart';
import 'package:basqary/presentation/ui/custom/widget/description_text.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/message_hint.dart';
import 'package:basqary/presentation/ui/custom/widget/password_text_field.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_button.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_text_field.dart';
import 'package:basqary/presentation/ui/custom/widget/scrollable_page.dart';
import 'package:basqary/presentation/ui/login/login_page.dart';
import 'package:basqary/presentation/ui/main/main_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPage();
  }
}

class _RegisterPage extends State<RegisterPage> {

  final AuthorizationAPI _authorizationAPI = AuthorizationAPI();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _startLogin() {
    NavigationUtils.put(context, const LoginPage());
  }

  void _register() {
    if (_usernameController.text.isNotEmpty && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      _authorizationAPI.register(
        RegisterRequest(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text
        )
      ).then((value) => _success()).onError((error, stackTrace) => _onError());
    }
  }

  void _success() {
    MessageHint.showMessage("Success registered");
    _startLogin();
  }

  void _onError() {
    MessageHint.showMessage("Email already registered");
    setState(() {
      _emailController.text = "";
      _passwordController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollablePage(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, top: AppSize.topMargin, bottom: AppSize.bottomMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset("assets/images/logo.png", width: 200),
                    ),
                  ),
                  HeaderText(AppLocalizations.of(context)!.sign_up),
                  Container(
                    margin: const EdgeInsets.only(top: 6, bottom: 17),
                    child: DescriptionText(AppLocalizations.of(context)!.sign_up_hint),
                  ),
                  PrimaryTextField(
                    hint: AppLocalizations.of(context)!.username,
                    controller: _usernameController,
                    action: TextInputAction.next,
                    keyboardType: TextInputType.name,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: PrimaryTextField(
                      hint: AppLocalizations.of(context)!.email,
                      controller: _emailController,
                      action: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 25),
                    child: PasswordTextField(
                        hint: AppLocalizations.of(context)!.password,
                        controller: _passwordController,
                        action: TextInputAction.done
                    ),
                  ),
                  PrimaryButton(
                    AppLocalizations.of(context)!.sign_up,
                    onPressed: () {
                      _register();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DescriptionText(AppLocalizations.of(context)!.register_question),
                        ButtonText(
                          AppLocalizations.of(context)!.sign_in,
                          onPressed: () {
                            NavigationUtils.put(context, const LoginPage());
                          },
                        )
                      ],
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}