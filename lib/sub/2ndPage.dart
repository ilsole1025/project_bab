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
import 'package:project_bab/sub/DbGet.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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

  Map<String, List<String>> _scheduleData = {};
  /// TODO : Map<Datetime,List<String>> 에서 위처럼 형식 수정함. 데이터 표시 관련해서 수정 필요
  /*
  Map<DateTime, List<String>> _scheduleData = {
    DateTime(2023, 6, 1): ['닉네임1 (12:00 PM)', '닉네임2 (6:00 PM)'],
    DateTime(2023, 6, 3): ['닉네임3 (3:00 PM)'],
    DateTime(2023, 6, 5): ['닉네임4 (10:00 AM)', '닉네임5 (2:00 PM)'],
    DateTime(2023, 6, 9): ['닉니임 (11:00 PM)'],
    DateTime(2023, 6, 21): ['닉sp임 (11:00 PM)'],
    DateTime(2023, 7, 9): ['닉니임 (11:00 PM)'],
  };
  */

  Future<Map<String, List<String>>> getFutureData() async {
    Map<String, List<String>> ret = {};
    try {
      final List<Map<String, dynamic>> matchList = await getMatched();
      for (var mapItem in matchList) {
        if (mapItem.containsKey('otherid') && mapItem.containsKey('timestamp')) {

          List<String> parts = mapItem['timestamp'].split(" ");
          String dateOnly = parts[0];
          String hmOnly = parts[1];

          final String? otherNickname = await getUserInfo('nickname', mapItem['otherid']);
          if (otherNickname != null) {
            final String customHM = " (${hmOnly})";
            if (ret.containsKey(dateOnly)) {
              ret[dateOnly]!.add(otherNickname + customHM);
            } else {
              ret[dateOnly] = [otherNickname + customHM];
            }
          }
        }
      }
    } catch(e) {
      print(e.toString());
    }
    return ret;
  }

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
    return FutureBuilder(
      future: getFutureData(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        _scheduleData = snapshot.data!; /// getFutureData로 받아온 데이터를 _scheduleData에 저장하고, 그대로 사용하면됨
        return Text(_scheduleData.toString()); /// TODO : 임시
      }
    );
  }


  /// 아래는 오리지널 코드
  /*
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
              border: Border.all(color: Colors.red.shade300, width: 2.0),
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
  }*/
}



