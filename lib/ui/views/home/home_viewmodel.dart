import 'package:linked_lights/app/app.bottomsheets.dart';
import 'package:linked_lights/app/app.locator.dart';
import 'package:linked_lights/app/app.router.dart';
import 'package:linked_lights/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }

  void navigateToLevels() {
    _navigationService.navigateTo(Routes.levelView);
  }
}
