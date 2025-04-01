import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'package:zombie_conga_flame/game/zombie_conga_game.dart';
import 'package:zombie_conga_flame/loading/view/game_over_menu.dart';
import 'package:zombie_conga_flame/loading/view/settings_menu.dart';

ZombieCongaGame _zombieCongaGame = ZombieCongaGame();

class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GameWidget(
              game: _zombieCongaGame,
              overlayBuilderMap: {
                GameOverMenu.id: (BuildContext context, ZombieCongaGame gameRef) => GameOverMenu(gameRef: gameRef),
                SettingsMenu.id: (BuildContext context, ZombieCongaGame gameRef) => SettingsMenu(gameRef: gameRef),
              },
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 4, spreadRadius: 2)],
              ),
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white, size: 32),
                onPressed: () {
                  _zombieCongaGame.pauseEngine();
                  _zombieCongaGame.overlays.add(SettingsMenu.id);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
