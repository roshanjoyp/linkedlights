import 'package:linked_lights/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:linked_lights/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:linked_lights/ui/views/game/game_view.dart';
import 'package:linked_lights/ui/views/home/home_view.dart';
import 'package:linked_lights/ui/views/level/level_view.dart';
import 'package:linked_lights/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LevelView),
    //MaterialRoute(page: GameView),
    CustomRoute(
        page: GameView,
        transitionsBuilder: TransitionsBuilders.slideRight,
        durationInMilliseconds: 1000),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
