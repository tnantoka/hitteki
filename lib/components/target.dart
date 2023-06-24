import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class Target extends RectangleComponent {
  Target({
    super.position,
    super.size,
    required this.score,
  }) : super(
          paint: BasicPalette.white.paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );

  final int score;

  @override
  Future onLoad() async {
    super.onLoad();

    await add(RectangleHitbox());
  }
}
