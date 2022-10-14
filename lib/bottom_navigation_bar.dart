import 'package:flutter/material.dart';
import 'package:road_app/screens/create_report.dart';
import './screens/home.dart';
// import './screens/feed_screen.dart';
class NavigationFile extends StatefulWidget {
  static const routeName = '/navigation-file';

  @override
  _NavigationFileState createState() => _NavigationFileState();
}

class _NavigationFileState extends State<NavigationFile> {
  int _selectedIndex = 0;

  @override
  void initState() {}

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Different pages to navigate to
  final List<Widget> _children = [
    const HomePage(),
    CreatePost(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 208, 238, 17),
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.track_changes_outlined),
          //   label: 'Track progress',
          // ),

          // BottomNavigationBarItem(
          //   activeIcon: Icon(Icons.bookmark),
          //   icon: Icon(Icons.bookmark_border_outlined),
          //   label: 'Bookmark',
          // ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home_rounded),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.report_problem_rounded),
            icon: Icon(Icons.favorite_border_rounded),
            label: 'Report',
          ),

          // BottomNavigationBarItem(
          //   activeIcon: Icon(Icons.settings_rounded),
          //   icon: Icon(Icons.settings_outlined),
          //   label: 'Settings',
          // ),
        ],
      ),
    );
  }
}
