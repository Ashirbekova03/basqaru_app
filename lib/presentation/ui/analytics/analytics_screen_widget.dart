import 'package:basqary/presentation/ui/analytics/analytics_header_widget.dart';
import 'package:basqary/presentation/ui/analytics/spent_received_widget.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/scrollable_page.dart';
import 'package:basqary/presentation/ui/wallet/available_balance_widget.dart';
import 'package:flutter/material.dart';

class AnalyticsScreenWidget extends StatefulWidget {

  final List<Widget> children;
  final Function onPeriodChanged;
  final BuildContext pageContext;
  final double received;
  final double spent;
  final double balance;

  const AnalyticsScreenWidget({
    super.key,
    required this.children,
    required this.onPeriodChanged,
    required this.pageContext,
    required this.received,
    required this.spent,
    required this.balance
  });

  @override
  State<StatefulWidget> createState() => _AnalyticsScreenWidget();
}

class _AnalyticsScreenWidget extends State<AnalyticsScreenWidget> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/top.png",
          width: double.infinity,
          height: 400,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        Container(
          margin: const EdgeInsets.only(top: 130, left: AppSize.horizontal, right: AppSize.horizontal),
          child: Column(
            children: [
              AvailableBalanceWidget(
                balance: widget.balance,
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: SpentReceivedWidget(
                  received: widget.received,
                  spent: widget.spent,
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              topLeft: Radius.circular(40),
            ),
            child: ScrollablePage(
              children: [
                Container(
                  height: 240,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 28),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40)
                      )
                  ),
                  child: HeaderText(
                    "Transactions",
                    style: HeaderText.smallerStyle,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 28, bottom: 100),
                  color: Colors.white,
                  child: Column(
                    children: widget.children,
                  ),
                )
              ],
            ),
          ),
        ),
        AnalyticsHeaderWidget(
          pageContext: widget.pageContext,
          onPeriodChanged: widget.onPeriodChanged,
        )
      ],
    );
  }
}