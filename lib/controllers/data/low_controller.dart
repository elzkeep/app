import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/status.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class LowController extends GetxController {
  final _id = 0.obs;
  int get id => _id.value;
  set id(int value) => _id.value = value;

  final _type = 0.obs;
  int get type => _type.value;
  set type(int value) => _type.value = value;



  final _volt = 1.obs;
  int get volt => _volt.value;
  set volt(int value) => _volt.value = value;

  final _value1 = StatusItem().obs;
  StatusItem get value1 => _value1.value;
  set value1(StatusItem item) {
    _value1.value = item;
    _value1.refresh();
  }

  final _value2 = StatusItem().obs;
  StatusItem get value2 => _value2.value;
  set value2(StatusItem item) {
    _value2.value = item;
    _value2.refresh();
  }

  final _value3 = StatusItem().obs;
  StatusItem get value3 => _value3.value;
  set value3(StatusItem item) {
    _value3.value = item;
    _value3.refresh();
  }

  final _value4 = StatusItem().obs;
  StatusItem get value4 => _value4.value;
  set value4(StatusItem item) {
    _value4.value = item;
    _value4.refresh();
  }

  final _value5 = StatusItem().obs;
  StatusItem get value5 => _value5.value;
  set value5(StatusItem item) {
    _value5.value = item;
    _value5.refresh();
  }

  final _value6 = StatusItem().obs;
  StatusItem get value6 => _value6.value;
  set value6(StatusItem item) {
    _value6.value = item;
    _value6.refresh();
  }

  final _value7 = StatusItem().obs;
  StatusItem get value7 => _value7.value;
  set value7(StatusItem item) {
    _value7.value = item;
    _value7.refresh();
  }

  final _value8 = StatusItem().obs;
  StatusItem get value8 => _value8.value;
  set value8(StatusItem item) {
    _value8.value = item;
    _value8.refresh();
  }

  final _value9 = StatusItem().obs;
  StatusItem get value9 => _value9.value;
  set value9(StatusItem item) {
    _value9.value = item;
    _value9.refresh();
  }

  final _value10 = StatusItem().obs;
  StatusItem get value10 => _value10.value;
  set value10(StatusItem item) {
    _value10.value = item;
    _value10.refresh();
  }

  final _value11 = StatusItem().obs;
  StatusItem get value11 => _value11.value;
  set value11(StatusItem item) {
    _value11.value = item;
    _value11.refresh();
  }

  final _value12 = StatusItem().obs;
  StatusItem get value12 => _value12.value;
  set value12(StatusItem item) {
    _value12.value = item;
    _value12.refresh();
  }

  final _items = [].obs;
  get items => _items;
  set items( value) => _items.value = value;

  @override
  onInit() {
    super.onInit();

    final datas = Dataitem(
        data: Data(type: DataType.multi, title: '저압차단기', order: 0),
        items: [
          Item(type: ItemType.select, title: '차단기 종류', extra: {
            'select': [
              CItem(id: 0, value: '없음'),
              CItem(id: 1, value: 'ABC'),
              CItem(id: 2, value: 'MCCB'),
              CItem(id: 3, value: 'ELB'),
            ]
          }),
          Item(type: ItemType.status, title: '외관 및 간선 연결상태'),
          Item(type: ItemType.status, title: '자동/수동 조작시 작동여부'),
          Item(type: ItemType.status, title: '장비내 발열여부'),
        ]);

    items = [datas];
  }
}
