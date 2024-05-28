import 'package:basqary/domain/api/profile.dart';
import 'package:basqary/domain/api/transactions.dart';
import 'package:basqary/domain/data/user/response/ProfileResponse.dart';
import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/data/CategoryViewModel.dart';
import 'package:basqary/presentation/data/TransactionViewModel.dart';
import 'package:basqary/presentation/ui/add_transaction/add_transaction_page.dart';
import 'package:basqary/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:basqary/presentation/ui/custom/widget/add_button.dart';
import 'package:basqary/presentation/ui/custom/widget/empy_content.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/loader_content.dart';
import 'package:basqary/presentation/ui/wallet/transaction_widget.dart';
import 'package:basqary/presentation/ui/wallet/wallet_screen_widget.dart';
import 'package:flutter/material.dart';

class WalletPage extends StatefulWidget {

  const WalletPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WalletPage();
  }
}

class _WalletPage extends State<WalletPage> {

  final ProfileAPI _profileAPI = ProfileAPI();
  final TransactionsAPI _transactionsAPI = TransactionsAPI();
  late ProfileViewModel _profile;
  final List<TransactionViewModel> _transactions = [];
  bool _loading = true;

  void _loadPage() {
    setState(() {
      _loading = true;
    });
    _transactions.clear();
    _profileAPI.getProfile().then((value) => {
      _profile = value,
      _loadTransactions()
    });
  }

  void _loadTransactions() {
    _transactionsAPI.findAll().then((value) => {
      _transactions.addAll(value.reversed),
      setState(() {
        _loading = false;
      })
    });
  }

  @override
  void initState() {
    _loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !_loading ? WalletScreenWidget(
      balance: _profile.balance,
      children: [
        Row(
          children: [
            Expanded(
              child: HeaderText(
                AppLocalizations.of(context)!.my_transactions,
                style: HeaderText.smallerStyle,
              ),
            ),
            AddButton(
              onPressed: () {
                NavigationUtils.pushResult(
                  context,
                  const AddTransactionPage(),
                  () { _loadPage(); }
                );
              },
            )
          ],
        ),
        _transactions.isNotEmpty ? Container(
          margin: const EdgeInsets.only(top: 14),
          child: Column(
            children: List.generate(
                _transactions.length,
                (index) => TransactionWidget(
                _transactions[index]
              )
            ),
          ),
        ) : const EmptyContentWidget()
      ],
    ) : const LoaderContentWidget();
  }
}