import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:instrument_scheduler_flutter/filtered_calender.dart';

import 'package:calendar_view/calendar_view.dart';
import 'package:instrument_scheduler_flutter/user_setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "schedule_provider.dart";

var event_controller = EventController();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: event_controller,
      child: MaterialApp(
        title: 'Serverpod Demo',
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
        home: const MyHomePage(title: 'Serverpod Example'),
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

  int selected_page = 0;

  final List<List<int>> instrument_ids = [
    [1, 2, 3, 4, 5],
    [1],
    [2],
    [3],
    [4],
    [5],
  ];

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
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
              DrawerHeader(
                child: Text('Serverpod Example'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ] +
            instrument_ids
                .asMap()
                .entries
                .map((entry) => ListTile(
                      title: Text('Instrument ${entry.key + 1}'),
                      onTap: () {
                        setState(() {
                          selected_page = entry.key;
                        });
                      },
                    ))
                .toList(),
      )),
      body: Row(children: [
        Expanded(
          child: FilteredCalender(instrument_ids[selected_page]),
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () {
        //for debugging
        removeAllSchedules();
      }),
    );
  }
}
