import 'package:flutter/material.dart';
import './homepage.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/extractArguments';


  @override
  Widget build(BuildContext context) {
  final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}