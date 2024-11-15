import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/colors_manager.dart';
import 'package:to_do_app/core/reusable_components/task_item.dart';
import 'package:to_do_app/database_manager/model/todo_dm.dart';
import 'package:to_do_app/database_manager/model/user_dm.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  List<TodoDM> todosList = [];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    readToosFromFireStore();
  }
  @override
  Widget build(BuildContext context) {
    // readToosFromFireStore();
    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              calenderSelectedDate = selectedDate;
               readToosFromFireStore();
              //`selectedDate` the new date selected.
            },
            headerProps: EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              monthStyle: TextStyle(color: Theme.of(context).canvasColor),
              selectedDateStyle:
                  TextStyle(color: Theme.of(context).canvasColor),
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                dayNumStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                dayStrStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff3371FF),
                      Color(0xff8426D6),
                    ],
                  ),
                ),
              ),
              inactiveDayStyle: DayStyle(
                dayNumStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                dayStrStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: ColorsManager.whiteColor

                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     Color(0xff3371FF),
                    //     Color(0xff8426D6),
                    //   ],
                    // ),
                    ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // TaskItem(),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => TaskItem(
              todo: todosList[index],
              onDeletedTask: (){
                readToosFromFireStore();
              },
              onUpdate: (todo){
                readToosFromFireStore();
              },

            ),
            itemCount: todosList.length,
          ))
        ],
      ),
    );
  }

  void readToosFromFireStore() async {
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(UserDM.collectionName).doc(UserDM.user!.id).collection(TodoDM.collectionName);
    QuerySnapshot querySnapshot = await todoCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todosList = documents.map(
      (docSnapshot) {
        Map<String, dynamic> json = docSnapshot.data() as Map<String, dynamic>;
        TodoDM todo = TodoDM.fromJson(json);
        return todo;
      },
    ).toList();
    todosList = todosList
        .where(
          (todo) =>
              todo.date.day == calenderSelectedDate.day &&
              todo.date.month == calenderSelectedDate.month &&
              todo.date.year == calenderSelectedDate.year,
        )
        .toList();
    setState(() {});
  }
}
