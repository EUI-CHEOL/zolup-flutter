import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:zolup/screens/exercise_screen.dart';
import 'package:zolup/screens/game_screen.dart';
import 'package:zolup/screens/my_screen.dart';
import 'package:zolup/screens/splash_screen.dart';

import 'home_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller!.addListener(tabListener);
  }

  tabListener() {
    setState(() {});
  }

  @override
  dispose() {
    controller!.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFEAD4AD),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_outlined),
      //     onPressed: () {},
      //   ),
      // ),
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        controller: controller,
        children: renderChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(),
      ExerScreen(),
      GameScreen(),
      MyScreen(),
    ];
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      iconSize: 40,
      showSelectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.accessibility_outlined,
            ),
            label: '운동'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calculate_outlined,
          ),
          label: '게임',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.contact_page_outlined,
          ),
          label: '나의 페이지',
        ),
      ],
    );
  }
}
