import 'package:basqary/domain/api/category.dart';
import 'package:basqary/domain/api/profile.dart';
import 'package:basqary/domain/api/transactions.dart';
import 'package:basqary/domain/data/transaction/request/PeriodFilter.dart';
import 'package:basqary/domain/data/user/response/ProfileResponse.dart';
import 'package:basqary/presentation/data/CategoryAnalyricsViewModel.dart';
import 'package:basqary/presentation/data/CategoryViewModel.dart';
import 'package:basqary/presentation/data/TransactionViewModel.dart';
import 'package:basqary/presentation/ui/analytics/analytics_line_chart.dart';
import 'package:basqary/presentation/ui/analytics/analytics_screen_widget.dart';
import 'package:basqary/presentation/ui/analytics/category_analytics_chart.dart';
import 'package:basqary/presentation/ui/custom/widget/loader_content.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {

  const AnalyticsPage({super.key});

  @override
  State<StatefulWidget> createState() => _AnalyticsPage();
}

class _AnalyticsPage extends State<AnalyticsPage> {

  final ProfileAPI _profileAPI = ProfileAPI();
  final TransactionsAPI _transactionsAPI = TransactionsAPI();
  final CategoryAPI _categoryAPI = CategoryAPI();
  final List<int> _periodRange = [604800000, 2678400000, 31536000000];
  final List<TransactionViewModel> _transactions = [];
  final List<CategoryViewModel> _categories = [];
  final List<CategoryAnalyticsViewModel> _categoryAnalytics = [];
  late ProfileViewModel _profile;
  bool _loading = true;
  int _period = 0;
  double _received = 0;
  double _spent = 0;

  void _loadPage() {
    setState(() {
      _loading = true;
    });
    _received = 0;
    _spent = 0;
    _transactions.clear();
    _categories.clear();
    _categoryAnalytics.clear();
    _profileAPI.getProfile().then((value) => {
      _profile = value,
      _loadTransactions()
    });
  }

  void _loadTransactions() {
    int now = DateTime.now().millisecondsSinceEpoch;
    _transactionsAPI.filter(
      PeriodFilter(
        from: now - _periodRange[_period],
        to: now
      )
    ).then((value) => {
      _transactions.addAll(value),
      _loadCategories()
    });
  }

  void _loadCategories() {
    _categoryAPI.findAll().then((value) => {
      _categories.addAll(value),
      _makeStatistics()
    });
  }

  void _makeStatistics() {
    for (var transaction in _transactions) {
      if (transaction.isReceive) {
        _received += transaction.amount;
      } else {
        _spent += transaction.amount;
      }
    }
    _categoryAnalyticsBuild();
    setState(() {
      _loading = false;
    });
  }

  void _categoryAnalyticsBuild() {
    for (var category in _categories) {
      var categoryAnalytics = CategoryAnalyticsViewModel(
        category: category,
        spent: 0
      );
      for (var transaction in _transactions) {
        if (!transaction.isReceive && transaction.category.id == category.id) {
          categoryAnalytics.spent += transaction.amount;
        }
      }
      _categoryAnalytics.add(categoryAnalytics);
    }
  }

  @override
  void initState() {
    _loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading == false ? AnalyticsScreenWidget(
      pageContext: context,
      balance: _profile.balance,
      spent: _spent,
      received: _received,
      // 0 - 7 days, 1 - month, 2 - year
      onPeriodChanged: (selectedPeriod) {
        _period = selectedPeriod;
        _loadPage();
      },
      children: [
        AnalyticsLineChart(_transactions),
        CategoryAnalyticsChart(
          balance: _spent,
          analytics: _categoryAnalytics,
        )
      ]
    ) : const LoaderContentWidget();
  }
}