import 'package:linked_lights/app/app.dialogs.dart';
import 'package:linked_lights/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GameViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
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

  void checkIfWon() {
    int n = gameState.length;
    for (int i = 0; i < n; i++) {
      if (gameState[i] == false) {
        return;
      }
    }
    showDialog();
  }
}
