import 'dart:math';

import 'package:linked_lights/app/app.dialogs.dart';
import 'package:linked_lights/app/app.locator.dart';
import 'package:linked_lights/models/level_data.dart';
import 'package:linked_lights/services/level_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GameViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _levelDataService = locator<LevelDataService>();

  final int levelId;
  late final int numberOfLights;
  late final LevelData levelData;
  bool _tapEnabled = true;

  List<bool> gameState = [];

  GameViewModel({
    required this.levelId,
  }) {
    init();
  }

  bool get tapEnabled => _tapEnabled;

  void init() {
    levelData = _levelDataService.levels.firstWhere((e) => e.id == levelId);
    numberOfLights = sqrt(levelData.pattern.length).toInt();
    gameState = List.filled(numberOfLights, false);
  }

  void onLightTapped(int lightIndex) {
    int n = gameState.length;
    for (int i = 0; i < n; i++) {
      // Check if the light is connected
      if (levelData.pattern[lightIndex * n + i] == '1') {
        gameState[i] = !gameState[i];
      }
    }
    checkIfWon();
    rebuildUi();
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'You WON',
      description: 'Amazing',
    );
  }

  void checkIfWon() async {
    int n = gameState.length;
    for (int i = 0; i < n; i++) {
      if (gameState[i] == false) {
        return;
      }
    }
    _tapEnabled = false;
    rebuildUi();
    await Future.delayed(const Duration(milliseconds: 500));
    _tapEnabled = true;
    rebuildUi();
    showDialog();
  }
}
