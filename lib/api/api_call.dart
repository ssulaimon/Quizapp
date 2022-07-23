import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:http/http.dart';

class QuizeApi {
  String? question;
  String? anwser;
  List? options;
  Future<Map?> apiCall() async {
    try {
      // Get quiz question from the api
      var apiLink = Uri.parse(
        'https://opentdb.com/api.php?amount=1&type=multiple',
      );
      Response response = await get(apiLink);

      if (response.statusCode == 200) {
        Map map = await jsonDecode(response.body);

        Map list = await map['results'][0];
        //Set the question text gotten from the api call
        question = await list['question'];
        // Get lengt of the list of options and use a random with the lenght range put answer in the range number generated
        options = await list['incorrect_answers'];
        //get the correct answer from the api
        anwser = await list['correct_answer'];
        var random = Random();

        int num = random.nextInt(options!.length);

        options![num] = anwser;

        return list;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> get que async {
    Map? map = await apiCall();
    return map?['question'];
  }

  Future<List?> get option async {
    Map? result = await apiCall();
    List list = result!['incorrect_answers'];

    return list;
  }
}
