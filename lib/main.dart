import 'dart:math';
import 'package:flutter/material.dart';

void main(){
  runApp(
     MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text("Dicee"),
          backgroundColor: Colors.red,
        ),
        body: dice(),
      )
    )
  );
}
class dice extends StatefulWidget {
  const dice({super.key});

  @override
  State<dice> createState() => _diceState();
}

class _diceState extends State<dice> {
int left_dice = 1;
int right_dice= 1;

void ChangeDiceFace(){
  setState(() {
    left_dice = Random().nextInt(6) +1;
    right_dice = Random().nextInt(6) +1;
  });
}
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
              child: TextButton(
                  onPressed: () {
                    ChangeDiceFace();
                  },
                  child: Image.asset("images/dice$left_dice.png"),
              ),
          ),
          Expanded(child: TextButton(
            onPressed: () {
            ChangeDiceFace();
          },
              child: Image.asset("images/dice$right_dice.png"),
          ),
          ),
        ],
      ),

    );

  }
}
