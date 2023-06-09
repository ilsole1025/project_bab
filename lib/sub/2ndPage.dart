/*import 'package:flutter/material.dart';

class SecondApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : Container(
        child: Center(
          child: Text('두 번째 페이지'),
        ),
      ),
    );
  }
}
*/
/*
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SecondApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'img/blacklogo.png',
              width: 90,
              height: 90,
            ),
          ],
        ),
      ),
      body: Center(
        child: CalendarWidget(),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool isSameDayIgnoreTime(DateTime? dayA, DateTime? dayB) {
    if (dayA == null || dayB == null) return false;
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  Map<DateTime, List<String>> _scheduleData = {
    DateTime(2023, 6, 1): ['닉네임1 (12:00 PM)', '닉네임2 (6:00 PM)'],
    DateTime(2023, 6, 3): ['닉네임3 (3:00 PM)'],
    DateTime(2023, 6, 5): ['닉네임4 (10:00 AM)', '닉네임5 (2:00 PM)'],
    DateTime(2023, 6, 9): ['닉니임 (11:00 PM)'],
    DateTime(2023, 6, 21): ['닉sp임 (11:00 PM)'],
    DateTime(2023, 7, 9): ['닉니임 (11:00 PM)'],
  };

  List<String> getMonthSchedules(DateTime month) {
    final monthStart = DateTime(month.year, month.month);
    final monthEnd = DateTime(month.year, month.month + 1, 0);
    final schedules = <String>[];

    for (var day = monthStart; day.isBefore(monthEnd); day = day.add(const Duration(days: 1))) {
      if (_scheduleData.containsKey(day)) {
        schedules.addAll(_scheduleData[day]!);
      }
    }

    return schedules;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    TableCalendar(
    headerStyle: HeaderStyle(
    formatButtonVisible: false,
      leftChevronIcon: Icon(Icons.chevron_left),
      rightChevronIcon: Icon(Icons.chevron_right),
      titleCentered: true,
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      formatButtonDecoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    calendarStyle: CalendarStyle(
    todayDecoration: BoxDecoration(
    color: Colors.blue.withOpacity(0.5),
    shape: BoxShape.circle,
    ),
    selectedDecoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: Colors.blue, width: 2.0),
    ),
    selectedTextStyle: TextStyle(color: Colors.black),
    ),
    firstDay: DateTime(2023, 6, 1),
    lastDay: DateTime(2024, 12, 31),
    calendarFormat: _calendarFormat,
    focusedDay: _focusedDay,
    selectedDayPredicate: (day) {
    final dayWithoutTime = DateTime(day.year, day.month, day.day);
    return _scheduleData.containsKey(dayWithoutTime);
    },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
    ),
        SizedBox(height: 20),
        Expanded(
          child: Builder(
            builder: (context) {
              if (_selectedDay != null &&
                  _scheduleData.containsKey(_selectedDay!)) {
                final schedules = _scheduleData[_selectedDay!];
                return ListView.builder(
                  itemCount: schedules!.length,
                  itemBuilder: (context, index) {
                    final schedule = schedules![index];
                    return ListTile(
                      title: Text(schedule),
                    );
                  },
                );
              } else {
                final allSchedules = _scheduleData.values.expand((x) => x).toList();
                return ListView.builder(
                  itemCount: allSchedules.length,
                  itemBuilder: (context, index) {
                    final schedule = allSchedules[index];
                    return ListTile(
                      title: Text(schedule),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

 */
/*
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SecondApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'img/blacklogo.png',
              width: 90,
              height: 90,
            ),
          ],
        ),
      ),
      body: Center(
        child: CalendarWidget(),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool isSameDayIgnoreTime(DateTime? dayA, DateTime? dayB) {
    if (dayA == null || dayB == null) return false;
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  Map<DateTime, List<String>> _scheduleData = {
    DateTime(2023, 6, 1): ['닉네임1 (12:00 PM)', '닉네임2 (6:00 PM)'],
    DateTime(2023, 6, 3): ['닉네임3 (3:00 PM)'],
    DateTime(2023, 6, 5): ['닉네임4 (10:00 AM)', '닉네임5 (2:00 PM)'],
    DateTime(2023, 6, 9): ['닉니임 (11:00 PM)'],
    DateTime(2023, 6, 21): ['닉sp임 (11:00 PM)'],
    DateTime(2023, 7, 9): ['닉니임 (11:00 PM)'],
  };

  List<String> getMonthSchedules(DateTime month) {
    final monthStart = DateTime(month.year, month.month);
    final monthEnd = DateTime(month.year, month.month + 1, 0);
    final schedules = <String>[];

    for (var day = monthStart; day.isBefore(monthEnd); day = day.add(const Duration(days: 1))) {
      if (_scheduleData.containsKey(day)) {
        schedules.addAll(_scheduleData[day]!);
      }
    }

    return schedules;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    TableCalendar(
    headerStyle: HeaderStyle(
    formatButtonVisible: false,
      leftChevronIcon: Icon(Icons.chevron_left),
      rightChevronIcon: Icon(Icons.chevron_right),
      titleCentered: true,
      titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      formatButtonDecoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    calendarStyle: CalendarStyle(
    todayDecoration: BoxDecoration(
    color: Colors.blue.withOpacity(0.5),
    shape: BoxShape.circle,
    ),
    selectedDecoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: Colors.blue, width: 2.0),
    ),
    selectedTextStyle: TextStyle(color: Colors.black),
    ),
    firstDay: DateTime(2023, 6, 1),
    lastDay: DateTime(2024, 12, 31),
      calendarFormat: _calendarFormat,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        final dayWithoutTime = DateTime(day.year, day.month, day.day);
        return _scheduleData.containsKey(dayWithoutTime);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
    ),
        SizedBox(height: 20),
        Expanded(
          child: Builder(
            builder: (context) {
              if (_selectedDay != null &&
                  _scheduleData.containsKey(_selectedDay!)) {
    final schedules = _scheduleData[_selectedDay!];
    return ListView.builder(
    itemCount: schedules!.length,
    itemBuilder: (context, index) {
    final schedule = schedules![index];
    final scheduleParts = schedule.split(' ');
    final nickname = scheduleParts[0];
    final time = scheduleParts[1];
    return ListTile(
    title: Text(
    '${DateFormat('MM/dd').format(_selectedDay!)} $nickname $time',
    ),
    );
    },
    );
    } else if (_selectedDay == null) {
                return Container();
              } else {
                final allSchedules = _scheduleData.values.expand((x) => x).toList();
                return ListView.builder(
                  itemCount: allSchedules.length,
                  itemBuilder: (context, index) {
                    final schedule = allSchedules[index];
                    final scheduleParts = schedule.split(' ');
                    final nickname = scheduleParts[0];
                    final time = scheduleParts[1];
                    return ListTile(
                      title: Text(
                        '${DateFormat('MM/dd').format(_selectedDay!)} $nickname $time',
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
*/

/*import 'package:flutter/material.dart';

class SecondApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : Container(
        child: Center(
          child: Text('두 번째 페이지'),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SecondApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'img/blacklogo.png',
              width: 90,
              height: 90,
            ),
          ],
        ),
      ),
      body: Center(
        child: CalendarWidget(),
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool isSameDayIgnoreTime(DateTime? dayA, DateTime? dayB) {
    if (dayA == null || dayB == null) return false;
    return dayA.year == dayB.year &&
        dayA.month == dayB.month &&
        dayA.day == dayB.day;
  }

  Map<DateTime, List<String>> _scheduleData = {
    DateTime(2023, 6, 1): ['닉네임1 (12:00 PM)', '닉네임2 (6:00 PM)'],
    DateTime(2023, 6, 3): ['닉네임3 (3:00 PM)'],
    DateTime(2023, 6, 5): ['닉네임4 (10:00 AM)', '닉네임5 (2:00 PM)'],
    DateTime(2023, 6, 9): ['닉니임 (11:00 PM)'],
    DateTime(2023, 6, 21): ['닉sp임 (11:00 PM)'],
    DateTime(2023, 7, 9): ['닉니임 (11:00 PM)'],
  };

  List<String> getMonthSchedules(DateTime month) {
    final monthStart = DateTime(month.year, month.month);
    final monthEnd = DateTime(month.year, month.month + 1, 0);
    final schedules = <String>[];

    for (var day = monthStart; day.isBefore(monthEnd); day = day.add(const Duration(days: 1))) {
      if (_scheduleData.containsKey(day)) {
        schedules.addAll(_scheduleData[day]!);
      }
    }

    return schedules;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TableCalendar(
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            leftChevronIcon: Icon(Icons.chevron_left),
            rightChevronIcon: Icon(Icons.chevron_right),
            titleCentered: true,
            titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            formatButtonDecoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2.0),
            ),
            selectedTextStyle: TextStyle(color: Colors.black),
          ),
          firstDay: DateTime(2023, 6, 1),
          lastDay: DateTime(2024, 12, 31),
          calendarFormat: _calendarFormat,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            final dayWithoutTime = DateTime(day.year, day.month, day.day);
            return _scheduleData.containsKey(dayWithoutTime);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
        ),
        SizedBox(height: 20),
        Expanded(
          child: Builder(
            builder: (context) {
              if (_selectedDay != null &&
                  _scheduleData.containsKey(_selectedDay!)) {
                final schedules = _scheduleData[_selectedDay!];
                return ListView.builder(
                  itemCount: schedules!.length,
                  itemBuilder: (context, index) {
                    final schedule = schedules![index];
                    return ListTile(
                      title: Text(schedule),
                    );
                  },
                );
              } else {
                final allSchedules = _scheduleData.values.expand((x) => x).toList();
                return ListView.builder(
                  itemCount: allSchedules.length,
                  itemBuilder: (context, index) {
                    final schedule = allSchedules[index];
                    return ListTile(
                      title: Text(schedule),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}



