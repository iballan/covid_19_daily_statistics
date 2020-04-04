import 'package:covid19/services/AppGeneralService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Locator.dart';
import 'pages/HomePage.dart';
import 'services/ui/NavigationService.dart';

void main(){
  setupLocators();
  runApp(MultiProvider(
    providers: [
      Provider<AppGeneralService>(
        create: (context) => locator<AppGeneralService>(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid19',
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomePage(),
    );
  }
}
