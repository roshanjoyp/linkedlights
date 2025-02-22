import 'package:stacked/stacked.dart';

class GameViewModel extends BaseViewModel {
  final int numberOfLights;
  final int index;
  final String value;

  List<bool> gameState = [];

  GameViewModel({
    required this.numberOfLights,
    required this.index,
    required this.value,
  }) {
    init();
  }

  void init() {
    int n = numberOfLights;
    gameState = List.filled(n, false);
  }

  void onLightTapped(int lightIndex) {
    int n = gameState.length;
    for (int i = 0; i < n; i++) {
      // Check if the light is connected
      if (value[lightIndex * n + i] == '1') {
        gameState[i] = !gameState[i];
      }
    }
    rebuildUi();
  }
}
