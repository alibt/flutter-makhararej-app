import 'package:flutter/material.dart';
import 'package:makharej_app/features/categories/ui/view/categories_tab.dart';

import 'widgets/charts_tab.dart';
import 'widgets/home_tab.dart';
import 'widgets/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 1;
  void setCurrentTabIndex(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Makharej App"),
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) => setCurrentTabIndex(value),
            currentIndex: _currentTabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "category",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.addchart), label: "charts"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "profile"),
            ]),
        body: getBody(_currentTabIndex),
      ),
    );
  }

  Widget getBody(int index) {
    if (index == 0) {
      return const CategoriesTab();
    }
    if (index == 1) {
      return const HomeTab();
    }
    if (index == 2) {
      return const ChartsTab();
    }
    if (index == 3) return const ProfileTab();

    //it never comes here
    return const Center(child: Text("Unkown State"));
  }
}
