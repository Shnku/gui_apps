import 'package:currency_converter/providermodel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

BarChartData getBarChartData(BuildContext ctx) {
  final provided = Provider.of<DataProvider>(ctx);
  List barDatas = provided.barDatas;
  debugPrint(barDatas.toString());
  return BarChartData(
    backgroundColor: Colors.indigo.withOpacity(0.2),
    borderData: FlBorderData(
        show: true,
        border: const Border(
          left: BorderSide(),
          bottom: BorderSide(),
          right: BorderSide(),
        )),
    titlesData: FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 55,
        ),
      ),
      leftTitles: const AxisTitles(
        axisNameWidget: Card(
          color: Color.fromARGB(24, 62, 0, 231),
          child: Text(
            '  TOP  CURRENCIES  COMPARE  ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        axisNameSize: 40,
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) =>
              getBottomTitles(value, meta, provided.to, provided.tags),
        ),
      ),
    ),
    barGroups: barDatas
        .map((data) => BarChartGroupData(
              x: data['x'] ?? 0,
              barRods: [
                BarChartRodData(
                  color: Colors.white.withAlpha(150),
                  toY: 100 / getValue(data),
                  // fromY: getValue(data), // it's doing wrong
                  width: 25,
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            ))
        .toList(),
  );
}

Widget getBottomTitles(double value, TitleMeta meta, var ctx, final tag) {
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text(ctx.toString().toUpperCase());
      break;
    case 1:
      text = Text(tag[0].toString().toUpperCase());
      break;
    case 2:
      text = Text(tag[1].toString().toUpperCase());
      break;
    case 3:
      text = Text(tag[2].toString().toUpperCase());
      break;
    case 4:
      text = Text(tag[3].toString().toUpperCase());
      break;
    case 5:
      text = Text(tag[4].toString().toUpperCase());
      break;
    default:
      text = const Text('N');
      break;
  }
  return text;
}

double getValue(var data) {
  double res = (data['y'] is int)
      ? (data['y'] as int).toDouble()
      : (data['y'] is double)
          ? data['y']
          : double.tryParse(data['y'].toString()) ?? 0.0;
  return res == 0 ? 1 : res;
}
