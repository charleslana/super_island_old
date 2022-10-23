import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:super_island/src/game/battle_game.dart';
import 'package:super_island/src/models/character_model.dart';

class CharacterPositionComponent extends PositionComponent
    with HasGameRef<BattleGame>, CollisionCallbacks {
  CharacterPositionComponent({
    required this.character,
    required this.characterPosition,
    this.isFlip = false,
  }) : super() {
    debugMode = false;
    anchor = Anchor.bottomCenter;
  }

  final CharacterModel character;
  final Vector2 characterPosition;
  final bool isFlip;

  bool isRun = false;

  @override
  Future<void>? onLoad() async {
    position = Vector2(characterPosition.x * (gameRef.size.x / 1),
        characterPosition.y * (gameRef.size.y / 1));
    size = character.characterSprites[0].size *
            (gameRef.size.y / character.characterSprites[0].scale) -
        Vector2(character.characterSprites[0].size.x / 4, 0);
    if (isFlip) {
      flipHorizontally();
    }
    await add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (isRun) {
      gameRef.playerAnimation1.characterAnimation.animation =
          gameRef.playerAnimation1.run;
      gameRef.playerAnimation1.characterSize =
          gameRef.playerAnimation1.character.characterSprites[1].size;
      if ((gameRef.playerComponent1.x + gameRef.playerComponent1.size.x) <
          gameRef.size.x) {
        gameRef.playerComponent1.x += gameRef.size.x / 60;
      }
    }
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is CharacterPositionComponent) {
      gameRef.playerComponent1
        ..isRun = false
        ..priority = 1
        ..size = gameRef.playerAnimation1.character.characterSprites[2].size *
            (gameRef.size.y / character.characterSprites[2].scale);
      gameRef.playerAnimation1.spriteAnimation =
          gameRef.playerAnimation1.attack;
      gameRef.playerAnimation1.characterSize =
          gameRef.playerAnimation1.character.characterSprites[2].size;

      gameRef.enemyAnimation1.spriteAnimation = gameRef.enemyAnimation1.defense;
      gameRef.playerAnimation1.attack.onComplete = () {
        gameRef.playerComponent1.position = Vector2(
            characterPosition.x * (gameRef.size.x / 1),
            characterPosition.y * (gameRef.size.y / 1));
        gameRef.playerAnimation1
          ..spriteAnimation = gameRef.playerAnimation1.standard
          ..characterSize =
              gameRef.playerAnimation1.character.characterSprites[0].size;
        gameRef.playerAnimation1.attack.reset();

        gameRef.enemyAnimation1.defense.reset();
        gameRef.enemyAnimation1.spriteAnimation =
            gameRef.enemyAnimation1.standard;
      };
    }
    super.onCollision(intersectionPoints, other);
  }

  void changeSize(Vector2 size, Vector2 position) {
    size = size;
    position = position;
  }
}
