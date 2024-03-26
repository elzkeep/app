import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/customer.dart';
import 'package:zkeep/models/facility.dart';
import 'package:zkeep/models/report.dart';

class CustomerViewController extends GetxController {
  CustomerViewController(this.id);

  final int id;

  final _item = Customer().obs;
  Customer get item => _item.value;
  set item(Customer value) => _item.value = value;

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  final _facility = Facility().obs;
  Facility get facility => _facility.value;
  set facility(Facility value) => _facility.value = value;

  final othername = [
    '발전설비',
    '태양광 발전',
    '전기차 충전기',
    'ESS',
    'UPS',
    '연료전지',
    '풍력발전',
    '수력발전',
    // '소방펌프 발전기',
    // '공동주택 세대점검',
  ];
  final _other = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ].obs;
  get other => _other;
  set other(value) => _other.value = value;

  final types = CItem.list(['', '저압', '특고압']).obs;

  @override
  onInit() async {
    super.onInit();
    await getItem();
    await find();
    await getFacility();
  }

  getItem() async {
    final res = await CustomerManager.get(id);
    item = res;
  }

  find() async {
    final ret =
        await ReportManager.find(params: 'building=${item.building.id}');

    items = ret;
  }

  getFacility() async {
    final res = await FacilityManager.find(
        params: 'building=${item.building.id}&category=10');
    if (res.isEmpty) {
      facility = Facility();
    } else {
      facility = res[0];
    }
  }

  facilityStatus() {
    List<String> facilitystatusarr = [];
    for (int i = 0; i < other.length; i++) {
      if (other[i] == true) {
        facilitystatusarr.add(othername[i]);
      }
    }
    return facilitystatusarr.join(', ');
  }
}
