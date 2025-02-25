import 'package:linked_lights/app/app.locator.dart';
import 'package:linked_lights/app/app.router.dart';
import 'package:linked_lights/services/level_data_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _levelDataService = locator<LevelDataService>();

  Future runStartupLogic() async {
    await _levelDataService.loadLevels();
    await Future.delayed(const Duration(seconds: 1));

    _navigationService.replaceWithHomeView();
  }
}
