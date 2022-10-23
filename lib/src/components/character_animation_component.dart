import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:super_island/src/game/battle_game.dart';
import 'package:super_island/src/models/character_model.dart';

class CharacterAnimationComponent extends SpriteAnimationComponent
    with HasGameRef<BattleGame> {
  CharacterAnimationComponent(this.character) : super() {
    debugMode = false;
    anchor = Anchor.bottomCenter;
  }

  final CharacterModel character;

  late SpriteAnimationComponent characterAnimation;
  late SpriteAnimation spriteAnimation;
  late Vector2 characterSize;
  late SpriteAnimation standard;
  late SpriteAnimation run;
  late SpriteAnimation attack;
  late SpriteAnimation defense;

  @override
  Future<void>? onLoad() async {
    final characterSprite = await Images().load(character.image);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
      amount: character.characterSprites[0].amount,
      stepTime: character.characterSprites[0].stepTime,
      textureSize: character.characterSprites[0].size,
      texturePosition: character.characterSprites[0].texturePosition,
    );
    standard = SpriteAnimation.fromFrameData(characterSprite, spriteData);
    characterAnimation =
        SpriteAnimationComponent.fromFrameData(characterSprite, spriteData)
          ..size = character.characterSprites[0].size *
              (gameRef.size.y / character.characterSprites[0].scale);
    await add(characterAnimation);
    spriteData = SpriteAnimationData.sequenced(
      amount: character.characterSprites[1].amount,
      stepTime: character.characterSprites[1].stepTime,
      textureSize: character.characterSprites[1].size,
      texturePosition: character.characterSprites[1].texturePosition,
    );
    run = SpriteAnimation.fromFrameData(characterSprite, spriteData);
    spriteData = SpriteAnimationData.sequenced(
      amount: character.characterSprites[2].amount,
      stepTime: character.characterSprites[2].stepTime,
      textureSize: character.characterSprites[2].size,
      texturePosition: character.characterSprites[2].texturePosition,
      loop: false,
    );
    attack = SpriteAnimation.fromFrameData(characterSprite, spriteData);
    spriteData = SpriteAnimationData.sequenced(
      amount: character.characterSprites[3].amount,
      stepTime: character.characterSprites[3].stepTime,
      textureSize: character.characterSprites[3].size,
      texturePosition: character.characterSprites[3].texturePosition,
      loop: false,
    );
    defense = SpriteAnimation.fromFrameData(characterSprite, spriteData);
    spriteAnimation = standard;
    characterSize = character.characterSprites[0].size;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    characterAnimation
      ..animation = spriteAnimation
      ..size = characterSize *
          (gameRef.size.y / character.characterSprites[0].scale);
    super.update(dt);
  }
}
