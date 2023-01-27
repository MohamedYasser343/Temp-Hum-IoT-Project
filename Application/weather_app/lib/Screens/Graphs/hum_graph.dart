import 'dart:async';
import 'dart:convert';
import 'package:cap_app/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class HumGraph extends StatefulWidget {
  const HumGraph({super.key});

  @override
  State<HumGraph> createState() => _HumGraphState();
}

class _HumGraphState extends State<HumGraph> {
  List<HumReadings> chartData = [];
  late TooltipBehavior _tooltipBehavior;
  bool isLoaded = false;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  void dispose() {
    isLoaded = false;
    super.dispose();
  }

  Future<String> getHumgraphData() async {
    if (!isLoaded) {
      await http.get(Uri.parse("$serverIP/Readings")).then((results) {
        var data = jsonDecode(results.body);
        double time = 0;

        for (var u in data) {
          chartData.add(HumReadings(double.parse(u["Hum"].toString()), time));
          time = time + 5;
        }
        return "";
      });
    } else {
      return "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: const Color(0xFF81A4CD),
          centerTitle: true,
          title: const Text(
            "Humidity readings",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder(
          future: getHumgraphData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SfCartesianChart(
                backgroundColor: const Color(0xFFFFFFFF),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <LineSeries>[
                  LineSeries<HumReadings, double>(
                    name: 'Humidity',
                    dataSource: chartData,
                    xValueMapper: (HumReadings time, _) => time.time,
                    yValueMapper: (HumReadings temp, _) => temp.temp,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    color: const Color(0xFF054A91),
                    // width: 4,
                    opacity: 1,
                  )
                ],
                primaryXAxis:
                    NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                // primaryYAxis: NumericAxis(
                //     numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
              );
            }
          },
        ),
      ),
    );
  }
}

class HumReadings {
  HumReadings(this.temp, this.time);
  final double temp;
  final double time;
}
