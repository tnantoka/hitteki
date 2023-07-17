import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import 'wall.dart';
import 'target.dart';
import '../main_game.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameRef<MainGame> {
  Ball({
    super.position,
    super.radius,
    required this.onHit,
  }) : super(
          paint: BasicPalette.white.paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4,
        );

  final VoidCallback onHit;

  var _vx = 0.0;
  var _vy = 0.0;
  var _elapsedTime = 0.0;

  Vector2? _hitPower;

  bool get isMoving => _vx != 0 || _vy != 0;

  @override
  Future onLoad() async {
    super.onLoad();

    await add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += Vector2(_vx, _vy) * dt;

    _elapsedTime += dt;
    if (_elapsedTime > 0.2) {
      _elapsedTime = 0;
      _vx *= 0.96;
      _vy *= 0.96;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (isMoving) {
      return;
    }

    final origin = Offset(radius, radius);

    if (_hitPower != null) {
      canvas.drawCircle(
        origin,
        4,
        BasicPalette.white.paint(),
      );

      canvas.drawLine(
        origin,
        origin - _hitPower!.toOffset(),
        BasicPalette.white.paint()..strokeWidth = 2,
      );

      canvas.drawRect(
        Rect.fromCenter(
          center: origin - _hitPower!.toOffset(),
          width: 8,
          height: 8,
        ),
        BasicPalette.white.paint()..strokeWidth = 2,
      );

      canvas.drawLine(
        origin,
        origin + _hitPower!.toOffset(),
        BasicPalette.white.paint()..strokeWidth = 2,
      );

      canvas.drawRect(
        Rect.fromCenter(
          center: origin + _hitPower!.toOffset(),
          width: 8,
          height: 8,
        ),
        BasicPalette.white.paint()..strokeWidth = 2,
      );

      canvas.drawRect(
        Rect.fromCenter(
          center: origin + _hitPower!.toOffset(),
          width: 24,
          height: 24,
        ),
        BasicPalette.white.paint()
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );
    } else {
      canvas.drawRect(
        Rect.fromCenter(
          center: origin,
          width: 8,
          height: 8,
        ),
        BasicPalette.white.paint()..strokeWidth = 2,
      );

      canvas.drawRect(
        Rect.fromCenter(
          center: origin,
          width: 24,
          height: 24,
        ),
        BasicPalette.white.paint()
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Wall) {
      if (other.bounceDirection == WallBounceDirection.horizontal) {
        _vx *= -1;
      } else {
        _vy *= -1;
      }
    } else if (other is Target) {
      game.score += other.score;
      _vx = 30;
      _vy = 30;
      other.removeFromParent();
      onHit();
    }
  }

  void hit(double vx, double vy) {
    _vx += vx;
    _vy += vy;
  }

  void charge(Vector2? power) {
    _hitPower = power;
  }
}
