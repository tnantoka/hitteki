import 'package:flame/components.dart';

import 'wall.dart';

class Stage extends PositionComponent {
  Stage({
    super.size,
  });

  @override
  Future onLoad() async {
    super.onLoad();

    await _addWalls();
  }

  Future _addWalls() async {
    await add(
      Wall(
        position: Vector2(0, -10),
        size: Vector2(size.x, 10),
        bounceDirection: WallBounceDirection.vertical,
      ),
    );
    await add(
      Wall(
        position: Vector2(0, size.y),
        size: Vector2(size.x, 10),
        bounceDirection: WallBounceDirection.vertical,
      ),
    );
    await add(
      Wall(
        position: Vector2(-10, 0),
        size: Vector2(10, size.y),
        bounceDirection: WallBounceDirection.horizontal,
      ),
    );
    await add(
      Wall(
        position: Vector2(size.x, 0),
        size: Vector2(10, size.y),
        bounceDirection: WallBounceDirection.horizontal,
      ),
    );
  }
}
