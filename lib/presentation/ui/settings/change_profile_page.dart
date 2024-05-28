import 'package:basqary/domain/api/profile.dart';
import 'package:basqary/domain/data/user/request/ChangeProfileRequest.dart';
import 'package:basqary/domain/data/user/response/ProfileResponse.dart';
import 'package:basqary/domain/provider/UserProvider.dart';
import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/main.dart';
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
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';

class SettingsPage extends StatefulWidget {

  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {

  final UserProvider _userProvider = UserProvider();
  final List<String> _languages = ["Русский", "English", "Қазақша"];
  late String _selectedLang;
  bool _loading = true;
  bool _isOff = false;

  void _loadSelectedLang(String lang) {
    _selectedLang = lang;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _userProvider.getNotification().then((notification) => {
      setState(() {
        _isOff = notification;
      })
    });
    _userProvider.getLang().then((lang) => _loadSelectedLang(lang)).onError((err, a) => _loadSelectedLang("en"));
    super.initState();
  }

  void _restartApp() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MyApp()),
          (route) => false,
    );
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Expanded(
                      child: HeaderText(
                        AppLocalizations.of(context)!.settings,
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
                        title: AppLocalizations.of(context)!.notification,
                        description: _isOff ? AppLocalizations.of(context)!.notification_info : AppLocalizations.of(context)!.notification_info_on,
                        icon: Icons.notifications,
                        onClick: () {
                          setState(() {
                            _isOff = !_isOff;
                            _userProvider.setNotification(_isOff);
                          });
                        },
                      ),
                      if (!_loading)
                      _createDropDown()
                    ],
                  ),
                ),
              ),
              ProfileChangeButton(
                title: AppLocalizations.of(context)!.logout,
                description: "",
                color: AppColor.sent,
                titleColor: AppColor.sent,
                icon: Icons.logout_rounded,
                onClick: () {
                  UserProvider().setAuthToken(null).then((value) => {
                    NavigationUtils.put(context, const LoginPage())
                  });
                },
              ),
            ],
          ),
        )
    );
  }

  DropdownButtonFormField2 _createDropDown() {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      alignment: Alignment.center,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(),
        hintText: _selectedLang == "en" ? "English" : _selectedLang == "ru"? "Русский" : "Қазақша",
        hintStyle: const TextStyle(
            color: Color.fromRGBO(194, 194, 194, 1)
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(216, 218, 220, 1)
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(216, 218, 220, 1)
            ),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
      hint: Text(
        _selectedLang == "en" ? "English" : _selectedLang == "ru"? "Русский" : "Қазақша",
        style: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontFamily: 'Rubik',
            fontSize: 16,
            fontWeight: FontWeight.normal
        ),
      ),
      items: _languages.map((item) => DropdownMenuItem<String>(
        value: item,
        alignment: Alignment.center,
        child: Text(
          item,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Rubik',
              fontSize: 16,
              fontWeight: FontWeight.normal
          ),
        ),
      )).toList(),
      onChanged: (value) {
        String lang = value == "English" ? "en" : value == "Русский" ? "ru" : "kk";
        _userProvider.setLang(lang).then((r) => _restartApp());
      },
      onSaved: (value) {
      },
      buttonStyleData: const ButtonStyleData(
        decoration: BoxDecoration(
            color: Colors.white
        ),
        padding: EdgeInsets.only(right: 0, left: 10),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          color: Colors.white,
        ),
        iconSize: 10,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}