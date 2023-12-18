import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class LowController extends GetxController {
  final _id = 0.obs;
  int get id => _id.value;
  set id(int value) => _id.value = value;

  final _volt = 1.obs;
  int get volt => _volt.value;
  set volt(int value) => _volt.value = value;

  final _items = [].obs;
  get items => _items;
  set items( value) => _items.value = value;

  Dataitem category(index, order, suborder) {
    if (index == 1) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.single,
              title: '전압 및 전류 계측값',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.select, title: 'Main 전압/전류', extra: {
              'select': [
                CItem(id: 0, value: '전압'),
                CItem(id: 1, value: '380v/220v'),
                CItem(id: 2, value: '220v'),
              ],
              'default': 1
            }),
            Item(type: ItemType.text, title: 'A상', unit: 'V', extra: {'visible': 1}),
            Item(type: ItemType.text, title: 'B상', unit: 'V', extra: {'visible': 1}),
            Item(type: ItemType.text, title: 'C상', unit: 'V', extra: {'visible': 1}),
            Item(type: ItemType.text, title: 'N상', unit: 'V', extra: {'visible': 1, 'end': true}),
            Item(type: ItemType.text, title: '', unit: 'V', extra: {'visible': 2}),
            Item(type: ItemType.text, title: 'N상', unit: 'V', extra: {'visible': 2, 'end': true}),
          ]);
    } else if (index == 2) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '배선용 차단기 적정성',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status),
          ]);
    } else if (index == 3) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '저압차단기',
              category: index,
              order: suborder),
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
    } else if (index == 4) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '계전기',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status, title: '외관 및 파손 상태'),
            Item(type: ItemType.status, title: '통신 연결상태'),
          ]);
    } else if (index == 5) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '콘덴서 관리상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status),
          ]);
    } else if (index == 6) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '분배전반',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status, title: '외관 및 간선 연결상태'),
            Item(type: ItemType.status, title: '규격에 맞는 기기(차단기, 전선 등) 사용 여부'),
            Item(type: ItemType.status, title: '누전차단기 작동여부'),
            Item(type: ItemType.status, title: '부하장비명 표기 상태'),
          ]);
    } else if (index == 7) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: 'MCC반 운용상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status),
          ]);
    }

    return Dataitem.empty();
  }

  getDataitem(index, order, suborder) {
    Dataitem item = category(index, order, suborder);
      for (var j = 0; j < item.items.length; j++) {
        if (item.items[j].type == ItemType.select) {
          if (item.items[j].extra['default'] != null) {
            item.items[j].value = item.items[j].extra['default'];
          }

          continue;
        }
        if (item.items[j].type != ItemType.status) {
          continue;
        }

        item.items[j].status = ItemStatus.notuse;
        item.items[j].extra = {
          'reasontext': TextEditingController(),
          'actiontext': TextEditingController(),
        };
      }

      item.data.extra = { 'text': TextEditingController()};
      item.data.extra['text'].text = item.data.title;

      return item;
  }

  @override
  onInit() {
    super.onInit();

    List<Dataitem> datas = [];

    for (var i = 1; i <= 7; i++) {
      datas.add(getDataitem(i, 0, 0));
    }

    items = datas;
  }

  add(index) {
    final datas = getDataitem(index, items.length, 1);

    var pos = 0;
    for (var i = 0; i < items.length; i++) {
      final item = items[i];

      if (item.data.category <= index) {
        pos++;
        continue;
      }

      break;
    }

    items.insert(pos, datas);
    redraw();
  }

  remove(index) {
    print('delete = $index');
    items.value.removeAt(index);
    redraw();
  }

  redraw() {
    _items.refresh();
  }
}
