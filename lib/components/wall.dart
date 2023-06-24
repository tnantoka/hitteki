import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

enum WallBounceDirection {
  horizontal,
  vertical,
}

class Wall extends RectangleComponent {
  Wall({
    super.position,
    super.size,
    required this.bounceDirection,
  }) : super(
          paint: BasicPalette.white.paint(),
        );

  final WallBounceDirection bounceDirection;

  @override
  Future onLoad() async {
    super.onLoad();

    await add(RectangleHitbox());
  }
}
