import 'package:basqary/presentation/data/TransactionViewModel.dart';
import 'package:basqary/presentation/ui/custom/constant/app_color.dart';
import 'package:basqary/presentation/ui/custom/formatter/formatter.dart';
import 'package:basqary/presentation/ui/custom/widget/loader_content.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsLineChart extends StatefulWidget {

  final List<TransactionViewModel> transactions;

  const AnalyticsLineChart(this.transactions, {super.key});

  @override
  State<StatefulWidget> createState() => _AnalyticsLineChart();
}

class _AnalyticsLineChart extends State<AnalyticsLineChart> {

  bool _loading = true;

  List<Color> gradientColors = [
    AppColor.secondary,
    AppColor.primary,
  ];

  final List<String> _ranges = [];
  final List<FlSpot> _statistics = [];

  void _loadRanges() {
    double maxAmount = widget.transactions.map((e) => e.amount).reduce((a, b) => a > b ? a : b);
    List<double> ranges = [0];
    _ranges.add("0");
    double step = maxAmount / 5;
    for (int i = 1; i <= 5; i++) {
      double range = step * i;
      ranges.add(range);
      _ranges.add(Formatter.formatRange(range.toInt()));
    }
    for (int i = 0; i < widget.transactions.length; i++) {
      double current = widget.transactions[i].amount;
      if (current == 0) {
       _statistics.add(FlSpot(i.toDouble(), 0));
      } else {
        for (int j = 1; j < ranges.length; j++) {
          if (current < ranges[j]) {
            current -= ranges[j - 1];
            if (current == 0) {
              _statistics.add(FlSpot(i.toDouble(), j - 1));
              break;
            }
            double percent = (ranges[j] - ranges[j - 1]) / 100.0;
            double result = (current / percent) / 100;
            _statistics.add(FlSpot(i.toDouble(), (j - 1) + result));
            break;
          } else if (current == ranges[j]) {
            _statistics.add(FlSpot(i.toDouble(), j.toDouble()));
            break;
          }
        }
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      _loading = true;
    });
    _loadRanges();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading == false ? SizedBox(
      height: 200,
      child: LineChart(
        mainData(),
      ),
    ) : const LoaderContentWidget(height: 200);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 11,
      fontFamily: 'Inter',
      color: Colors.black
    );
    if (value.toInt() > 5) {
      return Container();
    }
    return Text(_ranges[value.toInt()], style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: _getClipItem,
          getTooltipColor: _clipColor
        ),
        longPressDuration: const Duration(milliseconds: 1),
        getTouchedSpotIndicator: _getTouchLine,
      ),
      gridData: FlGridData(
      show: true,
      horizontalInterval: 1,
      drawVerticalLine: false,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: AppColor.border,
          strokeWidth: 1,
        );
      }),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      minY: 0,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: _statistics,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map(
                  (color) => color.withOpacity(0.2)
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }

  List<TouchedSpotIndicatorData> _getTouchLine(LineChartBarData barData, List<int> indicators) {
    return indicators.map((int index) {
      return TouchedSpotIndicatorData(
          const FlLine(color: AppColor.border, strokeWidth: 2, dashArray: [10]),
          FlDotData(
            getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
              radius: 5,
              color: AppColor.secondary,
              strokeWidth: 4,
              strokeColor: Colors.white,
            ),
          )
      );
    }).toList();
  }

  List<LineTooltipItem> _getClipItem(List<LineBarSpot> touchedSpots) {
    return touchedSpots.map((LineBarSpot touchedSpot) {
      // return LineTooltipItem(touchedSpot.x.toString(), textStyle);
      return LineTooltipItem(
        Formatter.formatCurrency(widget.transactions[touchedSpot.x.toInt()].amount),
        const TextStyle(
          color: Colors.white,
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
          fontSize: 12,
        )
      );
    }).toList();
  }

  Color _clipColor(LineBarSpot touchedSpot) {
    return AppColor.secondary;
  }
}