import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
  final TextInputAction action;
  final Function onSubmitted;

  const SearchTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.onSubmitted,
    this.action = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColor.border,
        ),
        borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              autocorrect: false,
              maxLines: 1,
              textAlign: TextAlign.start,
              onFieldSubmitted: (value) {
                onSubmitted.call(value);
              },
              style: const TextStyle(
                  color: AppColor.text,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Inter'
              ),
              maxLength: 30,
              textInputAction: action,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                counterText: "",
                fillColor: Colors.transparent,
                border: const OutlineInputBorder(),
                hintText: hint,
                hintStyle: const TextStyle(
                    color: AppColor.secondaryText
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 22),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search_rounded,
              color: Colors.black.withOpacity(0.4),
              size: 24,
            ),
          )
        ],
      ),
    );
  }

}