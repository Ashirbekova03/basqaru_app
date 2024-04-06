import 'package:basqary/presentation/data/CategoryAnalyricsViewModel.dart';
import 'package:basqary/presentation/ui/analytics/category_analytics_item.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/formatter/formatter.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryAnalyticsChart extends StatefulWidget {

  final List<CategoryAnalyticsViewModel> analytics;
  final double balance;

  const CategoryAnalyticsChart({
    super.key,
    required this.balance,
    required this.analytics
  });

  @override
  State<StatefulWidget> createState() => _CategoryAnalyticsChart();
}

class _CategoryAnalyticsChart extends State<CategoryAnalyticsChart> {

  final List<Color> _colors = [
    AppColor.sent,
    AppColor.secondary,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.deepOrange,
    Colors.pink,
    Colors.purple,
    Colors.pinkAccent,
    Colors.deepOrangeAccent,
    Colors.cyanAccent,
    Colors.cyan
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: HeaderText(
                  Formatter.formatCurrency(widget.balance),
                  style: HeaderText.defaultStyle.apply(
                      color: AppColor.secondary
                  ),
                ),
              ),
              PieChart(
                PieChartData(
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 100,
                  sections: List.generate(
                    widget.analytics.length,
                    (index) => PieChartSectionData(
                      radius: 20,
                      color: _colors[index],
                      value: widget.analytics[index].spent,
                      showTitle: false
                    ),
                  )
                )
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            widget.analytics.length,
                (index) => CategoryAnalyticsItemWidget(
              category: widget.analytics[index],
              color: _colors[index],
            ),
          ),
        )
      ],
    );
  }

}