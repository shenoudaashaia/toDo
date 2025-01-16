import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do_update/app_them.dart';
import 'package:to_do_update/auth/user_provider.dart';
import 'package:to_do_update/firebase_function.dart';
import 'package:to_do_update/models/task_model.dart';
import 'package:to_do_update/tabs/settings/seetings_provider.dart';
import 'package:to_do_update/tabs/tasks/taskes_proider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;

  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    TaskesProider taskesProider =
        Provider.of<TaskesProider>(context, listen: false);

    bool isDark = settingProvider.isDark;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                final userId = Provider.of<UserProvider>(context, listen: false)
                    .currentuser!
                    .id;
                FirebaseFunction.deleteTaskFromFirestore(widget.task.id, userId)
                    .then(
                  (_) {
                    Provider.of<TaskesProider>(context, listen: false)
                        .getTasks(userId);
                  },
                ).catchError(
                  (error) {
                    Fluttertoast.showToast(
                      msg: "task error",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                    );
                  },
                );
              },
              backgroundColor: Appthem.red,
              foregroundColor: Appthem.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? Appthem.grey : Appthem.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                height: 72,
                width: 4,
                color: widget.task.isDane ? Appthem.green : Appthem.primary,
                margin: EdgeInsetsDirectional.only(end: 8),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: widget.task.isDane
                        ? theme.textTheme.titleMedium
                            ?.copyWith(color: Appthem.green)
                        : theme.textTheme.titleMedium
                            ?.copyWith(color: Appthem.primary),
                  ),
                  Text(
                    widget.task.description,
                    style: widget.task.isDane
                        ? theme.textTheme.titleSmall
                            ?.copyWith(color: Appthem.green)
                        : theme.textTheme.titleSmall
                            ?.copyWith(color: Appthem.primary),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Provider.of<TaskesProider>(context, listen: false)
                      .changeColor(widget.task.id);
                  taskesProider.updateTaskToDone(widget.task,Provider.of<UserProvider>(context, listen: false)
                      .currentuser!.id);
                  taskesProider.getUserName();
                  if (widget.task.isDane) {
                    showSupport();
                  }
                },
                child: widget.task.isDane
                    ? Text(
                        AppLocalizations.of(context)!.done,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Appthem.green,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: widget.task.isDane
                              ? Appthem.green
                              : Appthem.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 34,
                        width: 69,
                        child: Icon(
                          Icons.check,
                          color: Appthem.white,
                          size: 32,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showSupport() {
    String? userName =
        Provider.of<TaskesProider>(context, listen: false).userName;
    Fluttertoast.showToast(
        msg: "😍استمر ${userName} عاش يا",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Appthem.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
