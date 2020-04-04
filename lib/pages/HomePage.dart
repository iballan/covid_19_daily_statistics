import 'dart:io';

import 'package:covid19/Locator.dart';
import 'package:covid19/models/country.dart';
import 'package:covid19/models/index.dart';
import 'package:covid19/services/AppGeneralService.dart';
import 'package:covid19/services/ui/RouterService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../Constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var isLoading = true;
  List<CountryModel> countryModels = List();
  num totalConfirmed = 0;
  num totalDeaths = 0;
  num totalRecovered = 0;

  List<String> _filters = ["A-Z", "Confirmed", "Deaths", "Recovered"];
  String _seletedFilter = "A-Z";

  @override
  void initState() {
    super.initState();

    getData();
    _initOneSignal();
  }

  setIsLoading(bool isLoading) {
    if (this.isLoading == isLoading) return;
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          top: true,
          child: CustomScrollView(
            slivers: <Widget>[
              _buildGeneralStatsWidget(),
              SliverPadding(
                padding: const EdgeInsets.only(left: 30),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "By Country",
                    style: TextStyle(
                        fontSize: 20,
                        color: darkBlue,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(
                    left: 18, right: 18, bottom: 5, top: 16),
                sliver: SliverToBoxAdapter(
                  child: _buildFilterDropDownWidget(),
                ),
              ),
              _buildCountriesListWidget()
            ],
          ),
        ));
  }

  Future<void> getData() async {
    setIsLoading(true);

    locator<AppGeneralService>().getAll().then((allCountries) {
      print("Countries are here now ${allCountries.length}");
      countryModels = allCountries;
      totalConfirmed = 0;
      totalDeaths = 0;
      totalRecovered = 0;
      allCountries.forEach((country) {
        num countryTotalConfirmed = 0;
        num countryTotalDeaths = 0;
        num countryTotalRecovered = 0;
        if (country.timeline != null) {
          country.timeline.sort((a, b) => a.date.compareTo(b.date));
          country.timeline?.forEach((tl) {
            countryTotalConfirmed = (tl.confirmed ?? 0);
            countryTotalDeaths = (tl.deaths ?? 0);
            countryTotalRecovered = (tl.recovered ?? 0);
          });
        }
        country.confirmed = SummaryModel(total: countryTotalConfirmed);
        country.deaths = SummaryModel(total: countryTotalDeaths);
        country.recovered = SummaryModel(total: countryTotalRecovered);
        totalConfirmed += countryTotalConfirmed;
        totalDeaths += countryTotalDeaths;
        totalRecovered += countryTotalRecovered;
      });
    }).then((n) {
      setIsLoading(false);
    });
  }

  Widget _buildGeneralStatsWidget() {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 10, top: 60),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          isLoading
              ? _buildLoadingView()
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 12),
                      child: Text(
                        "Global",
                        style: TextStyle(
                            fontSize: 20,
                            color: darkBlue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _buildStaticItem(
                        title: "Confirmed",
                        number: totalConfirmed,
                        color: Colors.blue[600]),
                    _buildStaticItem(
                        title: "Death",
                        number: totalDeaths,
                        color: Colors.red[800]),
                    _buildStaticItem(
                        title: "Recovered",
                        number: totalRecovered,
                        color: Colors.green[800])
                  ],
                )
        ]),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
      child: NeumorphicProgressIndeterminate(
        duration: Duration(seconds: 2),
        style: ProgressStyle(
          depth: 3,
          accent: Colors.grey,
          borderRadius: 10,
          variant: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildStaticItem(
      {String title, num number, Color color = Colors.black}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 10, bottom: 15, left: 6, right: 6),
      child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(12)),
          style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              depth: 7,
              lightSource: LightSource.topLeft,
              intensity: 0.7,
              color: cardBackgroundColor),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                Text("$number",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        color: color,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          )),
    );
  }

  Widget _buildCountriesListWidget() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final current = countryModels[index];
        return _buildCountryItemWidget(current);
      }, childCount: countryModels.length),
    );
  }

  Widget _buildCountryItemWidget(CountryModel current) {
    return ListTile(
      title: Container(
          padding: const EdgeInsets.only(left: 10, right: 5),
          child: Text(current.name,
              style: TextStyle(color: darkBlue, fontSize: 17))),
      subtitle: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: _buildCountryStaticItem(
                title: "Confirmed",
                number: current.confirmed.total,
                color: Colors.blue[600]),
          ),
          Expanded(
            child: _buildCountryStaticItem(
                title: "Death",
                number: current.deaths.total,
                color: Colors.red[800]),
          ),
          Expanded(
            child: _buildCountryStaticItem(
                title: "Recovered",
                number: current.recovered.total,
                color: Colors.green[800]),
          )
        ],
      ),
      onTap: () {
        locator<RouterService>().openDetailsPage(current);
      },
    );
  }

  Widget _buildCountryStaticItem(
      {String title, num number, Color color = Colors.black}) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 15, left: 5, right: 5),
      child: Neumorphic(
          boxShape: NeumorphicBoxShape.roundRect(
              borderRadius: BorderRadius.circular(12)),
          style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              depth: 2,
              lightSource: LightSource.topLeft,
              intensity: 0.57,
              color: cardBackgroundColor),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: darkBlue,
                        fontWeight: FontWeight.w500)),
                Text("$number",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        color: color,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          )),
    );
  }

  Widget _buildFilterDropDownWidget() {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 15, left: 5, right: 5),
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
            borderRadius: BorderRadius.circular(12)),
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            depth: 5,
            lightSource: LightSource.topLeft,
            intensity: 0.5,
            color: cardBackgroundColor),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            Text(
              'Sorted by: ',
              style: TextStyle(color: darkBlue),
            ),
            DropdownButton<String>(
              value: _seletedFilter,
              onChanged: (String value) {
                if (value == _seletedFilter) return;
                setState(() {
                  _seletedFilter = value;
                  if (_seletedFilter == "Confirmed") {
                    countryModels.sort((c1, c2) =>
                        c1.confirmed.total <= c2.confirmed.total ? 1 : -1);
                  } else if (_seletedFilter == "Deaths") {
                    countryModels.sort((c1, c2) =>
                        c1.deaths.total <= c2.deaths.total ? 1 : -1);
                  } else if (_seletedFilter == "Recovered") {
                    countryModels.sort((c1, c2) =>
                        c1.recovered.total <= c2.recovered.total ? 1 : -1);
                  } else {
                    countryModels.sort((c1, c2) => c1.name.compareTo(c2.name));
                  }
                });
              },
              items: _filters.map((String filter) {
                return DropdownMenuItem<String>(
                  value: filter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          filter,
                          maxLines: 1,
                          style: TextStyle(color: darkBlue),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _initOneSignal() {
    Future.delayed(Duration(seconds: 2)).then((value) async {
      if (Platform.isIOS) {
        bool hasPermission =
            await OneSignal.shared.promptUserForPushNotificationPermission();
        print("Has permission $hasPermission");
      }
      OneSignal.shared.init(oneSignalAppId, iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: true
      }).then((v) {
        OneSignal.shared
            .setInFocusDisplayType(OSNotificationDisplayType.notification);
      });
    });
  }
}
