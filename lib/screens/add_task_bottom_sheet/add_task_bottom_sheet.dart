import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/utils/date_utils.dart';
import 'package:to_do_app/database_manager/model/todo_dm.dart';
import 'package:to_do_app/database_manager/model/user_dm.dart';
import 'package:to_do_app/screens/taps/taskes_tab/tasks_tab.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final TodoDM? todo;
  AddTaskBottomSheet({super.key , required this.todo });
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static Future show(BuildContext context, {TodoDM? todo}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AddTaskBottomSheet(todo:  todo,),
      ),
    );
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime userSelectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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
    return Container(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.todo == null ? "Add New Task" : "Edit Task",
                  //"Add New Task",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return "Plz ,enter Title";
                  }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter task title",
                  hintStyle: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return "Plz ,enter description";
                  }
                  return null;
                },
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Enter task description",
                  hintStyle: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Select date ",
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
                      //dateFormatter(userSelectedDate),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium)),
              //Spacer(),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  // addTodoToFireStore();
                  // widget.todo == null ? addTodoToFireStore() : onReadTask(widget.todo);
                  widget.todo == null
                      ? addTodoToFireStore()
                      : onUpdateTask();

                },
                child: Text(widget.todo == null ? "Add Task" : "Save Changes"),
                //child: Text( "Add Task" ),
              ),
            ],
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

  void addTodoToFireStore() {
    if (formKey.currentState?.validate() == false) return;
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.user!.id)
        .collection(TodoDM.collectionName);
    DocumentReference doc = todoCollection.doc();
    TodoDM todo = TodoDM(
      id: doc.id,
      title: titleController.text,
      description: descriptionController.text,
      date: userSelectedDate,
      isDone: false,
    );
    doc.set(todo.toJson()).then(
      (_) {
       // Navigator.pop(context);
        if (mounted) {
          Navigator.pop(context);
        }
      },
    ).timeout(Duration(milliseconds: 500), onTimeout: () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
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

  void onUpdateTask() async {
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
  }
}
