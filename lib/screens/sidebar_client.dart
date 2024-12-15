import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
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
            'John Doe',
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
                _buildMenuItem('My History', Icons.history),
                _buildMenuItem('Feedback', Icons.feedback),
                _buildMenuItem('Invite Friends', Icons.person_add_alt_1),
                _buildMenuItem('Support', Icons.support_agent),
                _buildMenuItem('Settings', Icons.settings),
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
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(String title, IconData icon) {
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
      onTap: () {},
    );
  }
}
