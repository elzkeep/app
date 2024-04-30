// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zkeep/config/config.dart';

class _LineChart extends StatelessWidget {
  const _LineChart();

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 1,
        maxX: 7,
        maxY: 10,
        minY: 0,
      );

  LineTouchData get lineTouchData => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData =>
      [lineChartBarData, lineChartBarData1];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 2:
        text = '2';
        break;
      case 4:
        text = '4';
        break;
      case 6:
        text = '6';
        break;
      case 8:
        text = '8';
        break;
      case 10:
        text = '10';
        break;
      default:
        return Container();
    }

    return Text(text, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    // const style = TextStyle(
    //   fontWeight: FontWeight.bold,
    //   fontSize: 11,
    // );
    Widget text;
    switch (value.toInt()) {
      // case 1:
      //   text = const Text('1월');
      //   break;
      case 2:
        text = const Text('2월');
        break;
      case 3:
        text = const Text('3월');
        break;
      case 4:
        text = const Text('4월');
        break;
      case 5:
        text = const Text('5월');
        break;
      case 6:
        text = const Text('6월');
        break;
      case 7:
        text = const Text('7월');
      //   break;
      // case 8:
      //   text = const Text('8월');
      //   break;
      // case 9:
      //   text = const Text('9월');
      //   break;
      // case 10:
      //   text = const Text('10월');
      //   break;
      // case 11:
      //   text = const Text('11월');
      //   break;
      // case 12:
      //   text = const Text('12월');
      //   break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: Config.buttonColor.withOpacity(0.2), width: 1),
          left:
              BorderSide(color: Config.buttonColor.withOpacity(0.2), width: 1),
          right:
              BorderSide(color: Config.buttonColor.withOpacity(0.2), width: 1),
          top: BorderSide(color: Config.buttonColor.withOpacity(0.2), width: 1),
        ),
      );

  LineChartBarData get lineChartBarData => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Config.primaryColor.withOpacity(0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 0),
          FlSpot(2, 1),
          FlSpot(3, 1),
          FlSpot(4, 4),
          FlSpot(5, 4),
          FlSpot(6, 2),
          FlSpot(7, 0),
        ],
      );

  LineChartBarData get lineChartBarData1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Config.titleColor.withOpacity(0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 0),
          FlSpot(2, 0),
          FlSpot(3, 0),
          FlSpot(4, 1),
          FlSpot(5, 2),
          FlSpot(6, 2),
          FlSpot(7, 2),
        ],
      );
}

class CLineChart extends StatefulWidget {
  const CLineChart({super.key});

  @override
  State<StatefulWidget> createState() => CLineChartState();
}

class CLineChartState extends State<CLineChart> {
  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
