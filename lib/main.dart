import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_dice/dice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Dice dice = Dice(size: 100);

  @override
  Widget build(BuildContext context) {
    late Timer timer;
    int resultNum = 0;

    void start() {
      timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        dice.shake();
        setState(() {
          resultNum = dice.dice[0];
        });
      });
    }

    return MaterialApp(
      home: Scaffold(
        body: Column(children: [
          Flexible(
              flex: 3,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    '$resultNum',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              )),
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.amber,
                child: Center(
                  child: Text(
                    "0000000 :",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                  ),
                ),
              )),
          Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 100,
                      onPressed: start,
                      icon: Icon(Icons.play_circle_rounded),
                    ),
                    IconButton(
                      iconSize: 100,
                      onPressed: null,
                      icon: Icon(
                        Icons.check_box,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
