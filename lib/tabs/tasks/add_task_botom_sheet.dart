import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_update/app_them.dart';
import 'package:to_do_update/auth/user_provider.dart';
import 'package:to_do_update/firebase_function.dart';
import 'package:to_do_update/models/task_model.dart';
import 'package:to_do_update/tabs/settings/seetings_provider.dart';
import 'package:to_do_update/tabs/tasks/default_elevated_bottom.dart';
import 'package:to_do_update/tabs/tasks/default_text_from_field.dart';
import 'package:to_do_update/tabs/tasks/taskes_proider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTeskBottomSheetState();
}

class _AddTeskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  GlobalKey<FormState> formKay = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    bool isDark = settingProvider.isDark;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        color: isDark ? Appthem.grey : Appthem.white,
        height: MediaQuery.of(context).size.height * 0.55,
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKay,
          child: Column(
            children: [
              Text(
                appLocalizations.addNewTask,
                style: textTheme.titleMedium,
              ),
              SizedBox(
                height: 8,
              ),
              DefaultTextFromField(
                controller: titleController,
                hintText: appLocalizations.title,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "title can not be empty ";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 8,
              ),
              DefaultTextFromField(
                controller: descriptionController,
                hintText: appLocalizations.description,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "title can not be empty ";
                  }
                  return null;
                },
                maxLines: 3,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                appLocalizations.selectDate,
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () async {
                  DateTime? dateTime = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    initialDate: selectedDate,
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
                  );
                  if (dateTime != null) {
                    selectedDate = dateTime;
                    setState(() {});
                  }
                },
                child: Text(
                  dateFormat.format(selectedDate),
                  style: textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              DefaultElevatedBottom(
                lable: appLocalizations.submit,
                onPressed: () {
                  if (formKay.currentState!.validate()) {
                    addTask();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() {
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentuser!.id;
    FirebaseFunction.addTaskToFirestore(
      TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate,
      ),
      userId,
    ).then(
      (_) {
        Navigator.of(context).pop();
        Provider.of<TaskesProider>(context, listen: false).getTasks(userId);
        Fluttertoast.showToast(
            msg: "task aded sucssesfuly",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Appthem.green,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    ).catchError(
      (error) {
        Fluttertoast.showToast(
            msg: "task error",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Appthem.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
  }
}
