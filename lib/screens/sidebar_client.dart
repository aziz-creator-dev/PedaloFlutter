import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:projet_pfe/screens/client_history.dart';
import 'package:projet_pfe/screens/main_screen_1.dart';
import 'package:projet_pfe/screens/feedback.dart'; // Import the feedback screen
import 'package:projet_pfe/screens/settings.dart'; // Import the settings screen
import 'package:shared_preferences/shared_preferences.dart';

class Sidebar extends StatefulWidget {
  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      try {
        Map<String, dynamic> userData = jsonDecode(userDataString);
        setState(() {
          _userName = userData['name'] ?? 'User';
        });
      } catch (e) {
        print('Error fetching user data: $e');
      }
    } else {
      print('User data not found in SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, -1.00),
              end: Alignment(0.00, 1.00),
              colors: [
                Color(0xFFD7433C),
                Color(0xFFDD5E58),
                Colors.white,
              ],
            ),
          ),
        ),
        Positioned(
          top: 110, // Center vertically
          left: MediaQuery.of(context).size.width * 0.1, // Add left padding
          child: Text(
            _userName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
              letterSpacing: 1.5,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(4, 4),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 140,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height - 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(48),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                _buildMenuItem('My History', Icons.history, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientHistory()),
                  );
                }),
                _buildMenuItem('Feedback', Icons.feedback, navigateToFeedback),
                _buildMenuItem('Invite Friends', Icons.person_add_alt_1),
                _buildMenuItem('Support', Icons.support_agent),
                _buildMenuItem('Settings', Icons.settings, navigateToSettings),
                Spacer(),
                ListTile(
                  leading: Icon(Icons.logout, color: Color(0xFF3D003E)),
                  title: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Color(0xFF3D003E),
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen1()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void navigateToFeedback() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              FeedbackScreen()), // Navigate to the FeedbackScreen
    );
  }

  void navigateToSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SettingsScreen()), // Navigate to the SettingsScreen
    );
  }

  Widget _buildMenuItem(String title, IconData icon, [Function? onTap]) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF3D003E)),
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF3D003E),
          fontSize: 21,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onTap as void Function()?,
    );
  }
}
