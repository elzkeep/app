import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zkeep/models/report.dart';

class MypageController extends InfiniteController {
  MypageController()
      : super(
            reader: ReportManager.find,
            params:
                'checkdate=${DateFormat('yyyy-MM-dd').format(DateTime.now())}');

  final _search = 1.obs;
  int get search => _search.value;
  set search(int value) => _search.value = value;

  final _focusedDay = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0)
      .obs;
  DateTime get focusedDay => _focusedDay.value;
  set focusedDay(DateTime value) => _focusedDay.value = value;

  final _calendarFormat = CalendarFormat.month.obs;
  CalendarFormat get calendarFormat => _calendarFormat.value;
  set calendarFormat(CalendarFormat value) => _calendarFormat.value = value;
}
