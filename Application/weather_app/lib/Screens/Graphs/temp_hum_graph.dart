import 'dart:convert';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class TempHumGraph extends StatefulWidget {
  const TempHumGraph({super.key});

  @override
  State<TempHumGraph> createState() => _TempHumGraphState();
}

class _TempHumGraphState extends State<TempHumGraph> {
  List<Readings> _chartData = [];
  late TooltipBehavior _tooltipBehavior;
  bool isLoaded = false;

  Future<String> getChartData() async {
    if (!isLoaded) {
      await http.get(Uri.parse("$serverIP/Readings")).then((results) {
        var data = jsonDecode(results.body);
        for (var u in data) {
          _chartData
              .add(Readings(double.parse(u["Temp"].toString()), double.parse(u["Hum"].toString())));
        }
        return "";
      });
    } else {
      return "";
    }
    return "";
  }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Color(0xFF81A4CD),
          centerTitle: true,
          title: Text(
            "Temp_Hum readings",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder(
            future: getChartData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SfCartesianChart(
                  backgroundColor: Color(0xFFFFFFFF),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: _tooltipBehavior,
                  series: <LineSeries>[
                    LineSeries<Readings, double>(
                      name: 'Temp_Hum',
                      dataSource: _chartData,
                      xValueMapper: (Readings hum, _) => hum.hum,
                      yValueMapper: (Readings temp, _) => temp.temp,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      color: Color(0xFFF28017),
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

class Readings {
  Readings(this.temp, this.hum);
  final double temp, hum;
}
