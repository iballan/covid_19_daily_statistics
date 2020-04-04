import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19/Constants.dart';
import 'package:covid19/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailsPage extends StatefulWidget {
  final CountryModel countryModel;
  DetailsPage({Key key, this.countryModel}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: Text(widget.countryModel.name),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          _buildGeneralStatsWidget(),
          // SliverList(delegate: SliverChildBuilderDelegate((context, index){
          // }))
          _buildDailyList()
        ],
      ),
    );
  }

  Widget _buildGeneralStatsWidget() {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 18, right: 18, bottom: 40, top: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildStaticItem(
                    title: "Confirmed",
                    number: widget.countryModel.confirmed.total,
                    color: Colors.blue[600]),
                _buildStaticItem(
                    title: "Death",
                    number: widget.countryModel.deaths.total,
                    color: Colors.red[600]),
                _buildStaticItem(
                    title: "Recovered",
                    number: widget.countryModel.recovered.total,
                    color: Colors.green[600])
              ],
            ),
            _buildChart()
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: charts.TimeSeriesChart(
        [
          charts.Series<TimelineModel, DateTime>(
            id: 'Confirmed',
            colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
            domainFn: (timeline, _) => timeline.date,
            measureFn: (timeline, _) => timeline.confirmed,
            data: widget.countryModel.timeline.map((timeline) {
              return TimelineModel(
                confirmed: timeline.confirmed,
                date: timeline.date,
              );
            }).toList(),
          ),
          charts.Series<TimelineModel, DateTime>(
            id: 'Deaths',
            colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
            domainFn: (timeline, _) => timeline.date,
            measureFn: (timeline, _) => timeline.deaths,
            data: widget.countryModel.timeline.map((timeline) {
              return TimelineModel(
                deaths: timeline.deaths,
                date: timeline.date,
              );
            }).toList(),
          ),
          charts.Series<TimelineModel, DateTime>(
            id: 'Recovered',
            colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
            domainFn: (timeline, _) => timeline.date,
            measureFn: (timeline, _) => timeline.recovered,
            data: widget.countryModel.timeline.map((timeline) {
              return TimelineModel(
                recovered: timeline.recovered,
                date: timeline.date,
              );
            }).toList(),
          ),
        ],
        animate: true,
        animationDuration: Duration(seconds: 2),
        defaultInteractions: false,
        defaultRenderer: charts.LineRendererConfig(),
        dateTimeFactory: const charts.LocalDateTimeFactory(),
        behaviors: [
          charts.SeriesLegend(),
          charts.SelectNearest(),
          charts.DomainHighlighter()
        ],
      ),
    );
  }

  Widget _buildStaticItem(
      {String title, num number, Color color = Colors.black}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 6, right: 6),
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
            borderRadius: BorderRadius.circular(12)),
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            depth: 4,
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
              Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Text("$number",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25, color: color, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final currentTl = widget.countryModel
            .timeline[widget.countryModel.timeline.length - index - 1];
        return Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 10, bottom: 10),
          child: Neumorphic(
            boxShape: NeumorphicBoxShape.roundRect(
                borderRadius: BorderRadius.circular(12)),
            style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                depth: 15,
                lightSource: LightSource.topLeft,
                intensity: 0.7,
                color: cardBackgroundColor),
            child: ListTile(
              title: Text("${currentTl.date.year}-${currentTl.date.month}-${currentTl.date.day}",
                style: TextStyle(fontSize: 16, color: lightGreyTextColor, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Expanded(
                    child: _buildDailyStatItem(
                        title: "Confirmed",
                        number: currentTl.confirmed,
                        color: Colors.blue[600]),
                  ),
                  Expanded(
                    child: _buildDailyStatItem(
                        title: "Death",
                        number: currentTl.deaths,
                        color: Colors.red[600]),
                  ),
                  Expanded(
                    child: _buildDailyStatItem(
                        title: "Recovered",
                        number: currentTl.recovered,
                        color: Colors.green[600]),
                  )
                ],
              ),
            ),
          ),
        );
      }, childCount: widget.countryModel.timeline.length),
    );
  }

  Widget _buildDailyStatItem(
      {String title, num number, Color color = Colors.black}) {
    return Container(
      margin: const EdgeInsets.only(top:14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: lightGreyTextColor,fontWeight: FontWeight.bold),
              ),
              Text("$number",
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: color, fontWeight: FontWeight.bold)),
            ],
          ),
    );
  }
}
