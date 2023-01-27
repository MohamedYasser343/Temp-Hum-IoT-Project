import 'package:flutter/material.dart';

TextStyle tempFont = const TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 20.0,
  color: Colors.red
);

TextStyle humFont = const TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 20.0,
  color: Color(0xFF054A91)
);

TextStyle tempinfoFont = const TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 20.0,
  color: Colors.red
);

TextStyle huminfoFont = const TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 20.0,
  color: Color(0xFF054A91)
);

Widget additionalInformation(
    String temp, String humidity) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Temperature",
                  style: tempFont,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  temp,
                  style: tempinfoFont,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Humidity",
                  style: humFont,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  humidity,
                  style: huminfoFont,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
