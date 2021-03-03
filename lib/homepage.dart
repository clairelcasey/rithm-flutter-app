import 'package:flutter/material.dart';
import 'package:rithm_sis/api/staff.dart';
import 'package:rithm_sis/detailpage.dart';
import './scheduleData.dart';
import './detailpage.dart';
import './widgets/drawer.dart';
import './api/upcoming.dart';

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

class _UpcomingScheduleState extends State<Homepage> {
  Future<List> futureUpcoming;

  @override
  void initState() {
    print('IN INITSTATE');
    super.initState();
    futureUpcoming = fetchUpcoming();
  }

  Widget _buildHomepage(List upcomingData) {
    print('buildHomepage');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Text('Upcoming Lectures/ Exercises:'),
        Expanded(
          child: _buildUpcomingList(upcomingData),
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
        // print('_upcomingSchedule is $_upcomingSchedule');
        // print('futureStaffMembers is $futureStaffMembers');
        return _buildRow(upcomingData[item]);
      },
    );
  }

  Widget _buildRow(Map scheduleItem) {
    print('scheduleItem is $scheduleItem');
    String type = scheduleItem['type'];
    // var test = scheduleItem[type];
    var title;
    if (type == "exercise") {
      title = scheduleItem['exercisesession']['exercise']['title'];
    } else {
      title = scheduleItem[type]['title'];
    }
    print('title is $title');
    return ListTile(
        title: Text(title, style: TextStyle(fontSize: 18.0)),
        subtitle: Text(scheduleItem['start_at'], style: TextStyle(fontSize: 12.0)),
        trailing: IconButton(
            icon: Icon(Icons.read_more, size: 30.0),
            onPressed: () {
              Navigator.pushNamed(context, DetailPage.routeName,
                  arguments: ScreenArguments(title,
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: Image.asset(
          'assets/rithm.png',
        ),
        titleSpacing: 30.0,
        centerTitle: true,
        leadingWidth: 100.0,
        title: Text('{R} Cohort 19'),
        // actions: <Widget>[
        //   IconButton(icon: Icon(Icons.list), onPressed: () => {})
        // ]
      ),
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
          return CircularProgressIndicator();
        },
      ),
      endDrawer: AppDrawer(),
    );
  }
}

class ScreenArguments {
  final String title;

  ScreenArguments(this.title);
}
