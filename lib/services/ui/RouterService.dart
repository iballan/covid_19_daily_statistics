import 'package:covid19/models/index.dart';
import 'package:covid19/pages/DetailsPage.dart';

import 'NavigationService.dart';

class RouterService {
  final NavigationService navigationService;

  RouterService(this.navigationService);

  openDetailsPage(CountryModel country) {
    navigationService.push(DetailsPage(countryModel: country));
  }
}
