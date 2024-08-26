import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  Future setLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // decoration: BoxDecoration(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width * 0.95,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    "ID:",
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey),
                    width: MediaQuery.of(context).size.width * 0.74,
                    height: 30,
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "PW:",
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey),
                    width: MediaQuery.of(context).size.width * 0.69,
                    height: 30,
                  )
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    textStyle: TextStyle(fontWeight: FontWeight.w900)),
                onPressed: () {
                  setLogin().then((_) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  });
                },
                child: Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
