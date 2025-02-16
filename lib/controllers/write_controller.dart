import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/customer.dart';
import 'package:zkeep/models/report.dart';
import 'package:zkeep/models/user.dart';

class WriteController extends GetxController {
  final _period = 0.obs;
  final _ordinal = 0.obs;
  final _date = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, DateTime.now().hour + 1, 0)
      .obs;

  final _time = TimeOfDay.now().obs;

  final name = TextEditingController();

  static get userId => LocalStorage('login.json').getItem('user')['id'];

  int get period => _period.value;
  set period(int value) => _period.value = value;
  int get ordinal => _ordinal.value;
  set ordinal(int value) => _ordinal.value = value;

  DateTime get date => _date.value;
  set date(DateTime value) => _date.value = value;
  TimeOfDay get time => _time.value;
  set time(TimeOfDay value) => _time.value = value;

  final _search = ''.obs;
  String get search => _search.value;
  set search(String value) => _search.value = value;

  final _customer = ''.obs;
  String get customer => _customer.value;
  set customer(String value) => _customer.value = value;

  final _customerid = 0.obs;
  int get customerid => _customerid.value;
  set customerid(int value) => _customerid.value = value;

  final _buildingid = 0.obs;
  int get buildingid => _buildingid.value;
  set buildingid(int value) => _buildingid.value = value;

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  final _errorCompany = ''.obs;
  String get errorCompany => _errorCompany.value;
  set errorCompany(String value) => _errorCompany.value = value;

  final _errorTitle = ''.obs;
  String get errorTitle => _errorTitle.value;
  set errorTitle(String value) => _errorTitle.value = value;

  @override
  onInit() async {
    super.onInit();

    // items = await BuildingManager.find();
    getBuilding();
  }

  getBuilding() async {
    final res = await CustomerManager.find(params: 'user=$userId');

    if (res.isNotEmpty) {
      items = [];
      for (int i = 0; i < res.length; i++) {
        Building building = Building.fromJson(res[i].extra['building']);
        items.add(building);
      }
    }
  }

  Future<bool> insert() async {
    bool flag = true;

    if (customerid == 0 || buildingid == 0) {
      errorCompany = '점검대상을 선택하세요';
      flag = false;
    }

    if (name.text == '') {
      errorTitle = '점검지명을 입력하세요';
      flag = false;
    }

    if (flag == false) {
      return false;
    }

    final userId = LocalStorage('login.json').getItem('user')['id'];

    final item = Report()
      ..user = User(id: userId)
      ..title = name.text
      ..period = period
      ..number = ordinal
      ..checkdate = DateFormat('yyyy-MM-dd', 'ko_KR').format(date)
      ..checktime = DateFormat('HH:mm', 'ko_KR').format(date)
      // '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'
      ..building = Building(id: buildingid)
      ..company = Company(id: customerid)
      ..status = ReportStatus.newer;

    await ReportManager.insert(item);

    return true;
  }
}
