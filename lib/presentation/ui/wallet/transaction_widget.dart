import 'package:basqary/presentation/data/TransactionViewModel.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/formatter/formatter.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {

  final TransactionViewModel transaction;

  const TransactionWidget(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      margin: const EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ]
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(right: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.5),
              shape: BoxShape.circle
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                transaction.category.imageUrl,
                width: 30,
                height: 30,
                color: Colors.white,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.category.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Text(
                    Formatter.parseDateTime(transaction.dateTime),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                )
              ],
            ),
          ),
          if (transaction.isReceive)
          Text(
            "+${Formatter.formatCurrency(transaction.amount)}",
            style: const TextStyle(
              color: AppColor.receive,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold
            ),
          )
          else
          Text(
            "-${Formatter.formatCurrency(transaction.amount)}",
            style: const TextStyle(
              color: AppColor.sent,
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }

}