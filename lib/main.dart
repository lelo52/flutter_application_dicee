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
  Dice dice = Dice(size: 5);
  late Timer timer;
  dynamic resultNum = 0;
  String resultView = '';
  bool isStart = false;

  void start() {
    dice.init();
    resultNum = '0';
    resultView = '';
    if (!isStart & dice.dice.isNotEmpty) {
      timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        dice.shake();
        setState(() {
          resultNum = dice.dice[0];
          isStart = true;
        });
      });
    }
  }

  void pickUp() {
    if (dice.dice.isNotEmpty && isStart) {
      setState(() {
        //resultView = resultView + ' ' + dice.pick().toString();
        resultView = '$resultView ${dice.pick()}';
      });
      if (dice.dice.isEmpty) {
        //클래스이름.안에 변수 이름
        timer.cancel();
        setState(() {
          isStart = false;
          resultNum = '끝';
        });
      }
    }
  }

  //초기화
  //결과 지우고 배열을 원래 크기로 만들기
  void initializing() {
    setState(() {
      resultNum = '0';
      resultView = '';
      dice.init();
      if (isStart) {
        timer.cancel();
      }
      isStart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    '$resultView',
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
                      onPressed: pickUp,
                      icon: Icon(
                        Icons.check_box,
                      ),
                    ),
                    IconButton(
                      iconSize: 100,
                      onPressed: initializing,
                      icon: Icon(
                        Icons.running_with_errors_outlined,
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
