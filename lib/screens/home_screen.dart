import 'package:flutter/material.dart';
import 'package:to_do_app/core/colors_manager.dart';
import 'package:to_do_app/screens/taps/settings_tab/settings_tab.dart';
import 'package:to_do_app/screens/taps/taskes_tab/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex = 0;

  List<Widget> tabs = [
    TasksTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {},
        child:const Icon(Icons.add_task),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(

            currentIndex: selectedindex,
            onTap: (index) {
              selectedindex = index;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Tasks",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ]),
      ),
      body: tabs[selectedindex],
    );
  }
}
