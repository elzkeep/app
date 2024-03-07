import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zkeep/models/report.dart';

class MypageController extends GetxController {
  MypageController();

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  final _monthitems = [].obs;
  get monthitems => _monthitems;
  set monthitems(value) => _monthitems.value = value;

  final _search = 1.obs;
  int get search => _search.value;
  set search(int value) => _search.value = value;

  final user = LocalStorage('login.json').getItem('user');
  // User get user => _user.value;
  // set user(User value) => _user.value = value;

  final _focusedDay = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 0)
      .obs;
  DateTime get focusedDay => _focusedDay.value;
  set focusedDay(DateTime value) => _focusedDay.value = value;

  final _calendarFormat = CalendarFormat.month.obs;
  CalendarFormat get calendarFormat => _calendarFormat.value;
  set calendarFormat(CalendarFormat value) => _calendarFormat.value = value;

  final _events = {}.obs;
  get events => _events;
  set events(value) => _events.value = value;

  @override
  onInit() async {
    super.onInit();
    await getMonth(focusedDay);
    await find(focusedDay);
    focusedDay = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 1);
  }

  getMonth(DateTime date) async {
    DateTime firstDayOfMonth = DateTime(date.year, date.month - 1, 22);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 1, 7);

    final ret = await ReportManager.find(
        params:
            'user=${user['id']}&startcheckdate=${DateFormat('yyyy-MM-dd').format(firstDayOfMonth)}&endcheckdate=${DateFormat('yyyy-MM-dd').format(lastDayOfMonth)}');

    monthitems = ret;
    await makeEvents(ret);
  }

  makeEvents(List<Report> data) {
    events = {};
    for (Report item in data) {
      DateTime date =
          DateTime.parse(item.checkdate).add(const Duration(hours: 9)).toUtc();
      if (events[date] == null) {
        events[date] = [item];
      } else {
        events[date].add(item);
      }
    }
  }

  find(DateTime date) async {
    final ret = await ReportManager.find(
        params:
            'user=${user['id']}&startcheckdate=${DateFormat('yyyy-MM-dd').format(date)}&endcheckdate=${DateFormat('yyyy-MM-dd').format(date)}');

    items = ret;
  }
}
