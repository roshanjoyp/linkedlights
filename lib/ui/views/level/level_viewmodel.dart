import 'package:linked_lights/util/read_file.dart';
import 'package:stacked/stacked.dart';

class LevelViewModel extends BaseViewModel {
  Map<String, List<List<String>>> levels = {};
  void runStartupLogic() async {
    try {
      levels = await ReadFile.readJsonFile("assets/levels.json");
      rebuildUi();
    } catch (e) {
      print(e);
    }
  }

  void onLevelSelected(String level) {}

  void onPatternSelected(String key, int index) {}
}
