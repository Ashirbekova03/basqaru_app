import 'package:basqary/domain/api/category.dart';
import 'package:basqary/domain/data/category/request/AddCategoryRequest.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/message_hint.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_button.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddCategoryPage extends StatefulWidget {

  const AddCategoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddCategoryPage();
}

class _AddCategoryPage extends State<AddCategoryPage> {

  final CategoryAPI _categoryAPI = CategoryAPI();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _limitController = TextEditingController();
  final TextEditingController _iconController = TextEditingController();

  final MaskTextInputFormatter _limitMask = MaskTextInputFormatter(
      mask: '\$#########',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  void _addCategory() {
    if (_nameController.text.isNotEmpty && _limitController.text.isNotEmpty && _iconController.text.isNotEmpty) {
      _categoryAPI.addCategory(
          AddCategoryRequest(
              name: _nameController.text,
              limit: double.parse(_limitController.text.replaceAll("\$", "")),
              imageUrl: _iconController.text
          )
      ).then((value) => {
        MessageHint.showMessage("Category added"),
        Navigator.of(context).pop()
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                      "Add category",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(width: 35),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, top: 20),
                child: Column(
                  children: [
                    PrimaryTextField(
                      hint: "Category name",
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      action: TextInputAction.next,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: PrimaryTextField(
                        hint: "Limit",
                        controller: _limitController,
                        keyboardType: TextInputType.text,
                        action: TextInputAction.next,
                        formatter: _limitMask,
                      ),
                    ),
                    PrimaryTextField(
                      hint: "Category image url",
                      controller: _iconController,
                      maxLength: 300,
                      keyboardType: TextInputType.text,
                      action: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: AppSize.bottomMargin),
              child: PrimaryButton(
                "Add category",
                onPressed: () {
                  _addCategory();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}