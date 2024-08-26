import 'package:flutter/material.dart';
import 'dart:async';
import 'package:zolup/tools/utils.dart';
import 'package:zolup/tools/game_utils.dart';

class CardGame extends StatefulWidget {
  const CardGame({Key? key}) : super(key: key);

  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {
  late int _timer;
  late int _score;
  final Game _game = Game();
  bool hideTest = false;
  late int _timedelta;
  List<bool> isClickable = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  bool isAllClickable = true;
  int compare = 17;
  bool isStart = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = 60;
    _score = 0;
    _timedelta = 0;
    _game.initGame();
    _game.cards_list.shuffle();
    runTimer();
  }

  void runTimer() async {
    isStart = true;
    await Future.delayed(const Duration(seconds: 2), () {});
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      isStart = false;
      setState(() {
        _timer -= 1;
        _timedelta++;
        if (_timer == 40) {
          t.cancel();
          isAllClickable = false;
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

  void generateCards() async {
    _game.initGame();
    _game.cards_list.shuffle();
    isStart = true;
    await Future.delayed(Duration(seconds: 2), () {});
  }

  void resetGame() {
    setState(() {
      _score = 0;
      isClickable = [
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
      ];
      _timer = 60;
      _timedelta = 0;
      isAllClickable = true;
      _game.initGame();
      _game.cards_list.shuffle();
      compare = 17;
      runTimer();
    });
  }

  void resetCard() {
    isClickable = [
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true,
      true
    ];
    compare = 17;
  }

  void checkCard(index) {
    print(_game.matchCheck);
    setState(() {
      _game.gameImg![index] = _game.cards_list[index];
      _game.matchCheck.add({index: _game.cards_list[index]});
      print(_game.matchCheck.first);
    });
    if (_game.matchCheck.length == 2) {
      if (_game.matchCheck[0].values.first ==
          _game.matchCheck[1].values.first) {
        print("true");
        isClickable[_game.matchCheck[0].keys.first] = false;
        isClickable[_game.matchCheck[1].keys.first] = false;
        _score += 1;
        _game.matchCheck.clear();
        if (_score % 8 == 0) {
          resetCard();
          generateCards();
        }
      } else {
        print("false");

        Future.delayed(Duration(milliseconds: 500), () {
          print(_game.gameColors);
          setState(() {
            _game.gameImg![_game.matchCheck[0].keys.first] =
                _game.hiddenCardpath;
            _game.gameImg![_game.matchCheck[1].keys.first] =
                _game.hiddenCardpath;
            _game.matchCheck.clear();
          });
        });
      }
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
            "기억력 게임",
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
          SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              itemCount: _game.gameImg!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              padding: EdgeInsets.all(16.0),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (compare != index) {
                      compare = index;
                      if (isClickable[index] == true &&
                          isAllClickable == true) {
                        checkCard(index);
                      }
                    }
                  },
                  child: Container(
                    // padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        scale: 0.5,
                        image: isStart
                            ? AssetImage(_game.cards_list[index])
                            : AssetImage(_game.gameImg![index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
