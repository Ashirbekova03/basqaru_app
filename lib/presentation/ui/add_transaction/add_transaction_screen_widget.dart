import 'package:basqary/domain/api/category.dart';
import 'package:basqary/presentation/data/CategoryViewModel.dart';
import 'package:basqary/presentation/ui/add_transaction/add_transaction_header_widget.dart';
import 'package:basqary/presentation/ui/add_transaction/amount_input_widget.dart';
import 'package:basqary/presentation/ui/add_transaction/categories_selector_widget.dart';
import 'package:basqary/presentation/ui/category/add_category_page.dart';
import 'package:basqary/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:basqary/presentation/ui/custom/widget/add_button.dart';
import 'package:basqary/presentation/ui/custom/widget/empy_content.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/loader_content.dart';
import 'package:basqary/presentation/ui/custom/widget/swtich_selector.dart';
import 'package:flutter/material.dart';

class AddTransactionScreenWidget extends StatefulWidget {

  final List<Widget> children;
  final TextEditingController amountController;
  final Function onTypeChanged;
  final Function onCategorySelected;
  final BuildContext pageContext;

  const AddTransactionScreenWidget({
    super.key,
    required this.children,
    required this.amountController,
    required this.onTypeChanged,
    required this.pageContext,
    required this.onCategorySelected,
  });

  @override
  State<StatefulWidget> createState() => _AddTransactionScreenWidget();
}

class _AddTransactionScreenWidget extends State<AddTransactionScreenWidget> {

  final CategoryAPI _categoryAPI = CategoryAPI();
  final List<CategoryViewModel> _categories = [];
  bool _loading = true;

  void _loadPage() {
    setState(() {
      _loading = true;
    });
    _categories.clear();
    _categoryAPI.findAll().then((value) => {
      _categories.addAll(value),
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
    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              "assets/images/top.png",
              width: double.infinity,
              height: 350,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
            Container(
              height: 350,
              padding: const EdgeInsets.only(top: 130),
              child: Column(
                children: [
                  AmountInputWidget(widget.amountController),
                  Expanded(
                    child: Column(
                      children: [
                        SwitchSelectorWidget(
                          onChanged: (isFirst) {
                            widget.onTypeChanged.call(isFirst);
                          },
                          first: "Received",
                          second: "Spent",
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 28, bottom: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)
                        )
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: HeaderText(
                            "Categories",
                            style: HeaderText.smallerStyle,
                          ),
                        ),
                        AddButton(
                          onPressed: () {
                            NavigationUtils.pushResult(
                              widget.pageContext,
                              const AddCategoryPage(),
                              () {_loadPage();}
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            AddTransactionHeaderWidget(widget.pageContext)
          ],
        ),
        Expanded(
          child: _loading == false ? _categories.isNotEmpty ? CategoriesSelectorWidget(
            onCategorySelected: widget.onCategorySelected,
            categories: _categories,
          ) : const EmptyContentWidget() : const LoaderContentWidget(),
        )
      ],
    );
  }
}