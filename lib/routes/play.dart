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
}
