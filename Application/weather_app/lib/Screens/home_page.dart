import 'dart:async';
import 'dart:convert';
import 'package:cap_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class GetData {
  final double temp, hum;

  GetData({
    required this.temp,
    required this.hum,
  });
}

class _HomePageState extends State<HomePage> {
  late Timer timer;
  int counter = 0;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 2), (Timer t) => getRequest());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<GetData> getRequest() async {
    setState(() {
      counter++;
    });
    final response = await http.get(Uri.parse("$serverIP/Readings"));

    var responseData = json.decode(response.body);
    List<GetData> readings = [];
    for (var u in responseData) {
      GetData singeData = GetData(
        temp: double.parse(u["Temp"].toString()),
        hum: double.parse(u["Hum"].toString()),
      );

      readings.add(singeData);
    }
    GetData tempNidleValue = readings.last;
    return tempNidleValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBE4EE),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: const Color(0xFF81A4CD),
        elevation: 0.0,
        title: const Text(
          "Concrete IoT App",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: capDrawer(context),
      body: FutureBuilder(
        future: getRequest(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                const Center(
                  child: Text(
                    "Weather Information",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Color(0xdd212121),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 20.0,
                ),
                SfRadialGauge(
                  animationDuration: 3000,
                  enableLoadingAnimation: true,
                  title: const GaugeTitle(
                    text: 'Temperature',
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  axes: <RadialAxis>[
                    RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 100,
                        sizeUnit: GaugeSizeUnit.factor,
                        startWidth: 0.06,
                        endWidth: 0.06,
                        gradient: const SweepGradient(
                          colors: <Color>[
                            Colors.yellow,
                            Colors.orange,
                            Colors.red,
                          ],
                          stops: <double>[0.0, 0.5, 1],
                        ),
                      ),
                    ], pointers: <GaugePointer>[
                      NeedlePointer(
                        value: snapshot.data!.temp,
                        enableAnimation: true,
                        animationType: AnimationType.ease,
                      ),
                    ], annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Text(snapshot.data!.temp.toString(),
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          angle: 90,
                          positionFactor: 0.5)
                    ]),
                  ],
                ),
                SfRadialGauge(
                  animationDuration: 3000,
                  enableLoadingAnimation: true,
                  title: const GaugeTitle(
                    text: 'Humidity',
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF054A91),
                    ),
                  ),
                  axes: <RadialAxis>[
                    RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 100,
                        sizeUnit: GaugeSizeUnit.factor,
                        startWidth: 0.06,
                        endWidth: 0.06,
                        gradient: const SweepGradient(
                          colors: <Color>[
                            Colors.cyan,
                            Colors.blue,
                            Color(0xFF054A91),
                          ],
                          stops: <double>[0.0, 0.5, 1],
                        ),
                      ),
                    ], pointers: <GaugePointer>[
                      NeedlePointer(
                        value: snapshot.data!.hum,
                        enableAnimation: true,
                        animationType: AnimationType.ease,
                      ),
                    ], annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Text(snapshot.data!.hum.toString(),
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          angle: 90,
                          positionFactor: 0.5)
                    ]),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
