import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

import 'wall.dart';

class Ball extends CircleComponent with CollisionCallbacks {
  Ball({
    super.position,
  }) : super(
          radius: 30,
          paint: BasicPalette.white.paint(),
        );

  var _vx = 0.0;
  var _vy = 0.0;
  var _elapsedTime = 0.0;

  Vector2? _hitPower;

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

    final origin = Offset(radius, radius);

    if (_hitPower != null) {
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
