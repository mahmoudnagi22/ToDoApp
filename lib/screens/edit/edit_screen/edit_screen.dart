import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/colors_manager.dart';
import 'package:to_do_app/core/strings_manager.dart';
import 'package:to_do_app/core/utils/date_utils.dart';
import 'package:to_do_app/database_manager/model/todo_dm.dart';
import 'package:to_do_app/database_manager/model/user_dm.dart';
import 'package:to_do_app/screens/home_screen.dart';
import 'package:to_do_app/screens/taps/taskes_tab/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditScreen extends StatefulWidget {
  final TodoDM? todo;
  const EditScreen({super.key , this.todo});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  GlobalKey<TasksTabState> taskTabKey = GlobalKey();
  var formKey = GlobalKey<FormState>();
  DateTime userSelectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.todo?.title ?? '');
    descriptionController =
        TextEditingController(text: widget.todo?.description ?? '');
    userSelectedDate = widget.todo?.date ?? DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(AppLocalizations.of(context)!.edit_task) ,
      ),
      body: Center(
        child: Form(
           key: formKey,
          child: Container(

            padding: EdgeInsets.all(20),
            width: 352,
            height: 617,
            decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).indicatorColor,
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text( AppLocalizations.of(context)!.edit_task,
                    //"Add New Task",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.enter_task_title;
                    }
                    return null;
                  },
                 controller: titleController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enter_task_title,
                    hintStyle: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.enter_task_description;
                    }
                    return null;
                  },
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.enter_task_description,
                    hintStyle: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.select_date,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      showTaskDatePicker();
                    },
                    child: Text(userSelectedDate.formatDate,
                    //child: Text("24 - 11",
                        //dateFormatter(userSelectedDate),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium)),
                //Spacer(),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () async{
                    // addTodoToFireStore();
                    // widget.todo == null ? addTodoToFireStore() : onReadTask(widget.todo);
                    await onUpdateTask();
                   taskTabKey.currentState?.readToosFromFireStore();
                   // readDataProvider.readTodosFromFirestore();
                  },
                  child: Text( AppLocalizations.of(context)!.save_changed),
                  //child: Text( "Add Task" ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showTaskDatePicker() async {
    userSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        Duration(days: 365),
      ),
    ) ??
        userSelectedDate;
    setState(() {});
  }

  Future onUpdateTask() async {
    if (formKey.currentState?.validate() == false) return;
    await FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.user!.id)
        .collection(TodoDM.collectionName)
        .doc(widget.todo!.id)
        .update({
      'title': titleController.text,
      'description': descriptionController.text,
      'date': userSelectedDate,
      'isDone': widget.todo!.isDone,
    }).then((_) {
      if (mounted) {
        Navigator.pop(context);
      }

      // Navigator.pop(context);
    }).catchError((error) {
      print("Error updating task: $error");
    });
    taskTabKey.currentState?.readToosFromFireStore();
  }
}
