import 'package:flutter/material.dart';
import 'package:rithm_sis/homepage.dart';
import './homepage.dart';
import './api/staff.dart';
import './api/staffPhotoData.dart';
import 'dart:math';

class StaffMembersPage extends StatefulWidget {
  static const String routeName = "/staff";

  @override
  _StaffDataState createState() => _StaffDataState();
}

class _StaffDataState extends State<StaffMembersPage> {
  Future<List> futureStaffMembers;

  @override
  void initState() {
    super.initState();
    futureStaffMembers = fetchStaffMembers();
  }

  Widget _buildStaffMembersPage(List staffData) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,

      children: <Widget>[
        // Text('Upcoming Lectures/ Exercises:'),
        Expanded(
          child: _buildStaffList(staffData),
        ),
      ],
    );
  }

  Widget _buildStaffList(List staffData) {
    return ListView.separated(
        padding: EdgeInsets.only(top: 20),
        itemCount: staffData.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (context, item) {
          return _buildStaffDetail(staffData[item]);
        });
  }

  Widget _buildStaffDetail(Map staffMember) {
    final String fullName =
        staffMember['first_name'] + " " + staffMember['last_name'];
    Random random = new Random();
    int randStaffPhoto = random.nextInt(staffPhotoData.length);
    return ListTile(
      leading: Container(
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(staffPhotoData[randStaffPhoto]),
          ),
        ),
      ),
      title: Text(fullName),
      subtitle: Text(staffMember['bio']),
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
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                      )
                    })
          ]),
      body: FutureBuilder(
        future: futureStaffMembers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var snapData = snapshot.data;
            return _buildStaffMembersPage(snapData);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(
            child: CircularProgressIndicator());
        },
      ),
    );
  }
}
