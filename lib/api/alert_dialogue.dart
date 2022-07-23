import 'package:flutter/material.dart';

// alert dialogue for the result of a round in game showing user win or loss a round
void dialog({
  required BuildContext context,
  required String result,
  required Function() state,
}) async {
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Result'),
          content: Text(result),
          actions: [
            FlatButton(
              onPressed: state,
              child: const Text('Next Quiz'),
            )
          ],
        );
      });
}
