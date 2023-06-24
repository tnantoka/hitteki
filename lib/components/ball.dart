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

  var vx = 0.0;
  var vy = 0.0;

  @override
  Future onLoad() async {
    super.onLoad();

    await add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += Vector2(vx, vy) * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Wall) {
      vx *= -1;
      vy *= -1;
    }
  }
}
