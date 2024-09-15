import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: const Center( // Dùng Center để đặt tiêu đề ở giữa
            child: Text(
              "Ask Me Anything",
              style: TextStyle(
                color: Colors.white, // Chỉnh màu chữ thành trắng
              ),
            ),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: ball(),
      ),
    ),
  );
}

class ball extends StatefulWidget{
  const ball({super.key});
  
  @override
  State<ball> createState() => _ballState();
  }

  class _ballState extends State<ball>{
   int a = 1;
   void chageBallFace(){
     setState(() {
       a = Random().nextInt(5)+1;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:  Row(
        children: [
          Expanded(
              child: TextButton(
                  onPressed: () {
                  chageBallFace();
                  },
                  child: Image.asset("images/ball$a.png"),
               ),
            ),

        ],
      ),
    );
  }
  }

