import 'package:covid19/services/AppGeneralService.dart';
import 'package:get_it/get_it.dart';

import 'services/ui/NavigationService.dart';
import 'services/ui/RouterService.dart';

GetIt locator = GetIt.instance;

setupLocators() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => RouterService(locator<NavigationService>()));
  locator.registerLazySingleton(() => AppGeneralService());
}
