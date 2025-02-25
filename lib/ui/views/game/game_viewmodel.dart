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

  int _currentTaps = 0;

  List<bool> gameState = [];

  int get currentTaps => _currentTaps;

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
    _currentTaps++;
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

  String getTag(int i) {
    switch (numberOfLights) {
      case 1:
        {
          return "_2";
        }
      case 2:
        {
          if (i == 0) {
            return "_1";
          } else {
            return "_3";
          }
        }
      case 3:
        {
          if (i == 0) {
            return "_0";
          } else if (i == 1) {
            return "_2";
          } else {
            return "_4";
          }
        }
      case 4:
        {
          if (i == 0) {
            return "_0";
          } else if (i == 1) {
            return "_1";
          } else if (i == 2) {
            return "_3";
          } else {
            return "_4";
          }
        }
      case 5:
        {
          if (i == 0) {
            return "_0";
          } else if (i == 1) {
            return "_1";
          } else if (i == 2) {
            return "_2";
          } else if (i == 3) {
            return "_3";
          } else {
            return "_4";
          }
        }
      default:
        return "_1";
    }
  }
}
