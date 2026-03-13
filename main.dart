// import 'package:flutter/material.dart';
// import 'bottom.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isDarkMode = false;

//   void _handleThemeChange(bool value) {
//     setState(() {
//       _isDarkMode = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
//       home: BottomNavScreen(
//         isDarkMode: _isDarkMode,
//         onThemeChanged: _handleThemeChange,
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'bottom.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool _isDarkMode = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadTheme();
//   }

//   Future<void> _loadTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _isDarkMode = prefs.getBool('darkMode') ?? false;
//     });
//   }

//   Future<void> _handleThemeChange(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('darkMode', value);
//     setState(() {
//       _isDarkMode = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
//       home: BottomNavScreen(
//         isDarkMode: _isDarkMode,
//         onThemeChanged: _handleThemeChange,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'bottom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('expenseBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isDarkMode = false;

  void handleThemeChange(bool value) {
    setState(() {
      isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,

      home: BottomNavScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: handleThemeChange,
      ),
    );
  }
} 