import 'package:flutter/material.dart';
import './homepage.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    final start = (args.start_at);
    final end = (args.end_at);

    return Scaffold(
        appBar: AppBar(
          title: Text(args.title),
        ),
        body: Container(
          padding: EdgeInsets.all(35),
          child: Column(
            children: <Widget>[
              Text('From: $start', style: TextStyle(fontSize: 12.0)),
              Text('To: $end', style: TextStyle(fontSize: 12.0)),
              Divider(
                height: 35,
                thickness: 5,
                indent: 10,
                endIndent: 10,
              ),
              Text(args.description),
            ],
          ),
        ));
  }
}
