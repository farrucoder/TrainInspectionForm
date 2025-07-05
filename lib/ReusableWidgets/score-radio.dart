import 'package:flutter/material.dart';

class ScoreRadioSelector extends StatefulWidget {
  @override
  _ScoreRadioSelectorState createState() => _ScoreRadioSelectorState();
}

class _ScoreRadioSelectorState extends State<ScoreRadioSelector> {
  int? selectedScore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Score Selector')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Select Score (1 - 10):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedScore != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('You selected score: $selectedScore'),
                  ));
                }
              },
              child: Text('Submit Score'),
            ),
          ],
        ),
      ),
    );
  }
}
