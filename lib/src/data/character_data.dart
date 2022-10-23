import 'package:flame/input.dart';
import 'package:super_island/src/models/character_model.dart';

class CharacterData {
  CharacterData._();

  static CharacterModel get(int id) {
    final List<CharacterSprite> characterSprites = [];
    switch (id) {
      case 1:
        final standard = CharacterSprite(
          size: Vector2(192, 256),
          amount: 3,
          stepTime: 0.3,
          scale: 800,
          texturePosition: Vector2(0, 0),
        );
        final run = CharacterSprite(
          size: Vector2(192, 256),
          amount: 1,
          stepTime: 0.3,
          scale: 800,
          texturePosition: Vector2(25, 256),
        );
        final attack = CharacterSprite(
          size: Vector2(256, 256),
          amount: 3,
          stepTime: 0.3,
          scale: 800,
          texturePosition: Vector2(-60, 768),
        );
        characterSprites.addAll([standard, run, attack, attack]);
        return CharacterModel(
          image: 'characters/luffy1.png',
          characterSprites: characterSprites,
        );
      case 2:
        final standard = CharacterSprite(
          size: Vector2(320, 230),
          amount: 3,
          stepTime: 0.3,
          scale: 900,
          texturePosition: Vector2(0, 0),
        );
        final defense = CharacterSprite(
          size: Vector2(320, 230),
          amount: 1,
          stepTime: 0.5,
          scale: 900,
          texturePosition: Vector2(300, 220),
        );
        characterSprites.addAll([standard, standard, standard, defense]);
        return CharacterModel(
          image: 'characters/zoro1.png',
          characterSprites: characterSprites,
        );
      default:
        return CharacterModel(
          image: '',
          characterSprites: characterSprites,
        );
    }
  }
}
