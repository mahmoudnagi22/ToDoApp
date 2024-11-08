import 'package:flutter/material.dart';
import 'package:to_do_app/core/colors_manager.dart';
import 'package:to_do_app/screens/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:to_do_app/screens/taps/settings_tab/settings_tab.dart';
import 'package:to_do_app/screens/taps/taskes_tab/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex = 0;
String appBarTitele= "ToDo List";
GlobalKey<TasksTabState> taskesTabKey = GlobalKey();
  List<Widget> tabs =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = [
      TasksTab(key:   taskesTabKey,),
      SettingsTab(),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title:  Text(appBarTitele),
      ),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        child:buildBottomVavBar()
      ),
      body: tabs[selectedindex],
    );
  }
  Widget buildFab() =>  FloatingActionButton(

    onPressed: ()  async{
     await AddTaskBottomSheet.show(context);
     taskesTabKey.currentState?.readToosFromFireStore();
    },
    child:const Icon(Icons.add_task),
  );
  Widget buildBottomVavBar() => BottomNavigationBar(

      currentIndex: selectedindex,
      onTap: (index) {
        setState(() {
          selectedindex = index;
          if(index == 0 ){
            appBarTitele = "ToDo List";
          }else{
            appBarTitele = "Settings";  // Update app bar title when navigating to settings tab  // TODO: Implement settings screen to update this title when necessary  // Example:

          }
        });
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
      ]);
}
