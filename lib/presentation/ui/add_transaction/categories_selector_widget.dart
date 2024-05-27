import 'package:basqary/presentation/data/CategoryViewModel.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/widget/scrollable_page.dart';
import 'package:flutter/material.dart';

class CategoriesSelectorWidget extends StatefulWidget {

  final Function onCategorySelected;
  final List<CategoryViewModel> categories;

  const CategoriesSelectorWidget({
    super.key,
    required this.onCategorySelected,
    required this.categories
  });

  @override
  State<StatefulWidget> createState() => _CategoriesSelectorWidget();
}

class _CategoriesSelectorWidget extends State<CategoriesSelectorWidget> {

  int _selectedCategoryId = -1;

  @override
  void initState() {
    _selectedCategoryId = widget.categories[0].id;
    widget.onCategorySelected.call(_selectedCategoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 3;
    List<Widget> widgets = [];
    int i = 0;
    for (i = 0; i < widget.categories.length - 2; i += 3) {
      widgets.add(
        Row(
          children: [
            _getCategorySelectorItem(widget.categories[i], width),
            _getCategorySelectorItem(widget.categories[i + 1], width),
            _getCategorySelectorItem(widget.categories[i + 2], width),
          ],
        )
      );
    }
    List<Widget> lastChildren = [];
    while (i < widget.categories.length) {
      lastChildren.add(_getCategorySelectorItem(widget.categories[i], width));
      i++;
    }
    widgets.add(Row(children: lastChildren));
    widgets.add(Container(height: 150));
    return ScrollablePage(
      children: widgets,
    );
  }

  Widget _getCategorySelectorItem(CategoryViewModel category, double width) {
    return Container(
      width: width,
      alignment: Alignment.center,
      child: Container(
        width: 100,
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            widget.onCategorySelected.call(category.id);
            setState(() {
              _selectedCategoryId = category.id;
            });
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.only(bottom: 6),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: _selectedCategoryId == category.id ? AppColor.primary : AppColor.primary.withOpacity(0.5),
                      shape: BoxShape.circle
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      category.imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Text(
                  category.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: _selectedCategoryId == category.id ? FontWeight.w600 : FontWeight.normal
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}