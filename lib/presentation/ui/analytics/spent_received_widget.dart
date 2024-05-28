import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/formatter/formatter.dart';
import 'package:flutter/material.dart';

class SpentReceivedWidget extends StatelessWidget {

  final double received;
  final double spent;

  const SpentReceivedWidget({
    super.key,
    required this.received,
    required this.spent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 7),
            padding: const EdgeInsets.only(top: 7, bottom: 10, left: 14, right: 18),
            decoration: BoxDecoration(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.received,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 6),
                      child: const Icon(
                        Icons.file_download_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Text(
                      Formatter.formatCurrency(received),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 7),
            padding: const EdgeInsets.only(top: 7, bottom: 10, left: 14, right: 18),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.spent,
                  style: const TextStyle(
                      color: AppColor.secondary,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 6),
                      child: const Icon(
                        Icons.file_upload_outlined,
                        color: AppColor.secondary,
                        size: 24,
                      ),
                    ),
                    Text(
                      Formatter.formatCurrency(spent),
                      style: const TextStyle(
                          color: AppColor.secondary,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}