import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' hide Route;

import 'routes/routes.dart';

class MainGame extends FlameGame with HasCollisionDetection {
  static final contentSize = Vector2(375, 667);

  var score = 0;

  late final RouterComponent router;

  final contentArea = RectangleComponent(
    size: MainGame.contentSize,
    paint: BasicPalette.black.paint(),
  );

  @override
  Future onLoad() async {
    super.onLoad();

    debugMode = true;

    await add(contentArea);

    router = RouterComponent(
      routes: {
        'home': Route(Home.new),
        'play': Route(Play.new),
        'result': Route(Result.new),
      },
      initialRoute: 'home',
    );
    await contentArea.add(router);
  }

  @override
  void onGameResize(Vector2 size) {
    final scale = size.y / contentArea.size.y;
    contentArea.scale = Vector2.all(scale);
    contentArea.position =
        Vector2(size.x * 0.5 - contentArea.size.x * 0.5 * scale, 0);
    super.onGameResize(size);
  }

  @override
  Color backgroundColor() {
    return Colors.grey.shade800;
  }
}
