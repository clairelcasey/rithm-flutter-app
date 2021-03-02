import 'package:flutter/material.dart';
import 'package:rithm_sis/homepage.dart';
import './staffdata.dart';
import './homepage.dart';

class StaffMembersPage extends StatefulWidget {
  static const String routeName = "/staff";

  @override
  _StaffDataState createState() => _StaffDataState();
}

class _StaffDataState extends State<StaffMembersPage> {
  final _staffData = staffData;

  Widget _buildStaffMembersPage() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      
      children: <Widget>[
        // Text('Upcoming Lectures/ Exercises:'),
        Expanded(
          child: _buildStaffList(),
        ),
      ],
    );
  }

  Widget _buildStaffList() {
    return ListView.separated(
        padding: EdgeInsets.only(top: 20),
        itemCount: _staffData.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (context, item) {
          return _buildStaffDetail(_staffData[item]);
        });
  }

  Widget _buildStaffDetail(Map staffMember) {
    final String full_name = staffMember['first_name'] + " " + staffMember['last_name'];
    return ListTile(
      leading: 
          Container(
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(staffMember['photo_small_url']),
              ),
            ),
          ),
      title: Text(full_name),
      subtitle: Text(staffMember['description']),
      isThreeLine: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // leading: Image.asset(
        //   'assets/rithm.png',
        // ),
        titleSpacing: 30.0,
        centerTitle: true,
        leadingWidth: 100.0,
        title: Text('{R} Cohort 19'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home), onPressed: () => {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                )
          })
        ]
      ),
      body: _buildStaffMembersPage(),
    );
  }
}
