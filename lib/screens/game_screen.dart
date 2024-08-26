import 'package:flutter/material.dart';
import 'package:zolup/screens/calcgame_screen.dart';
import 'package:zolup/screens/cardgame_screen.dart';
import 'package:zolup/screens/home_screen.dart';
import 'package:zolup/screens/root_screen.dart';
import 'package:zolup/screens/ordergame_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("게임"),
        backgroundColor: Color(0xFFEAD4AD),
        leading: IconButton(
          icon: Icon(size: 46, Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RootScreen(),
              ),
            );
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          // Center(
          //   child: Text(
          //     '게임을 해봐요',
          //     style: TextStyle(fontSize: 30),
          //   ),
          // ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CalcGame();
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              margin: EdgeInsets.only(bottom: 11, right: 10, left: 10),
              height: 164,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "계산 게임",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.calculate_outlined,
                      size: 67.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Ordergame();
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              margin: EdgeInsets.only(bottom: 11, right: 10, left: 10),
              height: 164,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "순서 게임",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.onetwothree_outlined,
                      size: 67.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CardGame();
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              margin: EdgeInsets.only(bottom: 11, right: 10, left: 10),
              height: 164,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "기억력 게임",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.dashboard_outlined,
                      size: 67.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
