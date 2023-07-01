import 'dart:ui';

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

  @override
  void render(Canvas canvas) {
    //super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(
        paint.strokeWidth,
        paint.strokeWidth,
        width - paint.strokeWidth * 2,
        height - paint.strokeWidth * 2,
      ),
      paint,
    );
  }
}
