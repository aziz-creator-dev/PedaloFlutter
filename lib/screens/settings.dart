import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFFD7433C),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          AssetImage('assets/profile.jpg'), // Example image
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '+21656253517',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Settings Section
              _buildSectionTitle('General Settings'),
              _buildMenuItem('Language', Icons.language),
              _buildMenuItem('Privacy', Icons.lock),
              _buildMenuItem('Security', Icons.security),
              SizedBox(height: 16),

              // Notification Settings Section
              _buildSectionTitle('Notification Settings'),
              _buildSwitchItem('Push Notifications', Icons.notifications),
              _buildSwitchItem('Email Notifications', Icons.email),
              _buildSwitchItem('SMS Alerts', Icons.sms),
              SizedBox(height: 16),

              // Account Section
              _buildSectionTitle('Account Settings'),
              _buildMenuItem('Change Password', Icons.lock_outline),
              _buildMenuItem('Logout', Icons.exit_to_app, onTap: () {
                // Add logout functionality
              }),
              SizedBox(height: 24),

              // App Theme Section
              _buildSectionTitle('App Theme'),
              _buildMenuItem('Dark Mode', Icons.dark_mode),
              _buildMenuItem('Light Mode', Icons.light_mode),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper method for menu items (General, Account, etc.)
  Widget _buildMenuItem(String title, IconData icon, {Function? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF3D003E)),
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF3D003E),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onTap as void Function()?,
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  // Helper method for switch items (Notification settings, etc.)
  Widget _buildSwitchItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF3D003E)),
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF3D003E),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Switch(
        value: true, // Example: Default state
        onChanged: (bool value) {},
        activeColor: Color(0xFFD7433C),
      ),
    );
  }
}
