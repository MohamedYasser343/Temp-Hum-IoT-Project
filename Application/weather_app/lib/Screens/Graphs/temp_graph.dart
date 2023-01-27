import 'dart:convert';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class TempGraph extends StatefulWidget {
  const TempGraph({super.key});

  @override
  State<TempGraph> createState() => _TempGraphState();
}

class _TempGraphState extends State<TempGraph> {
  List<TempReadings> chartData = [];
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

  Future<String> getTempgraphData() async {
    if (!isLoaded) {
      await http.get(Uri.parse("$serverIP/Readings")).then((results) {
        var data = jsonDecode(results.body);
        double time = 0;

        for (var u in data) {
          chartData.add(TempReadings(double.parse(u["Temp"].toString()), time));
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
            "Temperature readings",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder(
            future: getTempgraphData(),
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
                    LineSeries<TempReadings, double>(
                      name: 'Temperature',
                      dataSource: chartData,
                      xValueMapper: (TempReadings time, _) => time.time,
                      yValueMapper: (TempReadings temp, _) => temp.temp,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      color: Colors.red,
                      opacity: 1,
                    )
                  ],
                  primaryXAxis:
                      NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                );
              }
            }),
      ),
    );
  }
}

class TempReadings {
  TempReadings(this.temp, this.time);
  final double temp, time;
}
