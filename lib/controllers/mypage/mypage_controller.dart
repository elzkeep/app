import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/customer.dart';
import 'package:zkeep/models/department.dart';
import 'package:zkeep/models/license.dart';
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

  final _company = Company().obs;
  get company => _company.value;
  set company(value) => _company.value = value;

  final _department = Department().obs;
  get department => _department.value;
  set department(value) => _department.value = value;

  final _license = [].obs;
  get license => _license;
  set license(value) => _license.value = value;

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

  final _customerTotal = 0.obs;
  get customerTotal => _customerTotal.value;
  set customerTotal(value) => _customerTotal.value = value;

  final _score = 0.0.obs;
  get score => _score.value;
  set score(value) => _score.value = value;

  @override
  onInit() async {
    super.onInit();
    await getCompany();
    await getDepartment();
    await getLicense();
    await getMonth(focusedDay);
    await find(focusedDay);
    focusedDay = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 1);
    await getCustomerCount();
    await getBuildingScore();
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

  getCustomerCount() async {
    final res = await CustomerManager.find();

    if (res.isNotEmpty) {
      customerTotal = res.length;
    }
  }

  getBuildingScore() async {
    final res = await BuildingManager.find();

    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        score += res[i].score;
      }
    }
  }

  getCompany() async {
    final res = await CompanyManager.get(user['company']);

    company = res;
  }

  getDepartment() async {
    final res = await DepartmentManager.get(user['department']);

    department = res;
  }

  getLicense() async {
    final res = await LicenseManager.find(params: 'user=${user['id']}');

    license = res;
  }
}
