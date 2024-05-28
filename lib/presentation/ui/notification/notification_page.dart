import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationPage extends StatefulWidget {

  const NotificationPage({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {


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
                const Expanded(
                  child: HeaderText(
                    "Notifications",
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(width: 35),
              ],
            ),
          ),

        ],
      ),
    );
  }
}