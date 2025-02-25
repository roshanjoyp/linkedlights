import 'package:flutter/material.dart';
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
      body: Container(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          bottom: 25,
        ),
        alignment: Alignment.center,
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
    );
  }

  @override
  GameViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      GameViewModel(levelId: levelId);
}
