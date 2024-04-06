import 'package:basqary/presentation/data/CategoryAnalyricsViewModel.dart';
import 'package:basqary/presentation/data/CategoryViewModel.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/formatter/formatter.dart';
import 'package:flutter/material.dart';

class CategoryAnalyticsItemWidget extends StatelessWidget {

  final CategoryAnalyticsViewModel category;
  final Color color;

  const CategoryAnalyticsItemWidget({
    super.key,
    required this.category,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    double percentPerOne = category.category.limit / 100.0;
    double currentPercent = category.spent / percentPerOne;
    bool isMore = false;
    double maxWidth = MediaQuery.of(context).size.width - 102;
    double percentWidth = maxWidth / 100.0 * currentPercent;
    if (category.spent > category.category.limit) {
      isMore = true;
      percentWidth = maxWidth;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(bottom: 20, right: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color
            ),
            child: Image.network(
              category.category.imageUrl,
              width: 30,
              height: 30,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      category.category.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Expanded(
                      child: Text(
                        Formatter.formatCurrency(category.category.limit),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                  width: maxWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Stack(
                      children: [
                        Container(
                          width: maxWidth,
                          height: 8,
                          color: AppColor.border,
                        ),
                        Container(
                          width: percentWidth,
                          height: 8,
                          color: color,
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  "Spent: ${Formatter.formatCurrency(category.spent)}",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: isMore ? AppColor.sent : Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}