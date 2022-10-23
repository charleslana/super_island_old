import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:super_island/src/enums/character_move_enum.dart';
import 'package:super_island/src/game/battle_game.dart';
import 'package:super_island/src/providers/battle_provider.dart';

class SkillActionComponent extends PositionComponent
    with HasGameRef<BattleGame>, TapCallbacks {
  SkillActionComponent()
      : super(
          anchor: Anchor.center,
          size: Vector2.all(100),
        );

  final _paint = Paint()..color = const Color(0xffffffff);

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    position
      ..y = size.y / 1.15
      ..x = size.x / 10 * 1;
    this.size = Vector2(size.x / 10, size.y / 5);
    _paint.color = Colors.deepPurple;
  }

  @override
  void render(Canvas canvas) {
    debugMode = true;
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    const textSpan = TextSpan(
      text: 'Skill text',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textScaleFactor: size.y / 100,
      textAlign: TextAlign.center,
    )..layout(
        maxWidth: size.x,
      );
    final xCenter = (size.x - textPainter.width) / 2;
    final yCenter = (size.y - textPainter.height) / 2;
    final offset = Offset(xCenter, yCenter);
    canvas.drawRect(size.toRect(), _paint);
    textPainter.paint(canvas, offset);
  }

  @override
  void onTapUp(TapUpEvent event) {
    final ref = gameRef.ref;
    if (ref.watch(battleProvider).move == CharacterMoveEnum.standard) {
      // gameRef.player1.changeMove(CharacterMoveEnum.run, ref);
      gameRef.playerAnimation1.spriteAnimation = gameRef.playerAnimation1.run;
      gameRef.playerComponent1.isRun = true;
    }
    super.onTapUp(event);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // print('tap down');
    super.onTapDown(event);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    // print('tap cancel');
    super.onTapCancel(event);
  }
}
