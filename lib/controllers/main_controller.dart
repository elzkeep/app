import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/models/report.dart';

class MainController extends InfiniteController {
  MainController()
      : super(
            reader: ReportManager.find,
            params:
                'user=$userId&checkdate=${DateFormat('yyyy-MM-dd').format(date)}');

  static final _date = DateTime.now().obs;
  static DateTime get date => _date.value;
  static set date(DateTime value) => _date.value = value;

  static get userId => LocalStorage('login.json').getItem('user')['id'];

  void nextDay() {
    date = date.add(const Duration(days: 1));
    params = 'user=$userId&checkdate=${DateFormat('yyyy-MM-dd').format(date)}';
    reset();
  }

  void beforeDay() {
    date = date.subtract(const Duration(days: 1));
    params = 'user=$userId&checkdate=${DateFormat('yyyy-MM-dd').format(date)}';
    reset();
  }
}
