import 'package:flutter/material.dart';
// import '../Routes.dart';
import '../staffmemberspage.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color(0xFFE46B66),
            ),
            child: Text(
              '{R} Cohort 19',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.people),
              title: Text('Staff Memebers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StaffMembersPage()),
                );
              }
                  // Navigator.pushReplacementNamed(context, Routes.staffMembers
              ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
