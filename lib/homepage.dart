import 'package:flutter/material.dart';
import 'package:rithm_sis/detailpage.dart';
import './detailpage.dart';
import './widgets/drawer.dart';
import './api/upcoming.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Homepage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _UpcomingScheduleState createState() => _UpcomingScheduleState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _UpcomingScheduleState extends State<Homepage> {
  Future<List> futureUpcoming;
  List filteredUpcomingData;
  bool showFilteredData = false;

  @override
  void initState() {
    super.initState();
    futureUpcoming = fetchUpcoming();
    filteredUpcomingData = [];
    showFilteredData = false;
  }

  Widget _buildHomepage(List upcomingData) {

    print('showFilteredData top of Homepage $showFilteredData');
    var dataToShow = (showFilteredData) ? filteredUpcomingData : upcomingData;
    print('dataToShow $dataToShow');

    final _debouncer = Debouncer(milliseconds: 500);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              contentPadding: EdgeInsets.all(10.0),
              helperText: 'Title or type (lecture, event, exercise)',
              hintText: 'Filter by title or type.',
              border: const OutlineInputBorder(),
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  // TODO: Currently, the showFilteredData is being set each 
                  // time the search is changed. This should be refactored to 
                  // only change this state once the build is complete. 
                  // We couldn't figure out how to setState inside a build without infinite re-rednerings, so we set the state here.
                  showFilteredData = true;
                  filteredUpcomingData = upcomingData
                      .where((u) => (u['title']
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u['type']
                              .toLowerCase()
                              .contains(string.toLowerCase())))
                      .toList();
                });
              });
            },
          ),
        ),
        Divider(
          height: 5,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
        Expanded(
          child: _buildUpcomingList(dataToShow),
        ),
      ],
    );
  }

  Widget _buildUpcomingList(List upcomingData) {
    return ListView.separated(
      itemCount: upcomingData.length,
      padding: const EdgeInsets.all(16.0),
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, item) {
        // NOTE: initially had a header, but decided not to. Leaving this in 
        // for reference. 
        // if (item == 0) {
        //   // return the header
        //   return Padding(
        //       padding: const EdgeInsets.all(15.0),
        //       child: Text(
        //         "Upcoming Lectures/ Exercises:",
        //         style: TextStyle(
        //           fontSize: 18.0,
        //           fontWeight: FontWeight.w500,
        //         ),
        //         // textAlign: TextAlign.center,
        //       ));
        // }
        // item -= 1;
        return _buildRow(upcomingData[item]);
      },
    );
  }

  Widget _buildRow(Map scheduleItem) {
    DateTime dtStart = DateTime.parse(scheduleItem['start_at']);
    DateTime dtEnd = DateTime.parse(scheduleItem['end_at']);

    final DateFormat formatter = DateFormat.EEEE().add_yMd().add_jm();

    final String startFormatted = formatter.format(dtStart);
    final String endFormatted = formatter.format(dtEnd);

    return ListTile(
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: scheduleItem['title'] + ' ',
                  style: TextStyle(color: Colors.black, fontSize: 20.0)),
              TextSpan(
                  text: '(' + scheduleItem['type'] + ')',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        subtitle: Text(startFormatted, style: TextStyle(fontSize: 12.0)),
        trailing: IconButton(
            icon: Icon(Icons.read_more, size: 30.0),
            onPressed: () {
              Navigator.pushNamed(context, DetailPage.routeName,
                  arguments: ScreenArguments(
                    scheduleItem['title'],
                    scheduleItem['description'],
                    startFormatted,
                    endFormatted,
                    scheduleItem['type'],
                  ));
            }));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/rithm.png',
        ),
        titleSpacing: 30.0,
        centerTitle: true,
        leadingWidth: 100.0,
        title: Text('{R} Cohort 19'),
      ),
      // FutureBuilder shows a loading indicator until data from the API has 
      // been fetched (futureUpcoming state is resolved). It passes the 
      // resolved data down to build Homepage. 
      // For reference: https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html
      body: FutureBuilder(
        future: futureUpcoming,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var snapData = snapshot.data;
            return _buildHomepage(snapData);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      ),
      endDrawer: AppDrawer(),
    );
  }
}

/// Create screen arguments class for upcoming data so that data can be passed //// to child widgets. 
class ScreenArguments {
  final String title;
  final String description;
  final String start_at;
  final String end_at;
  final String type;

  ScreenArguments(
      this.title, this.description, this.start_at, this.end_at, this.type);
}
