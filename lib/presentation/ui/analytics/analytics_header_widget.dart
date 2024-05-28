import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:flutter/material.dart';

class AnalyticsHeaderWidget extends StatefulWidget {

  final BuildContext pageContext;
  final Function onPeriodChanged;

  const AnalyticsHeaderWidget({
    super.key,
    required this.pageContext,
    required this.onPeriodChanged
  });

  @override
  State<StatefulWidget> createState() => _AnalyticsHeaderWidget();
}

class _AnalyticsHeaderWidget extends State<AnalyticsHeaderWidget> {

  int _selectedTypeIndex = 0;
  final List<String> _typeValues = [];

  @override
  void initState() {
    _typeValues.addAll(
        [
          "Week",
          "Month",
          "Year"
        ]
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.only(top: AppSize.topMargin, left: AppSize.horizontal, right: AppSize.horizontal),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: HeaderText(
              AppLocalizations.of(context)!.categories,
              textAlign: TextAlign.center,
              style: HeaderText.defaultStyle.apply(
                  color: Colors.white
              ),
            ),
          ),
          Row(
            children: [
              PopupMenuButton(
                surfaceTintColor: Colors.white,
                color: Colors.white,
                padding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                clipBehavior: Clip.hardEdge,
                itemBuilder: _generatePopupActions,
                onSelected: (value) {
                  setState(() {
                    _selectedTypeIndex = int.parse(value.toString());
                  });
                  widget.onPeriodChanged.call(_selectedTypeIndex);
                },
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 4),
                      child: Text(
                        _typeValues[_selectedTypeIndex],
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: 18,
                    )
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          )
        ],
      ),
    );
  }


  List<PopupMenuEntry<Object>> _generatePopupActions(BuildContext context) {
    List<PopupMenuEntry<Object>> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(
        PopupMenuItem(
          height: 40,
          value: i,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 60),
                child: Text(
                  _typeValues[i],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),
              Expanded(child: Container()),
              if (i == _selectedTypeIndex) const Icon(
                Icons.check,
                color: AppColor.primary,
                size: 14,
              )
            ],
          ),
        )
      );
    }
    return list;
  }
}