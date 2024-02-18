import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/facility.dart';

class FacilityInsertController extends GetxController {
  FacilityInsertController(this.id);

  final int id;

  final _item = Facility().obs;
  Facility get item => _item.value;
  set item(Facility value) => _item.value = value;

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  final _transs = [].obs;
  get transs => _transs;
  set transs(value) => _transs.value = value;

  final _highs = [].obs;
  get highs => _highs;
  set highs(value) => _highs.value = value;

  final _installation = false.obs;
  bool get installation => _installation.value;
  set installation(bool value) => _installation.value = value;

  final _typeaaa = 0.obs;
  int get typeaaa => _typeaaa.value;
  set typeaaa(int value) => _typeaaa.value = value;

  final _manufactureYear = 0.obs;
  int get manufactureYear => _manufactureYear.value;
  set manufactureYear(int value) => _manufactureYear.value = value;

  final _highbreaker = 0.obs;
  int get highbreaker => _highbreaker.value;
  set highbreaker(int value) => _highbreaker.value = value;

  final _highbreakeryear = 0.obs;
  int get highbreakeryear => _highbreakeryear.value;
  set highbreakeryear(int value) => _highbreakeryear.value = value;

  final _highbreakermonth = 0.obs;
  int get highbreakermonth => _highbreakermonth.value;
  set highbreakermonth(int value) => _highbreakermonth.value = value;

  final _relay = 0.obs;
  int get relay => _relay.value;
  set relay(int value) => _relay.value = value;

  final _relayconnect = 0.obs;
  int get relayconnect => _relayconnect.value;
  set relayconnect(int value) => _relayconnect.value = value;

  final _changetype = 0.obs;
  int get changetype => _changetype.value;
  set changetype(int value) => _changetype.value = value;

  final _changeyear = 0.obs;
  int get changeyear => _changeyear.value;
  set changeyear(int value) => _changeyear.value = value;

  final _changemonth = 0.obs;
  int get changemonth => _changemonth.value;
  set changemonth(int value) => _changemonth.value = value;

  final types = CItem.list(['', '저압', '특고압']).obs;
  final positions =
      CItem.list(['', '지하', '단독/옥내', '옥상', '옥외', '복도/계단', '현관', '직접입력']).obs;
  final volts = CItem.list(['', '[저압]380/220', '[특고압]22,900']).obs;
  final arrangementtypes = CItem.list(['', '일반형', '일체형']).obs;
  final faces = CItem.list([
    '',
    '1~5',
    '6~10',
    '11~20',
    '21~30',
    '31~40',
    '41~50',
    '51~60',
    '61~70',
    '71~80',
    '81~90',
    '91~100',
    '11~20',
    '101이상',
    '직접입력'
  ]).obs;
  final distributationtypes = CItem.list(['', '매입형', '노출형']).obs;
  final transstypes = CItem.list(['', '유입형', '몰드형']).obs;
  final breakers = CItem.list(['', 'VCB', 'GCV']).obs;
  final relays = CItem.list(['', 'OCR', 'OCGR', 'UVR', 'OVR', 'POR']).obs;

  List<CItem> years = [CItem(id: 0, value: '')].obs;
  List<CItem> months = [CItem(id: 0, value: '')].obs;

  @override
  onInit() async {
    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1970, value: '$i'));
    }

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }

    super.onInit();
    items = await FacilityManager.find(params: 'building=4&category=10');
    item = items[0];

    if (item.value1 == 'false') {
      installation = false;
    } else {
      installation = true;
    }

    item.extra['value2'] = TextEditingController();
    item.extra['value2'].text = item.value2;

    item.extra['value10'] = TextEditingController();
    item.extra['value10'].text = item.value10;

    items = await FacilityManager.find(params: 'building=4&category=11');

    if (items.length == 0) {
      items.add(Facility());
    }

    transs = await FacilityManager.find(params: 'building=4&category=12');

    if (items.length == 0) {
      transs.add(Facility());
    }

    for (int j = 0; j < transs.length; j++) {
      transs[j].extra['value1'] = TextEditingController();
      transs[j].extra['value1'].text = transs[j].value1;
      transs[j].extra['value2'] = TextEditingController();
      transs[j].extra['value2'].text = transs[j].value2;
      transs[j].extra['value3'] = TextEditingController();
      transs[j].extra['value3'].text = transs[j].value3;
      transs[j].extra['value4'] = TextEditingController();
      transs[j].extra['value4'].text = transs[j].value4;
      transs[j].extra['value5'] = TextEditingController();
      transs[j].extra['value5'].text = transs[j].value5;
      transs[j].extra['value6'] = TextEditingController();
      transs[j].extra['value6'].text = transs[j].value6;
      transs[j].extra['value7'] = TextEditingController();
      transs[j].extra['value7'].text = transs[j].value7;
      transs[j].extra['value8'] = TextEditingController();
      transs[j].extra['value8'].text = transs[j].value8;
      transs[j].extra['value9'] = TextEditingController();
      transs[j].extra['value9'].text = transs[j].value9;
    }

    highs = await FacilityManager.find(params: 'building=4&category=13');
    if (highs.length == 0) {
      highs.add(Facility());
    }

    for (int j = 0; j < highs.length; j++) {
      highs[j].extra['value1'] = TextEditingController();
      highs[j].extra['value1'].text = highs[j].value1;
      highs[j].extra['value2'] = TextEditingController();
      highs[j].extra['value2'].text = highs[j].value2;
      highs[j].extra['value3'] = TextEditingController();
      highs[j].extra['value3'].text = highs[j].value3;
      highs[j].extra['value4'] = TextEditingController();
      highs[j].extra['value4'].text = highs[j].value4;
      highs[j].extra['value5'] = TextEditingController();
      highs[j].extra['value5'].text = highs[j].value5;
      highs[j].extra['value6'] = TextEditingController();
      highs[j].extra['value6'].text = highs[j].value6;
      highs[j].extra['value7'] = TextEditingController();
      highs[j].extra['value7'].text = highs[j].value7;
      highs[j].extra['value8'] = TextEditingController();
      highs[j].extra['value8'].text = highs[j].value8;
      highs[j].extra['value9'] = TextEditingController();
      highs[j].extra['value9'].text = highs[j].value9;
    }
  }

  remove(data, index) {
    data.value.removeAt(index);
    itemsRedraw();
  }

  itemRedraw() {
    _item.refresh();
  }

  itemsRedraw() {
    _items.refresh();
  }

  transsRedraw() {
    _transs.refresh();
  }

  highsRedraw() {
    _highs.refresh();
  }

  bool toBoolean(String str) {
    return str == 'true';
  }
}
