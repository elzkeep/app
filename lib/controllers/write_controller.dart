import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

class WriteController extends GetxController {
  final _period = 0.obs;
  final _ordinal = 0.obs;
  final _date = DateTime.now().obs;
  final _time = TimeOfDay.now().obs;

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

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  @override
  onInit() async {
    super.onInit();

    print('read');
    items = await CompanyManager.find();
    print(items);
  }

  insert() async {

    await ReportManager.insert(item);
  }
}
