import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lab_5/button_model.dart';
import 'package:lab_5/xylophone_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final  AudioPlayer _player;
  final buttons = allButtons;

  @override
  void initState() {
    _player = AudioPlayer();
    super.initState();
  }
  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: buttons.map((button) => XylophoneButton(
            color: button.color,
            onPressed: () async {
             await _player.play(AssetSource('${button.audioName}.wav'));
            },
        ),
        )
            .toList()),
    );

  }
}
