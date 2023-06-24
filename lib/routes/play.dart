import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../main_game.dart';
import '../components/components.dart';

class Play extends PositionComponent
    with HasGameRef<MainGame>, TapCallbacks, DragCallbacks {
  Play() : super(size: MainGame.contentSize);

  late final Ball _ball;

  Vector2? _dragStartPosition;
  Vector2? _dragEndPosition;

  @override
  Future onLoad() async {
    super.onLoad();

    await _addBall();
    await _addWalls();
    await _addTargets();
  }

  @override
  void onMount() {
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_dragStartPosition != null && _dragEndPosition != null) {
      _ball.charge(_dragEndPosition! - _dragStartPosition!);
    } else {
      _ball.charge(null);
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);

    if (componentsAtPoint(event.localPosition).contains(_ball)) {
      _dragStartPosition = event.localPosition;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    if (containsLocalPoint(event.localPosition)) {
      _dragEndPosition = event.localPosition;
    } else {
      _dragStartPosition = null;
      _dragEndPosition = null;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    if (_dragStartPosition != null && _dragEndPosition != null) {
      if (!componentsAtPoint(_dragEndPosition!).contains(_ball)) {
        final diff = (_dragEndPosition! - _dragStartPosition!) * 5;
        _ball.hit(-diff.x, -diff.y);
      }
    }

    _dragStartPosition = null;
    _dragEndPosition = null;
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);

    _dragStartPosition = null;
    _dragEndPosition = null;
  }

  Future _addBall() async {
    await add(
      _ball = Ball(
        radius: 30,
        position: Vector2(
          game.contentArea.size.x * 0.5 - 30,
          game.contentArea.size.y * 0.7 - 30,
        ),
      ),
    );
  }

  Future _addWalls() async {
    await add(
      Wall(
        position: Vector2(0, 0),
        size: Vector2(game.contentArea.size.x, 10),
        bounceDirection: WallBounceDirection.vertical,
      ),
    );
    await add(
      Wall(
        position: Vector2(0, game.contentArea.size.y - 10),
        size: Vector2(game.contentArea.size.x, 10),
        bounceDirection: WallBounceDirection.vertical,
      ),
    );
    await add(
      Wall(
        position: Vector2(0, 0),
        size: Vector2(10, game.contentArea.size.y),
        bounceDirection: WallBounceDirection.horizontal,
      ),
    );
    await add(
      Wall(
        position: Vector2(game.contentArea.size.x, 0),
        size: Vector2(10, game.contentArea.size.y),
        bounceDirection: WallBounceDirection.horizontal,
      ),
    );
  }

  Future _addTargets() async {
    final length = game.contentArea.size.x / 11;

    for (final i in [0, 8]) {
      await add(
        Target(
          position: Vector2(
            length * i,
            0,
          ),
          size: Vector2(length * 3, length),
          score: 1,
        ),
      );
    }

    for (final i in [3, 6]) {
      await add(
        Target(
          position: Vector2(
            length * i,
            0,
          ),
          size: Vector2(length * 2, length),
          score: 2,
        ),
      );
    }

    await add(
      Target(
        position: Vector2(
          length * 5,
          0,
        ),
        size: Vector2(length, length),
        score: 3,
      ),
    );
  }
}
