import 'package:basqary/domain/api/profile.dart';
import 'package:basqary/domain/data/user/response/ProfileResponse.dart';
import 'package:basqary/presentation/ui/change_password/change_password_page.dart';
import 'package:basqary/presentation/ui/change_profile/change_profile_page.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:basqary/presentation/ui/custom/widget/loader_content.dart';
import 'package:basqary/presentation/ui/profile/profile_change_button.dart';
import 'package:basqary/presentation/ui/profile/profile_header.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePage();

}

class _ProfilePage extends State<ProfilePage> {

  final ProfileAPI _profileAPI = ProfileAPI();
  late ProfileViewModel _profile;
  bool _loading = true;

  void _loadProfile() {
    setState(() {
      _loading = true;
    });
    _profileAPI.getProfile().then((value) => {
      _profile = value,
      setState(() {
        _loading = false;
      })
    });
  }

  @override
  void initState() {
    _loadProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_loading ? Stack(
      children: [
        Image.asset(
          "assets/images/top.png",
          width: double.infinity,
          height: 400,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        Container(
          margin: const EdgeInsets.only(top: 140),
          child: Column(
            children: [
              SizedBox(
                height: 110,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 55,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40)
                          )
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 110,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColor.secondary,
                              width: 5
                          )
                      ),
                      child: Text(
                        _profile.fullName.isEmpty ? "" : _profile.fullName[0],
                        style: const TextStyle(
                            color: AppColor.secondary,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 40
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                color: Colors.white,
                child: Column(
                  children: [
                    ProfileChangeButton(
                      title: _profile.fullName,
                      description: "Click to change profile name",
                      icon: Icons.person,
                      onClick: () {
                        NavigationUtils.pushResult(context, ChangeProfilePage(
                          profile: _profile,
                        ), () { _loadProfile(); });
                      },
                    ),
                    ProfileChangeButton(
                      title: _profile.email,
                      description: "Click to change email",
                      icon: Icons.mail,
                      onClick: () {
                        NavigationUtils.pushResult(context, ChangeProfilePage(
                          profile: _profile,
                        ), () { _loadProfile(); });
                      },
                    ),
                    ProfileChangeButton(
                      title: "Change password",
                      description: "Click to change password",
                      icon: Icons.password,
                      onClick: () {
                        NavigationUtils.pushResult(
                            context, const ChangePasswordPage(),
                            () { _loadProfile(); }
                        );
                      },
                    ),
                    ProfileChangeButton(
                      title: "Privacy Policy",
                      description: "Download file",
                      icon: Icons.privacy_tip,
                      onClick: () {

                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        ProfileHeaderWidget(pageContext: context)
      ],
    ) : const LoaderContentWidget();
  }
}