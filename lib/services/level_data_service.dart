import 'package:linked_lights/models/level_data.dart';
import 'package:linked_lights/util/read_file.dart';

class LevelDataService {
  late final List<LevelData> _levels;

  List<LevelData> get levels => _levels;

  LevelDataService() {
    loadLevels();
  }

  loadLevels() async {
    try {
      var levelData = await ReadFile.readJsonFile("assets/levels.json");
      _levels = _convertToLevelData(levelData);
    } catch (e) {
      //print(e);
    }
  }

  List<LevelData> _convertToLevelData(Map<int, dynamic> data) {
    List<LevelData> levels = [];

    data.forEach((key, levelData) {
      int levelId = key; // Convert key to int

      levels.add(LevelData(
        id: levelId,
        pattern: levelData["pattern"],
        minimumTapsToWin: levelData["minimumTapsToWin"],
        totalUniqueStates: levelData["total_unique_states"],
      ));
    });

    return levels;
  }
}
