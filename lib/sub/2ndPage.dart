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
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SecondApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('달력'),
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


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TableCalendar(
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronVisible: false,
            rightChevronVisible: false,
            ),
          firstDay: DateTime(2023, 6, 1),
          lastDay: DateTime(2024, 12, 31),
          calendarFormat: _calendarFormat,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
        ),
        SizedBox(height: 20),
        Text(
          _selectedDay != null
              ? DateFormat.yMMMMd().format(_selectedDay!)
              : '날짜를 선택하세요.',
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}



