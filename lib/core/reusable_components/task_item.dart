import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/core/colors_manager.dart';
import 'package:to_do_app/core/routes_manager.dart';
import 'package:to_do_app/core/utils/date_utils.dart';
import 'package:to_do_app/database_manager/model/todo_dm.dart';
import 'package:to_do_app/database_manager/model/user_dm.dart';
import 'package:to_do_app/screens/add_task_bottom_sheet/add_task_bottom_sheet.dart';
import 'package:to_do_app/screens/edit/edit_screen/edit_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TaskItem extends StatelessWidget {
  Function onDeletedTask;
  Function onUpdate;

  //int index;
   TaskItem({super.key , required  this.todo , required this.onDeletedTask  , required this.onUpdate});
  TodoDM todo;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:Theme.of(context).indicatorColor,
      ),
      margin: EdgeInsets.all(8),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.2,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),

          // A pane can dismiss the Slidable.
          //    Error : dismissible: DismissiblePane(onDismissed: () {}),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              autoClose: true,
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                deletTask();
                onDeletedTask();
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.2,

          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),

          // A pane can dismiss the Slidable.
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              autoClose: true,
              borderRadius: BorderRadius.circular(15),
              flex: 1,
              onPressed: (context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(todo: todo),
                  ),

                );

              },
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  color: Theme.of(context).dividerColor,
                  height: 62,
                  width: 3,
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  children: [
                    Text(
                      todo.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      todo.description,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:  10),
                          child: Icon(Icons.lock_clock ,color: Theme.of(context).canvasColor,),
                        ),
                        Text(
                          '${todo.date.day}/${todo.date.month}/${todo.date.year}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context).canvasColor,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 28,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deletTask()async {
   var tasksCollection = FirebaseFirestore.instance.collection(UserDM.collectionName).doc(UserDM.user!.id).collection(TodoDM.collectionName);
     await tasksCollection.doc(todo.id).delete();
  }
  void onReadTask(TodoDM todo) async {
    var readData = await FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.user!.id)
        .collection(TodoDM.collectionName)
        .get();
    var user = readData.docs.firstWhere((doc) => doc.id == todo.id);
    //onUpdateTask();
    //var user =  readData.docs[todo.id];
    //  print("$index");
    //  print("$end  : <= end");
    print(user['title']);
    print('----------------------------');
    print(user['description']);

  }

}
