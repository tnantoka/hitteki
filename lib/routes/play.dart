import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

import '../main_game.dart';
import '../components/components.dart';

class Play extends PositionComponent
    with HasGameRef<MainGame>, TapCallbacks, DragCallbacks {
  Play() : super(size: MainGame.contentSize);

  late final Ball _ball;
  late final Stage _stage;

  Vector2? _dragStartPosition;
  Vector2? _dragEndPosition;

  @override
  Future onLoad() async {
    super.onLoad();

    await _addStage();
    await _addBall();
    await _addTargets();

    await _stage.add(
      MoveEffect.to(
        Vector2(
          0,
          -_stage.size.y * 0.5,
        ),
        EffectController(duration: 1.0, startDelay: 3.0),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_dragStartPosition != null && _dragEndPosition != null) {
      _ball.charge(_dragEndPosition! - _dragStartPosition!);
    } else {
      _ball.charge(null);
    }

    if (_ball.isMoving) {
      final initialBallY = _stage.size.y * 0.7 - _ball.radius;
      final initialStageY = -_stage.size.y * 0.5;
      var y = initialStageY - (_ball.position.y - initialBallY);
      if (y > 0) {
        y = 0;
      } else if (y < initialStageY) {
        y = initialStageY;
      }
      _stage.position.y = y;
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

  Future _addStage() async {
    await add(
      _stage = Stage(
        size: Vector2(
          game.contentArea.size.x,
          game.contentArea.size.y * 2,
        ),
      ),
    );
  }

  Future _addBall() async {
    await _stage.add(
      _ball = Ball(
        radius: 20,
        position: Vector2(
          _stage.size.x * 0.5 - 20,
          _stage.size.y * 0.8 - 20,
        ),
        onHit: () {
          Future.delayed(
            const Duration(milliseconds: 3000),
            () {
              game.router.pushReplacementNamed('result');
            },
          );
        },
      ),
    );
  }

  Future _addTargets() async {
    final length = _stage.size.x / 11;

    final targets = <Target>[];

    for (var i = 0; i < 5; i++) {
      final size = Vector2.all(length);
      var score = 2;
      var palette = BasicPalette.red;
      if (i > 2) {
        size.x = length * 3;
        score = 1;
        palette = BasicPalette.yellow;
      } else if (i > 0) {
        size.x = length * 2;
        score = 2;
        palette = BasicPalette.orange;
      }

      final target = Target(
        position: Vector2.zero(),
        size: size,
        score: score,
        paint: palette.paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4,
      );

      targets.add(target);
      await _stage.add(target);
    }

    targets.shuffle();

    for (var i = 1; i < targets.length; i++) {
      final target = targets[i];
      final prevTarget = targets[i - 1];
      target.position.x = prevTarget.position.x + prevTarget.size.x;
    }
  }
}
