import 'package:flutter/material.dart';
import 'package:studysquad/features/home/screens/home_screen.dart';
import 'package:studysquad/features/profile/screens/profile_screen.dart';
import 'package:studysquad/features/rooms/screens/room_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final _navigationKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTap(int index) {
    if (index == _currentIndex) {
      _navigationKeys[index].currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(int index, Widget child) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigationKeys[index],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigationKeys[_currentIndex]
            .currentState!
            .maybePop();

        if (isFirstRouteInCurrentTab) {
          if (_currentIndex != 0) {
            setState(() {
              _currentIndex = 0;
            });
            return false;
          }
          return true;
        }
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator(0, const HomeScreen()),
            _buildOffstageNavigator(1, const RoomScreen()),
            _buildOffstageNavigator(2, const ProfileScreen()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: "Rooms"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
