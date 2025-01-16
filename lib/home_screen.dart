import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_update/app_them.dart';
import 'package:to_do_update/tabs/settings/seetings_provider.dart';
import 'package:to_do_update/tabs/settings/settings_tab.dart';
import 'package:to_do_update/tabs/tasks/add_task_botom_sheet.dart';
import 'package:to_do_update/tabs/tasks/task_tab.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTabIndex = 0;
  List<Widget> tabs = [TaskTab(), settingsTab()];

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    bool isDark = settingProvider.isDark;

    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Appthem.white,
        child: BottomNavigationBar(
          currentIndex: currentTabIndex,
          onTap: (index) => setState(() {
            currentTabIndex = index;
          }),
          items: [
            BottomNavigationBarItem(
              label: "tasks",
              icon: Icon(
                Icons.list,
                color: isDark ? Appthem.white : Appthem.black,
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              label: "settings",
              icon: Icon(
                Icons.settings_outlined,
                color: isDark ? Appthem.white : Appthem.black,
                size: 32,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => AddTaskBottomSheet(),
        ),
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
