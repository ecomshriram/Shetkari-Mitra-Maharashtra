import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/downloads_screen.dart';
import 'screens/bookmarks_screen.dart';
import 'screens/settings_screen.dart';
import 'widgets/bottom_nav.dart';

class ShetkariApp extends StatefulWidget {
  @override
  State<ShetkariApp> createState() => _ShetkariAppState();
}

class _ShetkariAppState extends State<ShetkariApp> {
  int _currentIndex = 0;
  final _screens = [
    HomeScreen(),
    DownloadsScreen(),
    BookmarksScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shetkari Mitra',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          color: Colors.green.shade800,
          elevation: 0,
        ),
      ),
      home: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNav(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }
}
