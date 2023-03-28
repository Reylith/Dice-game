import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final random = Random.secure();

  final dicelist = [
    'assets/images/d1.png',
    'assets/images/d2.png',
    'assets/images/d3.png',
    'assets/images/d4.png',
    'assets/images/d5.png',
    'assets/images/d6.png',
  ];

  int index1 = 0;
  int index2 = 0;
  int diceSum = 0;
  int point = 0;
  String status = '';
  String buttonText = 'Roll Dices';
  bool gameOver = false;
  bool hasTarget = false;

  String instruction = '''The game is played with two six-sided dice.
To start the game, the player rolls the dice.
If the player rolls a 7 or an 11 on the first roll, they win.
If the player rolls a 2, 3, or 12 on the first roll, they lose.
If the player rolls any other number on the first roll, that number becomes their "target" point.
The player must then keep rolling the dice until they either roll their target point again and win, or they roll a 7 and lose.
If the player wins, they can choose to continue playing and rolling the dice to try to win again.
If the player loses, they can choose to start over and roll the dice again to try to win.''';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text("Dice Game")),
            backgroundColor: Colors.red),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(dicelist[index1], width: 150, height: 150,),
                    const SizedBox(width: 20,),
                    Image.asset(dicelist[index2], width: 150, height: 150,),
                  ],
                ),
              ),
              Text("Dice Score: $diceSum", style: const TextStyle(fontSize: 22)),
              Text(status, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              if (point > 0 && !gameOver)
                Text("Your Target Point is $point",
                  style: const TextStyle(fontSize: 22),),
              ElevatedButton(
                  onPressed: () {
                    if (gameOver) {
                      resetGame();
                    } else {
                      rollTheDices();
                    }
                  }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(gameOver ? 'Reset' : (hasTarget ? 'Roll Again' : 'Roll Dices'),style: TextStyle(fontSize: 14),)
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Instructions", style: const TextStyle(fontSize: 22)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(instruction, style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void rollTheDices() {
    setState(() {
      index1 = random.nextInt(6);
      index2 = random.nextInt(6);
      diceSum = index1 + index2 + 2;
      checkStatus();
    });
  }

  void checkStatus() {
    if (hasTarget) {
      if (point == diceSum) {
        status = "Congrats You Win";
        gameOver = true;
        print('win in point mode');

      } else if (diceSum == 7) {
        status = "You Lose";
        gameOver = true;
        print('lose in point mode');

      } else {
        status = '';
        buttonText = "Roll Dices";
      }
    } else {
      if (diceSum == 7 || diceSum == 11) {
        status = "Congrats You Win";
        buttonText = "Reset";
        print('win');
        gameOver = true;
      } else if (diceSum == 2 || diceSum == 3 || diceSum == 12) {
        status = "You Lose";
        buttonText = "Reset";
        print('lose');
        gameOver = true;
      } else {
        if (point == 0) {
          point = diceSum;
          hasTarget = true;
        }
        buttonText = "Roll Dices";
      }
    }
  }

  void resetGame() {
    setState(() {
      print('game reset');
      index1 = 0;
      index2 = 0;
      diceSum = 0;
      status = '';
      point = 0;
      hasTarget = false;
      gameOver = false;
    });
  }
}
