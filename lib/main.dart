import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quizapp/api/alert_dialogue.dart';
import 'package:quizapp/api/api_call.dart';

void main() {
  runApp(const MaterialApp(
    home: MainUI(),
  ));
}

class MainUI extends StatefulWidget {
  const MainUI({Key? key}) : super(key: key);

  @override
  State<MainUI> createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  int score = 0;
  QuizeApi quizeApi = QuizeApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapShot) {
            switch (snapShot.connectionState) {
              case ConnectionState.done:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        quizeApi.question.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: FlatButton(
                                color: Colors.blue,
                                onPressed: () async {
                                  if (quizeApi.options![index] ==
                                      quizeApi.anwser) {
                                    dialog(
                                        context: context,
                                        result: 'Correct !!!',
                                        state: () {
                                          Navigator.pop(context);

                                          setState(() {
                                            score++;
                                          });
                                        });
                                  } else {
                                    dialog(
                                        context: context,
                                        result:
                                            'You choose wrong answer !!! \n Correct : ${quizeApi.anwser}',
                                        state: () {
                                          Navigator.pop(context);
                                          setState(() {});
                                        });
                                  }
                                },
                                child: Text(quizeApi.options![index]),
                              ),
                            );
                          }),
                          itemCount: quizeApi.options!.length,
                          scrollDirection: Axis.vertical,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        score.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: FlatButton(
                        color: Colors.blue,
                        onPressed: () async {
                          setState(() {
                            score = 0;
                          });
                        },
                        child: const Text('Reset score'),
                      ),
                    )
                  ],
                );

              case ConnectionState.waiting:
                return const Center(
                  child: Text(
                    'Loading question',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              default:
                return const Center(
                  child: Text(
                    'An Error occure in gettin the question',
                    style: TextStyle(color: Colors.white),
                  ),
                );
            }
          },
          future: quizeApi.apiCall(),
        ),
      ),
    );
  }
}
