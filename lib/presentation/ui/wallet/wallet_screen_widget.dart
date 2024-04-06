import 'package:basqary/presentation/ui/custom/widget/scrollable_page.dart';
import 'package:basqary/presentation/ui/wallet/available_balance_widget.dart';
import 'package:basqary/presentation/ui/wallet/wallet_header_widget.dart';
import 'package:flutter/material.dart';

class WalletScreenWidget extends StatefulWidget {

  final List<Widget> children;
  final double balance;
  const WalletScreenWidget({
    super.key,
    required this.children,
    required this.balance
  });

  @override
  State<StatefulWidget> createState() => _WalletScreenWidget();
}

class _WalletScreenWidget extends State<WalletScreenWidget> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/images/top.png",
          width: double.infinity,
          height: 350,
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
        ),
        Container(
          margin: const EdgeInsets.only(top: 130),
          child: AvailableBalanceWidget(
            balance: widget.balance,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 100),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40)
            ),
            child: ScrollablePage(
              children: [
                Container(
                  height: 180,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 28, bottom: 110),
                  constraints: const BoxConstraints(
                      minHeight: 300
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40)
                      )
                  ),
                  child: Column(
                    children: widget.children,
                  ),
                )
              ],
            ),
          ),
        ),
        const WalletHeaderWidget()
      ],
    );
  }

}