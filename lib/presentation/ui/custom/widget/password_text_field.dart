import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {

  final String hint;
  final TextEditingController controller;
  final TextInputAction action;

  const PasswordTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.action = TextInputAction.done,
  });

  @override
  State<StatefulWidget> createState() => _PasswordTextField();
}

class _PasswordTextField extends State<PasswordTextField> {

  bool _isSecured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.border,
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: _isSecured,
              autocorrect: false,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: AppColor.text,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Inter'
              ),
              maxLength: 30,
              textInputAction: widget.action,
              controller: widget.controller,
              decoration: InputDecoration(
                filled: true,
                counterText: "",
                fillColor: Colors.transparent,
                border: const OutlineInputBorder(),
                hintText: widget.hint,
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
            margin: const EdgeInsets.only(left: 4, right: 6),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isSecured = !_isSecured;
                });
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Icon(
                  _isSecured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.black,
                  size: 22,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}