import 'package:flutter/material.dart';
import 'package:to_do_update/app_them.dart';
import 'package:to_do_update/firebase_function.dart';
import 'package:to_do_update/models/task_model.dart';

class TaskesProider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();
  Color colorPrimary = Appthem.primary;
  String? userName="";
  
  Future<void> getTasks(String userId) async {
    List<TaskModel> allTasks =
        await FirebaseFunction.getAllTaskFromFirestore(userId);
    tasks = allTasks
        .where(
          (task) =>
              task.date.day == selectedDate.day &&
              task.date.month == selectedDate.month &&
              task.date.year == selectedDate.year,
        )
        .toList();

    notifyListeners();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  getUserName() async {
    String? fetchUserName = await FirebaseFunction.fetchUserName();
    if(fetchUserName !=null){
      userName=fetchUserName;
    }
    notifyListeners();
  }

  updateTaskToDone(TaskModel task, String uid)async{
  await FirebaseFunction.updateTaskInfirebase(task, uid);
  getTasks(uid);
  notifyListeners();
  }

  changeColor(String taskId) {
    final task = tasks.firstWhere((task) => task.id == taskId);
    task.isDane = !task.isDane;
    notifyListeners();
  }
}
