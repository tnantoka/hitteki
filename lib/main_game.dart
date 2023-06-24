import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class MainGame extends FlameGame {
  final _contentArea = RectangleComponent(
    size: Vector2(375, 667),
    paint: BasicPalette.black.paint(),
  );

  @override
  Future onLoad() async {
    super.onLoad();

    await add(_contentArea);
  }

  @override
  void onGameResize(Vector2 size) {
    final scale = size.y / _contentArea.size.y;
    _contentArea.scale = Vector2.all(scale);
    _contentArea.position =
        Vector2(size.x * 0.5 - _contentArea.size.x * 0.5 * scale, 0);
    super.onGameResize(size);
  }

  @override
  Color backgroundColor() {
    return Colors.grey.shade800;
  }
}
