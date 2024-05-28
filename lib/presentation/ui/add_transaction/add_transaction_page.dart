import 'package:basqary/domain/api/transactions.dart';
import 'package:basqary/domain/data/transaction/request/AddTransactionRequest.dart';
import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/data/CategoryViewModel.dart';
import 'package:basqary/presentation/ui/add_transaction/add_transaction_screen_widget.dart';
import 'package:basqary/presentation/ui/custom/widget/message_hint.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_button.dart';
import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {

  const AddTransactionPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddTransactionPage();
  }
}

class _AddTransactionPage extends State<AddTransactionPage> {

  final TransactionsAPI _transactionsAPI = TransactionsAPI();
  final TextEditingController _amountController = TextEditingController();
  bool _isReceive = true;
  int _selectedCategoryId = -1;

  void _addTransaction() {
    if (_selectedCategoryId > 0 && _amountController.text.isNotEmpty) {
      _transactionsAPI.add(
          AddTransactionRequest(
              amount: double.parse(_amountController.text.replaceAll("\$", "")),
              categoryId: _selectedCategoryId,
              isReceive: _isReceive
          )
      ).then((value) => {
        MessageHint.showMessage(AppLocalizations.of(context)!.transaction_added),
        Navigator.of(context).pop()
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _getAddButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: AddTransactionScreenWidget(
        amountController: _amountController,
        pageContext: context,
        onTypeChanged: (isReceive) {
          _isReceive = isReceive;
        },
        onCategorySelected: (categoryId) {
          _selectedCategoryId = categoryId;
        },
        children: [],
      ),
    );
  }

  Widget _getAddButton() {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: const Offset(0.0, 12.0),
            blurRadius: 30,
            spreadRadius: 30,
          ),
        ],
      ),
      child: PrimaryButton(
        AppLocalizations.of(context)!.add_transactions,
        onPressed: () {
          _addTransaction();
        },
      ),
    );
  }
}