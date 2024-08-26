import 'package:flutter/material.dart';
import 'package:zolup/screens/root_screen.dart';
import 'package:zolup/tools/my_videoplayer.dart';

class ExerScreen extends StatelessWidget {
  const ExerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("운동"),
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
        padding: const EdgeInsets.all(10),
        children: [
          // const Center(
          //   child: Text(
          //     "~운동을 해봐요~",
          //     style: TextStyle(fontSize: 30),
          //   ),
          // ),
          InkWell(
            //뇌신경체조
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Center(child: Text('동영상재생'))));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoPlayerExample(path: 'assets/videos/video1.mp4'),
                ),
              );
            },
            child: Container(
              height: 164,
              padding: const EdgeInsets.only(left: 30),
              margin: EdgeInsets.only(bottom: 11),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '뇌신경 체조',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Center(child: Text('동영상재생'))));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoPlayerExample(path: 'assets/videos/butterfly.mp4'),
                ),
              );
            },
            child: Container(
              height: 164,
              padding: EdgeInsets.only(left: 30),
              margin: EdgeInsets.only(bottom: 11),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '치매예방 체조',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Center(child: Text('동영상재생'))));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoPlayerExample(path: 'assets/videos/butterfly.mp4'),
                ),
              );
            },
            child: Container(
              height: 164,
              padding: EdgeInsets.only(left: 30),
              margin: EdgeInsets.only(bottom: 11),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '스트레칭',
                    style: TextStyle(fontSize: 40),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Center(child: Text('동영상재생'))));
            },
            child: Container(
              height: 164,
              padding: EdgeInsets.only(left: 30),
              margin: EdgeInsets.only(bottom: 11),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '????',
                    style: TextStyle(fontSize: 40),
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
