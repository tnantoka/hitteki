import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Target extends RectangleComponent {
  Target({
    super.position,
    super.size,
    required this.score,
    super.paint,
  });

  final int score;

  @override
  Future onLoad() async {
    super.onLoad();

    await add(RectangleHitbox());
  }
}
