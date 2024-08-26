import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardpath = "assets/images/hidden.png";
  // List<String> cards_list = [
  //   "assets/images/circle.png",
  //   "assets/images/triangle.png",
  //   "assets/images/circle.png",
  //   "assets/images/heart.png",
  //   "assets/images/star.png",
  //   "assets/images/triangle.png",
  //   "assets/images/star.png",
  //   "assets/images/heart.png",
  // ];
  List<String> cards_list = [
    "assets/images/image1.png",
    "assets/images/image1.png",
    "assets/images/image2.png",
    "assets/images/image2.png",
    "assets/images/image3.png",
    "assets/images/image3.png",
    "assets/images/image4.png",
    "assets/images/image4.png",
    "assets/images/image5.png",
    "assets/images/image5.png",
    "assets/images/image6.png",
    "assets/images/image6.png",
    "assets/images/image7.png",
    "assets/images/image7.png",
    "assets/images/image8.png",
    "assets/images/image8.png",
  ];
  final int cardCount = 16;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
