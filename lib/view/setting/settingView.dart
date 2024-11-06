import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isDarkMode = false;
  bool _isPushNotificationsEnabled = true;
  bool _isEmailNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          // Account Section
          SettingsSection(title: "Account"),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Account Information"),
            subtitle: Text("Update your account details"),
            onTap: () {
              // Navigate to Account Information page
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Change Password"),
            onTap: () {
              // Navigate to Change Password page
            },
          ),
          Divider(),

          // Notifications Section
          SettingsSection(title: "Notifications"),
          SwitchListTile(
            title: Text("Push Notifications"),
            value: _isPushNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                _isPushNotificationsEnabled = value;
              });
            },
            secondary: Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: Text("Email Notifications"),
            value: _isEmailNotificationsEnabled,
            onChanged: (value) {
              setState(() {
                _isEmailNotificationsEnabled = value;
              });
            },
            secondary: Icon(Icons.email),
          ),
          Divider(),

          // Privacy Section
          SettingsSection(title: "Privacy"),
          ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text("Privacy Settings"),
            subtitle: Text("Manage your privacy options"),
            onTap: () {
              // Navigate to Privacy Settings page
            },
          ),
          ListTile(
            leading: Icon(Icons.block),
            title: Text("Blocked Accounts"),
            onTap: () {
              // Navigate to Blocked Accounts page
            },
          ),
          Divider(),

          // Appearance Section
          SettingsSection(title: "Appearance"),
          SwitchListTile(
            title: Text("Dark Mode"),
            value: _isDarkMode,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            secondary: Icon(Icons.brightness_6),
          ),
          Divider(),

          // About Section
          SettingsSection(title: "About"),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("App Version"),
            subtitle: Text("1.0.0"),
          ),
          ListTile(
            leading: Icon(Icons.document_scanner),
            title: Text("Terms of Service"),
            onTap: () {
              // Navigate to Terms of Service page
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text("Privacy Policy"),
            onTap: () {
              // Navigate to Privacy Policy page
            },
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;

  const SettingsSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}
