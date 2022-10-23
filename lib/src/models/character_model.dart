import 'package:flame/input.dart';

class CharacterModel {
  CharacterModel({
    required this.image,
    required this.characterSprites,
  });

  final String image;
  final List<CharacterSprite> characterSprites;
}

class CharacterSprite {
  CharacterSprite({
    required this.size,
    required this.amount,
    required this.stepTime,
    required this.scale,
    required this.texturePosition,
  });

  final Vector2 size;
  final int amount;
  final double stepTime;
  final double scale;
  final Vector2 texturePosition;
}
