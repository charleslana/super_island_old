import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:super_island/src/components/battle_bg_component.dart';
import 'package:super_island/src/components/character_animation_component.dart';
import 'package:super_island/src/components/character_position_component.dart';
import 'package:super_island/src/components/skill_action_component.dart';
import 'package:super_island/src/components/skill_component.dart';
import 'package:super_island/src/data/character_data.dart';
import 'package:super_island/src/game/character_position.dart';

class BattleGame extends FlameGame
    with HasTappableComponents, HasCollisionDetection {
  BattleGame(this.ref);

  final WidgetRef ref;

  late CharacterAnimationComponent playerAnimation1;
  late CharacterPositionComponent playerComponent1;

  late CharacterAnimationComponent enemyAnimation1;
  late CharacterPositionComponent enemyComponent1;

  @override
  Color backgroundColor() {
    return Colors.white;
  }

  @override
  Future<void>? onLoad() async {
    final bg = BattleBgComponent();
    await add(bg);
    playerAnimation1 = CharacterAnimationComponent(CharacterData.get(1));
    playerComponent1 = CharacterPositionComponent(
      character: playerAnimation1.character,
      characterPosition: left1,
    );
    await playerComponent1.add(playerAnimation1);
    await add(playerComponent1);

    enemyAnimation1 = CharacterAnimationComponent(CharacterData.get(2));
    enemyComponent1 = CharacterPositionComponent(
      character: enemyAnimation1.character,
      characterPosition: right1,
      isFlip: true,
    );
    await enemyComponent1.add(enemyAnimation1);
    await add(enemyComponent1);

    await add(SkillComponent(size));
    await add(SkillActionComponent());

    return super.onLoad();
  }
}
