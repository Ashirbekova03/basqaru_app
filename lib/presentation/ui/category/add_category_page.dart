import 'dart:io';

import 'package:basqary/domain/api/category.dart';
import 'package:basqary/domain/data/category/request/AddCategoryRequest.dart';
import 'package:basqary/domain/s3/s3_uploader.dart';
import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/description_text.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/message_hint.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_button.dart';
import 'package:basqary/presentation/ui/custom/widget/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _imageFile;
  String _image = "";

  final MaskTextInputFormatter _limitMask = MaskTextInputFormatter(
      mask: '\$#########',
      filter: { "#": RegExp(r'[0-9]') },
      type: MaskAutoCompletionType.lazy
  );

  void _addCategory() {
    if (_nameController.text.isNotEmpty && _limitController.text.isNotEmpty) {
      S3Uploader().uploadFileToS3(_imageFile!).then((value) => {
        _finallyCreateCategory(value)
      }).onError((error, stackTrace) => {
        _finallyCreateCategory("")
      });
    } else {
      _finallyCreateCategory("");
    }
  }

  void _finallyCreateCategory(imageUrl) {
    _categoryAPI.addCategory(
        AddCategoryRequest(
            name: _nameController.text,
            limit: double.parse(_limitController.text.replaceAll("\$", "")),
            imageUrl: imageUrl
        )
    ).then((value) => {
      MessageHint.showMessage(AppLocalizations.of(context)!.category_added),
      Navigator.of(context).pop()
    });
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

  void _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);
      setState(() {
        _image = image.path;
      });
    }
  }

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
                Expanded(
                  child: HeaderText(
                    AppLocalizations.of(context)!.add_category,
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
                    hint: AppLocalizations.of(context)!.category_name,

                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    action: TextInputAction.next,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: PrimaryTextField(
                      hint: AppLocalizations.of(context)!.limit,
                      controller: _limitController,
                      keyboardType: TextInputType.text,
                      action: TextInputAction.next,
                      formatter: _limitMask,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: InkWell(
                      onTap: () {
                        _selectImage();
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.border)
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/upload.png",
                              height: 40,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 11),
                              child: DescriptionText(
                                  AppLocalizations.of(context)!.upload
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 81,
                    height: 81,
                    child: _image.isNotEmpty ? ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: Image.file(
                        File(_image),
                        width: 81,
                        height: 81,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ) : Container(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: AppSize.bottomMargin),
            child: PrimaryButton(
              AppLocalizations.of(context)!.add_category,
              onPressed: () {
                _addCategory();
              },
            ),
          )
        ],
      ),
    );
  }
}