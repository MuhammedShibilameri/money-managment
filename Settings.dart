import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_in.dart';

class Settings extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const Settings({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _expenseReminders = true;
  bool _monthlySummary = true;
  bool _biometricLock = false;

  String? _username;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// ✅ Load saved username & email from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? "shibil";
      _email = prefs.getString('email') ?? "mhdshibil@gmail.com";
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = widget.isDarkMode   
        ? Colors.black
        : const Color.fromARGB(255, 250, 250, 250);
    final Color appBarColor =
        widget.isDarkMode ? Colors.grey[900]! : Colors.white;
 
 return Scaffold(
  backgroundColor: bgColor,
  appBar: AppBar(
    leading: const Icon(Icons.menu),
    title: const Text('Settings'),
    backgroundColor: appBarColor,
  ),
  body: ListView(
    children: [
 
      ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(_username ?? ""),
        subtitle: Text(_email ?? ""),
        trailing: const Icon(Icons.edit),
      ),
      const Divider(),

      const ListTile(
        leading: Icon(Icons.currency_rupee),
        title: Text("Currency"),
        trailing: Text("₹"),
      ),

      SwitchListTile(
        secondary: const Icon(Icons.dark_mode),
        title: const Text("Dark Mode"),
        value: widget.isDarkMode,
        onChanged: (val) {
          widget.onThemeChanged(val);
        },
      ),

      const ListTile(
        leading: Icon(Icons.language),
        title: Text("Language"),
        trailing: Text("English"),
      ),
      const Divider(),

      SwitchListTile(
        secondary: const Icon(Icons.notifications),
        title: const Text("Expense Reminders"),
        value: _expenseReminders,
        onChanged: (val) => setState(() => _expenseReminders = val),
      ),
      SwitchListTile(
        secondary: const Icon(Icons.calendar_month),
        title: const Text("Monthly Summary"),
        value: _monthlySummary,
        onChanged: (val) => setState(() => _monthlySummary = val),
      ),
      const Divider(),

      const ListTile(
        leading: Icon(Icons.download),
        title: Text("Export Data"),
      ),
      const ListTile(
        leading: Icon(Icons.upload),
        title: Text("Import Data"),
      ),

      SwitchListTile(
        secondary: const Icon(Icons.lock),
        title: const Text("Biometric Lock"),
        value: _biometricLock,
        onChanged: (val) => setState(() => _biometricLock = val),
      ),
      const Divider(),

      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('Log Out'),
        onTap: () { 
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        },
      ),
    ],
  ),
); 
  }
}