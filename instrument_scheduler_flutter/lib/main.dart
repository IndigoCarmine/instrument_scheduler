import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:instrument_scheduler_client/instrument_scheduler_client.dart';
import 'package:instrument_scheduler_flutter/fake_provider.dart';
import 'package:instrument_scheduler_flutter/filtered_calender.dart';

import 'package:calendar_view/calendar_view.dart';
import 'package:instrument_scheduler_flutter/user_setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "schedule_provider.dart";

var event_controller = EventController();

void main() {
  // runApp(ProviderScope(child: MyApp(), overrides: [
  //   scheduleProvider.overrideWith((ref) => FakeScheduleNotifier([]))
  // ]));
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: event_controller,
      child: MaterialApp(
        title: 'Instrument Scheduler',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        scrollBehavior: ScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.trackpad,
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          },
        ),
        home: const MyHomePage(title: 'Instrument Scheduler'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String _userName = '';

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _userName = prefs.getString('userName') ?? '';
      });

      if (_userName.isEmpty) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return UserSettingPage();
        }));
      }
    });
  }

  late List<CalenderSettings> instrument_ids = [
    CalenderSettings("Your reservations", (schedule) {
      return schedule.userName == _userName;
    }, 0),
    CalenderSettings('Instrument 1', idFilter([1]), 1),
    CalenderSettings('Instrument 2', idFilter([2]), 2),
    CalenderSettings('All Instruments', allFilter(), 0),
  ];
  int selected_page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return UserSettingPage();
              }));
            },
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
              DrawerHeader(
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Logged in as $_userName \n Select an instrument")),
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
            ] +
            instrument_ids
                .asMap()
                .entries
                .map((entry) => ListTile(
                      title: Text(entry.value.title),
                      onTap: () {
                        setState(() {
                          selected_page = entry.key;
                        });
                        // Close the drawer
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
      )),
      body: Row(children: [
        Expanded(
          child: FilteredCalender(
              instrument_ids[selected_page].isSelectedSchedule,
              _userName,
              instrument_ids[selected_page].instrumentId),
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () {
        //for debugging
        // removeAllSchedules();

        // final shared_preferences = SharedPreferences.getInstance();
        // shared_preferences.then((prefs) {
        //   prefs.remove('userName');
        // });
      }),
    );
  }
}

class CalenderSettings {
  const CalenderSettings(
      this.title, this.isSelectedSchedule, this.instrumentId);

  final String title;
  final bool Function(Schedule) isSelectedSchedule;
  final int instrumentId;
}
