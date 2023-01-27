import 'package:flutter/material.dart';

Widget groupNames(String firstName, String secondName, String thirdName,
    BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    if (1 == 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            backgroundColor: const Color(0xffdbe4ee),
                            title: Text(
                              firstName,
                              style: const TextStyle(color: Color(0xff054a91)),
                            ),
                            children: const <Widget>[
                              SimpleDialogOption(
                                child: Text(
                                    'Email: mohamed.2520082@stemelsadat.moe.edu.eg'),
                              ),
                              SimpleDialogOption(
                                child: Text('Phone: 01229372076'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    firstName,
                    style: const TextStyle(
                      color: Color(0xff3e7cb1),
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                TextButton(
                  onPressed: () async {
                    if (1 == 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            backgroundColor: const Color(0xffdbe4ee),
                            title: Text(
                              secondName,
                              style: const TextStyle(color: Color(0xff054a91)),
                            ),
                            children: const <Widget>[
                              SimpleDialogOption(
                                child: Text(
                                    'Email: ahmed.2520043@stemelsadat.moe.edu.eg'),
                              ),
                              SimpleDialogOption(
                                child: Text('Phone: 01094384932'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    secondName,
                    style: const TextStyle(
                      color: Color(0xff3e7cb1),
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                TextButton(
                  onPressed: () async {
                    if (1 == 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            backgroundColor: const Color(0xffdbe4ee),
                            title: Text(
                              thirdName,
                              style: const TextStyle(color: Color(0xff054a91)),
                            ),
                            children: const <Widget>[
                              SimpleDialogOption(
                                child: Text(
                                    'Email: ahmed.2520002@stemelsadat.moe.edu.eg'),
                              ),
                              SimpleDialogOption(
                                child: Text('Phone: 01007973444'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    thirdName,
                    style: const TextStyle(
                      color: Color(0xff3e7cb1),
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}
