import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/models/report.dart';

class MainController extends InfiniteController {
  MainController()
      : super(
            reader: ReportManager.find,
            params:
                'user=$userId&startcheckdate=${DateFormat('yyyy-MM-dd').format(date)}&endcheckdate=${DateFormat('yyyy-MM-dd').format(date)}');

  static final _date = DateTime.now().obs;
  static DateTime get date => _date.value;
  static set date(DateTime value) => _date.value = value;

  final _monthitems = [].obs;
  get monthitems => _monthitems;
  set monthitems(value) => _monthitems.value = value;

  final _events = {}.obs;
  get events => _events;
  set events(value) => _events.value = value;

  static get userId => LocalStorage('login.json').getItem('user')['id'];

  void nextDay() {
    date = date.add(const Duration(days: 1));
    params =
        'user=$userId&startcheckdate=${DateFormat('yyyy-MM-dd').format(date)}&endcheckdate=${DateFormat('yyyy-MM-dd').format(date)}';
    reset();
  }

  void beforeDay() {
    date = date.subtract(const Duration(days: 1));
    params =
        'user=$userId&startcheckdate=${DateFormat('yyyy-MM-dd').format(date)}&endcheckdate=${DateFormat('yyyy-MM-dd').format(date)}';
    reset();
  }

  getMonth(DateTime date) async {
    DateTime firstDayOfMonth = DateTime(date.year, date.month - 1, 1);
    DateTime lastDayOfMonth = DateTime(date.year, date.month + 2, 0);

    final ret = await ReportManager.find(
        params:
            'user=$userId&startcheckdate=${DateFormat('yyyy-MM-dd').format(firstDayOfMonth)}&endcheckdate=${DateFormat('yyyy-MM-dd').format(lastDayOfMonth)}');

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

  find(DateTime focusedDay) {
    date = focusedDay;
    params =
        'user=$userId&startcheckdate=${DateFormat('yyyy-MM-dd').format(date)}&endcheckdate=${DateFormat('yyyy-MM-dd').format(date)}';
    reset();
  }
}
