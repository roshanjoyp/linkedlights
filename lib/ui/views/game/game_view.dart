import 'package:flutter/material.dart';
import 'package:linked_lights/ui/common/custom_icon/extended_decorated_icon.dart';
import 'package:linked_lights/ui/common/custom_icon/icon_border.dart';
import 'package:linked_lights/ui/common/custom_icon/icon_decoration.dart';
import 'package:stacked/stacked.dart';

import 'game_viewmodel.dart';

class GameView extends StackedView<GameViewModel> {
  const GameView({
    required this.numberOfLights,
    required this.index,
    required this.value,
    Key? key,
  }) : super(key: key);
  final int numberOfLights;
  final int index;
  final String value;

  @override
/*************  ✨ Codeium Command ⭐  *************/
  /// The builder function for the [GameView].
  ///
  /// This function will create the visual representation of the game.
  ///
  /// It will create a [Scaffold] with a transparent background and an
  /// [AppBar] with a transparent background.
  ///
  /// The body of the [Scaffold] will be a [Container] with a padding of
  /// 10.0 on the left and right sides, and 25.0 on the bottom.
  ///
  /// The child of the [Container] will be a [Center] widget, which will
  /// contain a [RotatedBox] that will rotate the child 90 degrees if the
  /// height of the screen is greater than the width.
  ///
  /// The child of the [RotatedBox] will be a [Column] with a single child,
  /// which is an [Expanded] widget with a flex factor of 3.
  ///
  /// The child of the [Expanded] widget will be a [Row] with a main axis
  /// size of [MainAxisSize.max].
  ///
  /// The children of the [Row] will be a list of [LightTile] widgets, each
  /// representing a light in the game.
  ///
  /// The [LightTile] widget will have an index, which is the position of
  /// the light in the game state, and an isOn property, which is true if
  /// the light is on and false if it is off.
  ///
  /// The [LightTile] widget will also have an onLightTapped property, which
  /// is a function that will be called when the light is tapped.
  /// ****  b52d5f64-9dbf-4b5c-b1e9-5d9ff8563cfa  ******
  Widget builder(
    BuildContext context,
    GameViewModel viewModel,
    Widget? child,
  ) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          bottom: 25,
        ),
        child: Center(
          child: RotatedBox(
            quarterTurns: size.height > size.width ? 1 : 0,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      for (int i = 0; i < viewModel.gameState.length; i++)
                        LightTile(
                          index: i,
                          isOn: viewModel.gameState[i],
                          onLightTapped: viewModel.onLightTapped,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  GameViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      GameViewModel(numberOfLights: numberOfLights, index: index, value: value);
}

class LightTile extends StatelessWidget {
  const LightTile({
    super.key,
    required this.index,
    required this.isOn,
    required this.onLightTapped,
  });

  final int index;
  final bool isOn;
  final Function(int) onLightTapped;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onLightTapped(index);
        },
        child: RotatedBox(
          quarterTurns: index % 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: AnimatedScale(
                scale: isOn ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: ExtendedDecoratedIcon(
                  icon: Icon(
                    Icons.play_arrow_outlined,
                    color: isOn ? Colors.white : Colors.transparent,
                  ),
                  decoration: const IconDecoration(
                    border: IconBorder(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
