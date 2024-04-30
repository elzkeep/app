import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/models/customer.dart';
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

  final _customerTotal = 0.obs;
  get customerTotal => _customerTotal.value;
  set customerTotal(value) => _customerTotal.value = value;

  final _newcustomerTotal = 0.obs;
  get newcustomerTotal => _newcustomerTotal.value;
  set newcustomerTotal(value) => _newcustomerTotal.value = value;

  final _reportTotal = 0.obs;
  get reportTotal => _reportTotal.value;
  set reportTotal(value) => _reportTotal.value = value;

  final _comReportTotal = 0.obs;
  get comReportTotal => _comReportTotal.value;
  set comReportTotal(value) => _comReportTotal.value = value;

  static get userId => LocalStorage('login.json').getItem('user')['id'];
  static get userScore => LocalStorage('login.json').getItem('user')['score'];

  @override
  onInit() async {
    super.onInit();
    await getCustomerCount();
    // await getNewCustomerCount();
    await getReportCount();
    await getCompleteReportCount();
    customerTotal = userScore.toInt();
  }

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

  getCustomerCount() async {
    final res = await CustomerManager.find(params: 'user=$userId');

    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        newcustomerTotal += res[i].extra['building']['score'].toInt();
        print(newcustomerTotal);
      }
    }
  }

  // getNewCustomerCount() async {
  //   DateTime today = DateTime.now();
  //   DateTime weekago = DateTime(today.year, today.month, today.day - 7);
  //   final res = await CustomerManager.find(
  //       params:
  //           'user=$userId&startdate=${DateFormat('yyyy-MM-dd').format(weekago)}&endcheckdate=${DateFormat('yyyy-MM-dd').format(today)}');

  //   if (res.isNotEmpty) {
  //     // newcustomerTotal = res.length;
  //   }
  // }

  getReportCount() async {
    final res = await ReportManager.find(params: 'user=$userId');

    if (res.isNotEmpty) {
      reportTotal = res.length;
    }
  }

  getCompleteReportCount() async {
    final res = await ReportManager.find(params: 'user=$userId&status=4');

    if (res.isNotEmpty) {
      comReportTotal = res.length;
    }
  }
}
