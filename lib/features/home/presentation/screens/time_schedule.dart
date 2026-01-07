import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';

class TimeScheduleScreen extends StatefulWidget {
  const TimeScheduleScreen({super.key});

  @override
  State<TimeScheduleScreen> createState() => _TimeScheduleScreenState();
}

class _TimeScheduleScreenState extends State<TimeScheduleScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.MMMM().format(_focusedDay) + ' ${_focusedDay.year}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                '${_focusedDay.day}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: CalendarFormat.week,
          headerVisible: false,
          calendarStyle: const CalendarStyle(
            markersAlignment: Alignment.bottomCenter,
            markerDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorBlock.accent,
            ),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorBlock.accent,
            ),
          ),
        ),
      ],
    );
  }
}
