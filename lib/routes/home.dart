import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../main_game.dart';

class Home extends Component with HasGameRef<MainGame> {
  @override
  Future onLoad() async {
    super.onLoad();

    await add(
      TextComponent(
        text: 'Hitteki',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        position: Vector2(
          game.contentArea.size.x * 0.5,
          game.contentArea.size.y * 0.4,
        ),
        anchor: Anchor.center,
      ),
    );

    await add(
      ButtonComponent(
        onPressed: () => game.router.pushReplacementNamed('play'),
        button: TextComponent(
          text: 'Tap to Play',
          textRenderer: TextPaint(
            style: const TextStyle(
              fontFamily: 'PressStart2P',
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        position: Vector2(
          game.contentArea.size.x * 0.5,
          game.contentArea.size.y * 0.6,
        ),
        anchor: Anchor.center,
      ),
    );
  }
}
