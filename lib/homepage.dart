import 'package:flutter/material.dart';
import './scheduleData.dart';

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
  final _upcomingSchedule = scheduleData;

  Widget _buildUpcomingList() {
    return ListView.separated(
      itemCount: _upcomingSchedule.length,
      padding: const EdgeInsets.all(16.0),
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (context, item) {
        return _buildRow(_upcomingSchedule[item]);
      },
    );
  }

  Widget _buildRow(Map scheduleItem) {
    var dateTime = scheduleItem['date'] + ' ' + scheduleItem['start_at'];
    return ListTile(
      title: Text(scheduleItem['title'], style: TextStyle(fontSize: 18.0)),
      subtitle: Text(dateTime, style: TextStyle(fontSize: 12.0)),
      trailing: Icon(Icons.read_more,
                     size: 30.0),
    );
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
          titleSpacing: 65.0,
          centerTitle: false,
          leadingWidth: 100.0,

          title: Text('R19 Upcoming'),
        ),
        body: _buildUpcomingList());
  }
}
