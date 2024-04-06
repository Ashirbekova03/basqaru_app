import 'package:basqary/domain/api/authorization.dart';
import 'package:basqary/domain/api/base.dart';
import 'package:basqary/domain/data/user/request/LoginRequest.dart';
import 'package:basqary/domain/provider/UserProvider.dart';
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
import 'package:basqary/presentation/ui/main/main_page.dart';
import 'package:basqary/presentation/ui/register/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {

  final AuthorizationAPI _authorizationAPI = AuthorizationAPI();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _startMain() {
    NavigationUtils.put(context, const MainPage());
  }

  void _doLogin() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      _authorizationAPI.login(
        LoginRequest(
          email: _emailController.text,
          password: _passwordController.text
        )
      ).then((value) => _success()).onError((error, stackTrace) => _onError());
    }
  }

  void _success() {
    BaseAPI.reloadHeader();
    _startMain();
  }

  void _onError() {
    MessageHint.showMessage("Wrong email or password");
    setState(() {
      _emailController.text = "";
      _passwordController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                    const HeaderText("Sign In"),
                    Container(
                      margin: const EdgeInsets.only(top: 6, bottom: 17),
                      child: const DescriptionText("Enter your email and password to login"),
                    ),
                    PrimaryTextField(
                      hint: "Email",
                      controller: _emailController,
                      action: TextInputAction.next,
                      maxLength: 30,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 10),
                      child: PasswordTextField(
                        hint: "Password",
                        controller: _passwordController,
                        action: TextInputAction.done,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(bottom: 13),
                      child: ButtonText(
                        "Forgot password?",
                        onPressed: () {

                        },
                      ),
                    ),
                    PrimaryButton(
                      "Sign In",
                      onPressed: () {
                        _doLogin();
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const DescriptionText("Don’t have an account?"),
                          ButtonText(
                            "Sign Up",
                            onPressed: () {
                              NavigationUtils.put(context, const RegisterPage());
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
      ),
    );
  }
}