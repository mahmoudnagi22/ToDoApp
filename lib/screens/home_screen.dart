import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/colors_manager.dart';
import 'package:to_do_app/presentation/auth/login/login_screen.dart';
import 'package:to_do_app/screens/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:to_do_app/screens/taps/settings_tab/settings_tab.dart';
import 'package:to_do_app/screens/taps/taskes_tab/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedindex = 0;

GlobalKey<TasksTabState> taskesTabKey = GlobalKey();
  List<Widget> tabs =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = [
      TasksTab(key: taskesTabKey,),
      SettingsTab(),
    ];

  }

  @override
  Widget build(BuildContext context) {
    final appBarTitele = selectedindex == 0 ? AppLocalizations.of(context)!.todo_List : AppLocalizations.of(context)!.settings;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title:  Text(appBarTitele),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder:(_)=> LoginScreen()));
              },
                child: Icon(Icons.logout)),
          )
        ],
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
      await AddTaskBottomSheet.show(context );
     taskesTabKey.currentState?.readToosFromFireStore();
    },
    child:const Icon(Icons.add_task),
  );
  Widget buildBottomVavBar() => BottomNavigationBar(

      currentIndex: selectedindex,
      onTap: (index) {
        setState(() {
          selectedindex = index;
        });
      },
      items:  [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label:AppLocalizations.of(context)!.tasks,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label:AppLocalizations.of(context)!.settings,
        ),
      ]);
}
