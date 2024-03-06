import 'package:common_control/common_control.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zkeep/config/config.dart';

class CTableCalendar extends CWidget {
  CTableCalendar(
      {super.key,
      required this.focusedDay,
      required this.events,
      required this.calendarFormat,
      this.availableCalendarFormats = const {CalendarFormat.month: 'Month'},
      this.onFormatChanged,
      required this.onDaySelected,
      required this.onPageChanged,
      required this.getMonth});

  final DateTime focusedDay;
  final Map events;
  final CalendarFormat calendarFormat;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final Function(CalendarFormat)? onFormatChanged;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(DateTime) onPageChanged;
  final Function getMonth;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onFormatChanged: onFormatChanged,
      onDaySelected: onDaySelected,
      onPageChanged: onPageChanged,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: focusedDay,
      calendarFormat: calendarFormat,
      locale: 'ko_KR',
      daysOfWeekHeight: 30,
      rowHeight: 35,
      availableGestures: AvailableGestures.none,
      availableCalendarFormats: availableCalendarFormats,
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
        disabledTextStyle: TextStyle(color: Color(0xFFBFBFBF)),
      ),
      eventLoader: (day) {
        return events[day] ?? [];
      },
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          if (day.weekday == DateTime.sunday) {
            return CText(
              '일',
              alignment: Alignment.center,
              textStyle: const TextStyle(color: Colors.red),
            );
          }
          if (day.weekday == DateTime.saturday) {
            return CText(
              '토',
              alignment: Alignment.center,
              textStyle: const TextStyle(color: Colors.blue),
            );
          }
          return null;
        },
        markerBuilder: (context, day, events) {
          if (events.isNotEmpty) {
            return Container(
              margin: const EdgeInsets.only(top: 25),
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Config.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }
          return null;
        },
        todayBuilder: (context, day, selectedDay) {
          return CContainer(
            width: 40,
            height: 40,
            decoration: day == selectedDay
                ? const BoxDecoration(
                    color: Config.primaryColor, shape: BoxShape.circle)
                : null,
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CContainer(
                  height: 36,
                  child: CText(
                    alignment: Alignment.center,
                    day.day.toString(),
                    textStyle: day == selectedDay
                        ? const TextStyle(color: Colors.white)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 22,
                  child: CText(
                    '오늘',
                    textStyle: day == selectedDay
                        ? const TextStyle(fontSize: 8, color: Colors.white)
                        : const TextStyle(fontSize: 8),
                  ),
                ),
              ],
            ),
          );
        },
        defaultBuilder: (context, day, focusedDays) {
          if (day == focusedDay) {
            return CContainer(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  color: Config.primaryColor, shape: BoxShape.circle),
              child: CText(
                alignment: Alignment.center,
                day.day.toString(),
                textStyle: const TextStyle(color: Colors.white),
              ),
            );
          }
          if (day.weekday == DateTime.sunday) {
            return CText(
              alignment: Alignment.center,
              day.day.toString(),
              textStyle: const TextStyle(color: Colors.red),
            );
          }
          if (day.weekday == DateTime.saturday) {
            return CText(
              alignment: Alignment.center,
              day.day.toString(),
              textStyle: const TextStyle(color: Colors.blue),
            );
          }
          return null;
        },
      ),
    );
  }
}
