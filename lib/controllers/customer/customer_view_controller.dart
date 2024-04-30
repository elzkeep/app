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
    await getGenerator();
    await getSun();
    await getCharger();
    await getEss();
    await getUps();
    await getFuel();
    await getWind();
    await getWater();
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

  getGenerator() async {
    final res = await FacilityManager.find(
        params: 'building=${item.building.id}&category=20');

    if (res.isNotEmpty) {
      other[0] = true;
    }
  }

  getSun() async {
    final res = await FacilityManager.find(
        params: 'building=${item.building.id}&category=30');

    if (res.isNotEmpty) {
      other[1] = true;
    }
  }

  getCharger() async {
    final res = await FacilityManager.find(
        params: 'building=${item.building.id}&category=40');

    if (res.isNotEmpty) {
      other[2] = true;
    }
  }

  getEss() async {
    final res = await FacilityManager.find(
        params: 'building=${item.building.id}&category=50');

    if (res.isNotEmpty) {
      other[3] = true;
    }
  }

  getUps() async {
    final res = await FacilityManager.find(
        params: 'building=${item.building.id}&category=60');

    if (res.isNotEmpty) {
      other[4] = true;
    }
  }

  getFuel() async {
    final res = await FacilityManager.find(
        params: 'building=${item.building.id}&category=70');

    if (res.isNotEmpty) {
      other[5] = true;
    }
  }

  getWind() async {
    final res = await FacilityManager.find(
        params: 'building=${item.building.id}&category=80');

    if (res.isNotEmpty) {
      other[6] = true;
    }
  }

  getWater() async {
    final res = await FacilityManager.find(
        params: 'building=${item.building.id}&category=90');

    if (res.isNotEmpty) {
      other[7] = true;
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
