import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:zolup/tools/utils.dart';

class CalcGame extends StatefulWidget {
  const CalcGame({Key? key}) : super(key: key);

  @override
  State<CalcGame> createState() => _CardGameState();
}

class _CardGameState extends State<CalcGame> {
  late int _timer;
  late int _timedelta;
  late int _score;
  late int targetNumber1;
  late int targetNumber2;
  late List<int> answerList;
  bool isClickable = true;
  // List<int> numbers = [13, 15, 12, 14];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    answerList = [];
    _timer = 60;
    _score = 0;
    _timedelta = 0;
    generateNumbers();
    runTimer();
  }

  void generateNumbers() {
    targetNumber1 = Random().nextInt(9) + 1;
    targetNumber2 = Random().nextInt(9) + 1;
    answerList.clear();
    answerList.add(targetNumber1 + targetNumber2 + 1);
    answerList.add(targetNumber1 + targetNumber2 - 1);
    answerList.add(targetNumber1 + targetNumber2 + Random().nextInt(3) + 1);
    answerList.add(targetNumber2 + targetNumber1);
    answerList.shuffle();
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
      _timer = 60;
      runTimer();
    });
  }

  void checkAnswer(int selectedNumber) {
    if (!isClickable) return;
    int sum = targetNumber1 + targetNumber2;
    if (selectedNumber == sum) {
      setState(() {
        _score++;
      });
      generateNumbers();
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
            "계산 게임",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 24)),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
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
                  mainAxisSize: MainAxisSize.min,
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
              ],
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          Center(
            child: Text(
              "$targetNumber1 + $targetNumber2 = ?",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: double.infinity,
            child: GridView.count(
              childAspectRatio: 1.1,
              padding: EdgeInsets.all(10),
              crossAxisCount: 2,
              children: [
                InkWell(
                  onTap: () {
                    checkAnswer(answerList[0]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      answerList[0].toString(),
                      style: TextStyle(fontSize: 30),
                    )),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(answerList[1]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      answerList[1].toString(),
                      style: TextStyle(fontSize: 30),
                    )),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(answerList[2]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      answerList[2].toString(),
                      style: TextStyle(fontSize: 30),
                    )),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    checkAnswer(answerList[3]);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      answerList[3].toString(),
                      style: TextStyle(fontSize: 30),
                    )),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
