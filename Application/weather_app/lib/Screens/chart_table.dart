import 'dart:convert';
import '../main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Readings {
  Readings(this.temperature, this.humidity);
  final String temperature, humidity;
}

class ChartTable extends StatefulWidget {
  const ChartTable({super.key});

  @override
  State<ChartTable> createState() => _ChartTableState();
}

List<DataRow> dataRowsFormatted = [];

class _ChartTableState extends State<ChartTable> {
  Future getData() async {
    dataRowsFormatted.clear();
    var results = await http.get(Uri.parse("$serverIP/Readings"));
    if (results.statusCode == 200) {
      var data = jsonDecode(results.body);
      List<Readings> datas = [];
      for (var u in data) {
        Readings data = Readings(u["Temp"].toString(), u["Hum"].toString());
        datas.add(data);
      }
      for (var u in datas) {
        List<DataCell> currentCells = [];
        currentCells.add(
          DataCell(
            Text(
              u.temperature.toString(),
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        );
        currentCells.add(
          DataCell(
            Text(
              u.humidity.toString(),
              style: const TextStyle(
                color: Color(0xFF054A91),
              ),
            ),
          ),
        );
        dataRowsFormatted.add(
          DataRow(cells: currentCells),
        );
      }
      return dataRowsFormatted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: const Color(0xFF81A4CD),
        centerTitle: true,
        title: const Text(
          "chart table data",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              children: [
                Container(
                  color: const Color(0xFFDBE4EE),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Temperature',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Humidity',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF054A91),
                                ),
                              ),
                            )
                          ],
                          rows: dataRowsFormatted,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
