import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

//chatgpt api
const apiKey = '__________';
const apiUrl = 'https://api.openai.com/v1/chat/completions';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controller = TextEditingController();
  String chatbotAnswer = '';
  String question = '';
  FlutterTts tts = FlutterTts();
  final stt.SpeechToText speech = stt.SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tts.setLanguage("ko-KR");
    tts.setVoice({"name": "ko-kr-x-ism-local", "locale": "ko-KR"});
    tts.setPitch(1.0);
    tts.setSpeechRate(0.5);
    tts.setVolume(0.8);
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await speech.initialize();
    setState(() {});
  }

  //void
  void _onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  void _startListening() async {
    await speech.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await speech.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.

  void generateText(String prompt) async {
    // tts.speak(speech.lastRecognizedWords);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        'model': "gpt-3.5-turbo",
        'messages': [
          {
            "role": "assistant",
            "content": "노인들과 대화하는 상담사이고, 친숙해 보일 수 있게 반말로 해줘."
          },
          {"role": "user", "content": prompt}
        ],
        'max_tokens': 500
        // 'prompt': prompt + '노인들과 대화하듯이 대답해줘',
        // 'max_tokens': 50,
        // 'temperature': 0,
        // 'top_p': 1,
        // 'frequency_penalty': 0,
        // 'presence_penalty': 0
      }),
    );

    Map<String, dynamic> newresponse =
        jsonDecode(utf8.decode(response.bodyBytes));
    // return newresponse['choices'][0]['text'];
    setState(() {
      // chatbotAnswer = newresponse['choices'][0]['text'];
      chatbotAnswer = newresponse['choices'][0]['message']['content'];
      tts.speak(chatbotAnswer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // decoration: BoxDecoration(color: Colors.white),
            margin: EdgeInsets.only(top: 50),
            child: Text(
              style: TextStyle(fontSize: 30),
              "",
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(height: 540, 'assets/images/aidot.png'),
              chatbotAnswer.isNotEmpty
                  ? Positioned(
                      top: 100,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        // height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            chatbotAnswer,
                          ),
                        ),
                      ),
                    )
                  : Positioned(
                      top: 150,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        // height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            chatbotAnswer,
                          ),
                        ),
                      ),
                    ),
              // Positioned(
              //   top: 300,
              //   width: MediaQuery.of(context).size.width * 0.7,
              //   child: TextField(
              //     decoration: InputDecoration(
              //         fillColor: Colors.transparent,
              //         filled: true,
              //         labelText: '대화',
              //         labelStyle: (TextStyle(
              //           color: Colors.grey,
              //         )),
              //         border: OutlineInputBorder(
              //             borderSide: BorderSide(
              //               width: 1,
              //               color: Colors.blue,
              //             ),
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(10.0)))),
              //     controller: _controller,
              //     onChanged: (text) {
              //       setState(() {
              //         // chatbotAnswer = text;
              //         question = text;
              //       });
              //     },
              //   ),
              // ),
              Positioned(
                bottom: 100,
                child: Row(
                  children: [
                    IconButton(
                        iconSize: 60,
                        icon: const Icon(Icons.mic),
                        onPressed: () {
                          speech.isNotListening
                              ? _startListening()
                              : _stopListening();
                          // String prompt = question;
                          // generateText(prompt);
                          // chatbotAnswer = _controller.text;
                          // setState(() {});
                        }),
                    SizedBox(
                      width: 30,
                    ),
                    IconButton(
                      iconSize: 60,
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        generateText(_lastWords);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
