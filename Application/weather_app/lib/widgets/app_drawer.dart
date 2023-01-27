import 'package:cap_app/Screens/about_us.dart';
import 'package:flutter/material.dart';

import '../Screens/Graphs/hum_graph.dart';
import '../Screens/Graphs/temp_graph.dart';
import '../Screens/chart_table.dart';

Widget capDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: const Color(0xFFDBE4EE),
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(color: Color(0xFF81A4CD)),
          child: Text(
            'Concrete IoT App',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        ListTile(
          textColor: Colors.black,
          iconColor: Colors.black,
          leading: const Icon(
            Icons.table_chart,
          ),
          title: const Text('Table'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const ChartTable();
            }));
          },
        ),
        ListTile(
          textColor: Colors.red,
          iconColor: Colors.red,
          leading: const Icon(
            Icons.auto_graph,
          ),
          title: const Text('Temperature Graph'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const TempGraph();
            }));
          },
        ),
        ListTile(
          textColor: const Color(0xFF054A91),
          iconColor: const Color(0xFF054A91),
          leading: const Icon(
            Icons.auto_graph,
          ),
          title: const Text('Humidity Graph'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const HumGraph();
            }));
          },
        ),
        ListTile(
          textColor: Colors.black,
          iconColor: Colors.black,
          leading: const Icon(
            Icons.contact_page,
          ),
          title: const Text('About Us'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const AboutUs();
            }));
          },
        ),
      ],
    ),
  );
}
