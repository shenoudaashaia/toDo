import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_update/app_them.dart';
import 'package:to_do_update/auth/user_provider.dart';
import 'package:to_do_update/tabs/settings/seetings_provider.dart';
import 'package:to_do_update/tabs/tasks/task_item.dart';
import 'package:to_do_update/tabs/tasks/taskes_proider.dart';

class TaskTab extends StatefulWidget {
  const TaskTab({super.key});

  @override
  State<TaskTab> createState() => _TaskTabState();
}

class _TaskTabState extends State<TaskTab> {
  bool shoudGetTask = true;
  @override
  Widget build(BuildContext context) {
    TaskesProider taskesProider = Provider.of<TaskesProider>(context);
    double screenHight = MediaQuery.of(context).size.height;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    bool isDark = settingProvider.isDark;

    if (shoudGetTask) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.currentuser != null) {
        final userId = userProvider.currentuser!.id;
        taskesProider.getTasks(userId);
        shoudGetTask = false;
      }
    }

    return Stack(children: [
      Container(
        height: screenHight * 0.17,
        width: double.infinity,
        color: Appthem.primary,
      ),
      PositionedDirectional(
        top: 20,
        start: 20,
        child: Text(
          "hi, ${taskesProider.userName}",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: isDark ? Appthem.black : Appthem.white,
              ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: screenHight * 0.11),
        child: Column(
          children: [
            EasyInfiniteDateTimeLine(
              firstDate: DateTime.now().subtract(Duration(days: 30)),
              focusDate: taskesProider.selectedDate,
              lastDate: DateTime.now().add(Duration(days: 30)),
              showTimelineHeader: false,
              onDateChange: (selectedDate) {
                taskesProider.changeSelectedDate(selectedDate);
                taskesProider.getTasks(
                    Provider.of<UserProvider>(context, listen: false)
                        .currentuser!
                        .id);
              },
              activeColor: Theme.of(context).primaryColor,
              dayProps: EasyDayProps(
                height: 90,
                width: 60,
                dayStructure: DayStructure.dayNumDayStr,
                activeDayStyle: DayStyle(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  dayStrStyle: TextStyle(
                    color: Appthem.primary,
                  ),
                  dayNumStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Appthem.primary,
                  ),
                ),
                inactiveDayStyle: DayStyle(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  dayStrStyle: TextStyle(
                    color: isDark ? Appthem.white : Appthem.black,
                  ),
                  dayNumStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Appthem.white : Appthem.black,
                  ),
                ),
                todayStyle: DayStyle(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  dayStrStyle: TextStyle(
                    color: isDark ? Appthem.white : Appthem.black,
                  ),
                  dayNumStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Appthem.white : Appthem.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemBuilder: (_, index) =>
                    TaskItem(task: taskesProider.tasks[index]),
                itemCount: taskesProider.tasks.length,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
