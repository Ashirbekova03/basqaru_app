import 'package:basqary/presentation/ui/custom/widget/description_text.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';

class AmountInputWidget extends StatelessWidget {

  final TextEditingController amountController;

  const AmountInputWidget(
    this.amountController,{
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DescriptionText(
            "Enter amount",
            textAlign: TextAlign.center,
            style: DescriptionText.defaultStyle.apply(
                color: Colors.white
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: TextFormField(
              inputFormatters: [
                MaskTextInputFormatter(
                    mask: '\$######',
                    filter: { "#": RegExp(r'[0-9]') },
                    type: MaskAutoCompletionType.lazy
                )
              ],
              keyboardType: TextInputType.number,
              autocorrect: false,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter'
              ),
              maxLength: 10,
              textInputAction: TextInputAction.done,
              controller: amountController,
              decoration: InputDecoration(
                filled: true,
                counterText: "",
                fillColor: Colors.transparent,
                border: const OutlineInputBorder(),
                hintText: "\$0",
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5)
                ),
                contentPadding: EdgeInsets.zero,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

}