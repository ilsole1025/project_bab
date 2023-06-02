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
              ])
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
              formatButtonVisible: false, // 월 헤더의 월 변경 버튼 숨김
              leftChevronIcon: Icon(Icons.chevron_left), // 이전 월로 이동하는 화살표 아이콘
              rightChevronIcon: Icon(Icons.chevron_right), // 다음 월로 이동하는 화살표 아이콘
              titleCentered: true, // 월 헤더의 제목 중앙 정렬
              titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // 월 헤더 제목 스타일
              formatButtonDecoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
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



