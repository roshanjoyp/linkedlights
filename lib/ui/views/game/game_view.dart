import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:linked_lights/ui/views/game/widgets/background_animation.dart';
import 'package:linked_lights/ui/views/game/widgets/light_tile.dart';
import 'package:stacked/stacked.dart';

import 'game_viewmodel.dart';

class GameView extends StackedView<GameViewModel> {
  const GameView({
    required this.levelId,
    Key? key,
  }) : super(key: key);
  final int levelId;

  @override
  Widget builder(
    BuildContext context,
    GameViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text("#${viewModel.levelId}"),
      ),
      //backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          //Background Animation
          //Blur section
          //game body
          const BackgroundAnimation(),
          Positioned.fill(
            child: Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.black.withOpacity(.05),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              bottom: 25,
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "CURRENT TAPS",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${viewModel.currentTaps}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      for (int i = 0; i < viewModel.gameState.length; i++)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (viewModel.tapEnabled) {
                                viewModel.onLightTapped(i);
                              }
                            },
                            child: Hero(
                              tag: viewModel.getTag(i),
                              child: LightTile(
                                index: i,
                                isOn: viewModel.gameState[i],
                              ),
                            ),
                          ),
                        ),
                    ].reversed.toList(),
                  ),
                ),
                const Expanded(
                  child: Column(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  GameViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      GameViewModel(levelId: levelId);
}
