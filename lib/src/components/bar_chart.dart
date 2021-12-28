import 'package:covid_statistics/src/model/covid_statistics.dart';
import 'package:covid_statistics/src/utils/data_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatelessWidget {
  final List<Covid19StatisticsModel> covidDatas;
  final double maxY;
  int _x = 0;

  CovidBarChart({Key? key, required this.covidDatas, required this.maxY}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.y.round().toString(),
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          margin: 20,
          getTitles: (double value) {
            return DataUtils.simpleDateFormat(covidDatas[value.toInt()].stateDt!);
          },
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups => covidDatas.map<BarChartGroupData>((e) {
        return BarChartGroupData(
          x: _x++,
          barRods: [
            BarChartRodData(y: e.calcDecideCnt!, colors: [Colors.lightBlueAccent, Colors.greenAccent])
          ],
          showingTooltipIndicators: [0],
        );
      }).toList();
}
