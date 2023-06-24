import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class Wall extends RectangleComponent {
  Wall({
    super.position,
    super.size,
  }) : super(
          paint: BasicPalette.white.paint(),
        );

  @override
  Future onLoad() async {
    super.onLoad();

    await add(RectangleHitbox());
  }
}
