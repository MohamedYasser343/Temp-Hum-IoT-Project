import 'package:cap_app/widgets/group_names.dart';
import 'package:cap_app/widgets/group_number.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: const Color(0xFF81A4CD),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          groupNumber(Icons.contacts, '25321'),
          const SizedBox(
            height: 40.0,
          ),
          const Text(
            'Group Members',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          const SizedBox(
            height: 20.0,
          ),
          groupNames("Mohamed Yasser", "Ahmed Al-Kadem", "Ahmed Saeed", context)
        ],
      ),
    );
  }
}
