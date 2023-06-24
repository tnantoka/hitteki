import 'dart:async';

import 'package:flame/components.dart';

import '../main_game.dart';
import '../components/components.dart';

class Play extends Component with HasGameRef<MainGame> {
  late final Ball _ball;

  @override
  Future onLoad() async {
    super.onLoad();

    await add(
      _ball = Ball(
        position: Vector2(
          game.contentArea.size.x * 0.5 - 30,
          game.contentArea.size.y * 0.5 - 30,
        ),
      ),
    );

    await add(
      Wall(
        position: Vector2(0, 0),
        size: Vector2(game.contentArea.size.x, 10),
      ),
    );
    await add(
      Wall(
        position: Vector2(0, game.contentArea.size.y),
        size: Vector2(game.contentArea.size.x, 10),
      ),
    );
    await add(
      Wall(
        position: Vector2(0, 0),
        size: Vector2(10, game.contentArea.size.y),
      ),
    );
    await add(
      Wall(
        position: Vector2(game.contentArea.size.x, 0),
        size: Vector2(10, game.contentArea.size.y),
      ),
    );
  }

  @override
  void onMount() {
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
