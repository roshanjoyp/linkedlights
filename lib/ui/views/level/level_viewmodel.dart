import 'package:linked_lights/app/app.locator.dart';
import 'package:linked_lights/app/app.router.dart';
import 'package:linked_lights/models/level_data.dart';
import 'package:linked_lights/services/level_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LevelViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _levelDataService = locator<LevelDataService>();
  List<LevelData> levels = [];

  void readLevelsData() async {
    levels = _levelDataService.levels;
    rebuildUi();
  }

  void onLevelSelected(String level) {}

  void onPatternSelected(int id) {
    _navigationService.navigateToGameView(levelId: id);
  }
}
