import 'package:flutter/material.dart';
import 'package:project_bab/sub/DbGet.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:project_bab/widgets/app_large_text.dart';
import 'package:project_bab/widgets/app_text.dart';

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

  Map<DateTime, List<Map<String, String>>> _scheduleData = {};

  @override
  void initState() {
    super.initState();
  }

  Map<DateTime, List<Map<String, String>>> _convertToDateTimeKeyMap(
      Map<String, List<Map<String, String>>> data,
      ) {
    final convertedMap = <DateTime, List<Map<String, String>>>{};
    data.forEach((key, value) {
      final parts = key.split("-");
      final year = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final day = int.tryParse(parts[2]);
      if (year != null && month != null && day != null) {
        final dateTime = DateTime(year, month, day);
        convertedMap[dateTime] = value;
      } else {
        print("Invalid date: $key");
      }
    });
    return convertedMap;
  }


  Future<Map<String, List<Map<String, String>>>> getFutureData() async {
    Map<String, List<Map<String, String>>> ret = {};
    try {
      final List<Map<String, dynamic>> matchList = await getMatched();
      for (var mapItem in matchList) {
        if (mapItem.containsKey('otherid') &&
            mapItem.containsKey('timestamp')) {
          List<String> parts = mapItem['timestamp'].split(" ");
          String dateOnly = parts[0];
          String hmOnly = parts[1];

          final String? otherNickname =
          await getUserInfo('nickname', mapItem['otherid']);
          if (otherNickname != null) {
            final String customHM = " (${hmOnly})";
            if (ret.containsKey(dateOnly)) {
              ret[dateOnly]!.add({
                'content': otherNickname + customHM,
                'time': hmOnly,
                'date': dateOnly,
              });
            } else {
              ret[dateOnly] = [
                {
                  'content': otherNickname + customHM,
                  'time': hmOnly,
                  'date': dateOnly,
                }
              ];
            }
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return ret;
  }

  List<Map<String, String>> getMonthSchedules(DateTime month) {
    final monthStart = DateTime(month.year, month.month);
    final monthEnd = DateTime(month.year, month.month + 1, 0);
    final schedules = <Map<String, String>>[];

    for (var day = monthStart; day.isBefore(monthEnd); day = day.add(const Duration(days: 1))) {
      final dayWithoutTime = DateTime(day.year, day.month, day.day);
      if (_scheduleData.containsKey(dayWithoutTime)) {
        schedules.addAll(_scheduleData[dayWithoutTime]!);
      }
    }

    return schedules;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFutureData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final scheduleData =
        snapshot.data as Map<String, List<Map<String, String>>>;
        _scheduleData = _convertToDateTimeKeyMap(scheduleData);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TableCalendar(
              headerStyle: HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false, // "2 weeks" 버튼 숨기기
              ),
              firstDay: DateTime.utc(DateTime.now().year - 1, 1, 1),
              lastDay: DateTime.utc(DateTime.now().year + 1, 12, 31),
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                final dayWithoutTime = DateTime(day.year, day.month, day.day);
                final isSelectedDay = _scheduleData.containsKey(dayWithoutTime);
                if (isSelectedDay) {
                  _selectedDay = dayWithoutTime;
                }
                return isSelectedDay;
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
                        final content = schedule['content'];
                        final date = schedule['date'];

                        return ListTile(
                          title: Text('$date $content'),
                        );
                      },
                    );
                  } else {
                    final monthSchedules = getMonthSchedules(_focusedDay);
                    if (monthSchedules.isEmpty) {
                      return Center(
                        child: Text(
                          '해당 달에 약속이 없습니다.',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: monthSchedules.length,
                      itemBuilder: (context, index) {
                        final schedule = monthSchedules[index];
                        final content = schedule['content'];
                        final date = schedule['date'];

                        return ListTile(
                          title: Text('$date $content'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
