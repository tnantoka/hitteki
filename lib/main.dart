import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'main_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final game = MainGame();

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: game);
  }
}
