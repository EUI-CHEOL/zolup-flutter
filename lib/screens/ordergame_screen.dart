import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:zolup/tools/utils.dart';

class Ordergame extends StatefulWidget {
  const Ordergame({Key? key}) : super(key: key);

  @override
  State<Ordergame> createState() => _OrdergameState();
}

class _OrdergameState extends State<Ordergame> {
  late int _timer;
  late int _score;
  int currentNumber = 1;
  bool isGameOver = false;
  List<int> orderList = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<bool> checkclicked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool isClickable = true;
  late int _timedelta;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = 60;
    _score = 0;
    _timedelta = 0;
    orderList.shuffle();
    runTimer();
  }

  void runTimer() async {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _timer--;
        _timedelta++;
        if (_timer == 40) {
          t.cancel();
          isClickable = false;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('게임 종료'),
              content:
                  Text('$_timedelta초가 지났습니다.\n게임이 종료되었습니다.\nSCORE = $_score'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('게임 화면'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    resetGame();
                  },
                  child: Text('새 게임 시작'),
                ),
              ],
            ),
          );
        }
      });
    });
  }

  void resetGame() {
    setState(() {
      _score = 0;
      isClickable = true;
      currentNumber = 1;
      checkclicked = [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ];
      _timer = 60;
      runTimer();
    });
  }

  void generateOrders() {
    orderList.shuffle();
  }

  void checkAnswer(int selectedNumber) {
    if (!isClickable) return;
    if (selectedNumber == currentNumber) {
      setState(() {
        _score++;
        currentNumber++;
        checkclicked[orderList.indexOf(selectedNumber)] = true;
      });
    }
    if (currentNumber == 10) {
      setState(() {
        generateOrders();
        currentNumber = 1;
        checkclicked = [
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false,
          false
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEAD4AD),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
          ),
          Text(
            "순서 게임",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 24)),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "TIME : ",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      secondsToString(_timer),
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "SCORE : ",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      _score.toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "1부터 9까지 순서대로 누르세요",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.85,
            child: GridView.count(
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              padding: EdgeInsets.all(10),
              crossAxisCount: 3,
              children: [
                InkWell(
                  onTap: () {
                    checkAnswer(orderList[0]);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: checkclicked[0]
                        ? BoxDecoration(color: Colors.transparent)
                        : BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                        orderList[0].toString(),
                        style: TextStyle(
                            fontSize: 70,
                            color: checkclicked[0]
                                ? Colors.transparent
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(orderList[1]);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: checkclicked[1]
                        ? BoxDecoration(color: Colors.transparent)
                        : BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                        orderList[1].toString(),
                        style: TextStyle(
                            fontSize: 70,
                            color: checkclicked[1]
                                ? Colors.transparent
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(orderList[2]);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: checkclicked[2]
                        ? BoxDecoration(color: Colors.transparent)
                        : BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                        orderList[2].toString(),
                        style: TextStyle(
                            fontSize: 70,
                            color: checkclicked[2]
                                ? Colors.transparent
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(orderList[3]);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: checkclicked[3]
                        ? BoxDecoration(color: Colors.transparent)
                        : BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                        orderList[3].toString(),
                        style: TextStyle(
                            fontSize: 70,
                            color: checkclicked[3]
                                ? Colors.transparent
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(orderList[4]);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: checkclicked[4]
                        ? BoxDecoration(color: Colors.transparent)
                        : BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                        orderList[4].toString(),
                        style: TextStyle(
                            fontSize: 70,
                            color: checkclicked[4]
                                ? Colors.transparent
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(orderList[5]);
                  },
                  child: Container(
                    width: 50,
                    decoration: checkclicked[5]
                        ? BoxDecoration(color: Colors.transparent)
                        : BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                        orderList[5].toString(),
                        style: TextStyle(
                            fontSize: 70,
                            color: checkclicked[5]
                                ? Colors.transparent
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(orderList[6]);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: checkclicked[6]
                        ? BoxDecoration(color: Colors.transparent)
                        : BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                        orderList[6].toString(),
                        style: TextStyle(
                            fontSize: 70,
                            color: checkclicked[6]
                                ? Colors.transparent
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(orderList[7]);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: checkclicked[7]
                        ? BoxDecoration(color: Colors.transparent)
                        : BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                        orderList[7].toString(),
                        style: TextStyle(
                            fontSize: 70,
                            color: checkclicked[7]
                                ? Colors.transparent
                                : Colors.black),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(orderList[8]);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: checkclicked[8]
                        ? BoxDecoration(color: Colors.transparent)
                        : BoxDecoration(color: Colors.grey),
                    child: Center(
                      child: Text(
                        orderList[8].toString(),
                        style: TextStyle(
                            fontSize: 70,
                            color: checkclicked[8]
                                ? Colors.transparent
                                : Colors.black),
                      ),
                    ),
                  ),
                ),

                // for (int i = 1; i <= 9; i++)
                // GestureDetector(
                //   onTap: () {
                //     if (i == currentNumber) {
                //       currentNumber++;
                //       _score++;
                //     } else {
                //       isGameOver = true;
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text('게임 오버!'),
                //         ),
                //       );
                //     }
                //   },
                //   child: Container(
                //     width: 50,
                //     height: 50,
                //     decoration: BoxDecoration(color: Colors.grey),
                //     child: Center(
                //       child: Text(
                //         '$i',
                //         style: TextStyle(
                //             fontSize: 70,
                //             color: isGameOver ? Colors.red : Colors.black),
                //       ),
                //     ),
                //   ),
                // ),
                // GridView.builder(
                //   itemCount: orderList.length,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //     crossAxisSpacing: 10,
                //     mainAxisSpacing: 10,
                //   ),
                //   itemBuilder: (BuildContext context, int index) {
                //     return Container(
                //       width: 50,
                //       height: 50,
                //       decoration: BoxDecoration(color: Colors.grey),
                //       child: Center(
                //         child: Text(
                //           orderList[index].toString(),
                //           style: TextStyle(
                //               fontSize: 70,
                //               color: isGameOver ? Colors.red : Colors.black),
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
