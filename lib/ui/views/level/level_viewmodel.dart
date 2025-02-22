import 'package:linked_lights/app/app.locator.dart';
import 'package:linked_lights/app/app.router.dart';
import 'package:linked_lights/util/read_file.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LevelViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  Map<String, List<List<String>>> levels = {};

  void runStartupLogic() async {
    try {
      levels = await ReadFile.readJsonFile("assets/levels.json");
      rebuildUi();
    } catch (e) {
      //print(e);
    }
  }

  void onLevelSelected(String level) {}

  void onPatternSelected(String key, int index, String value) {
    _navigationService.navigateToGameView(
        numberOfLights: int.parse(key), index: index, value: value);
  }
}
