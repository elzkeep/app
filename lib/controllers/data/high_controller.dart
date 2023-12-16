import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class HighController extends GetxController {
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
    if (index == 2) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.single,
              title: '개폐기',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.select, title: '개폐기 종류', extra: {
              'select': [
                CItem(id: 0, value: '없음'),
                CItem(id: 1, value: 'LBS'),
                CItem(id: 2, value: 'ASS'),
                CItem(id: 3, value: 'DS'),
                CItem(id: 4, value: 'ALTS'),
                CItem(id: 5, value: 'LS'),
                CItem(id: 6, value: 'PF'),
                CItem(id: 7, value: 'COS'),
              ]
            }),
            Item(type: ItemType.status, title: '외관 관리상태'),
            Item(type: ItemType.status, title: '간선(한전 책임분계점 이후) 상태'),
            Item(type: ItemType.status, title: '자동/수동 조작시 작동여부'),
          ]);
    } else if (index == 3) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.single,
              title: '변성기(MOF, PT, C) 관리상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status),
          ]);
    } else if (index == 4) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '고압차단기',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status, title: '외관 및 간선 연결상태'),
            Item(type: ItemType.status, title: '자동/수동 조작시 작동여부'),
            Item(type: ItemType.status, title: '장비 내 발열여부'),
          ]);
    } else if (index == 5) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '피뢰기 관리상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status),
          ]);
    }

    return Dataitem.empty();
  }

  @override
  onInit() {
    super.onInit();

    List<Dataitem> datas = [];

    for (var i = 2; i <= 5; i++) {
      datas.add(category(i, 0, 0));
    }

    items = datas;
  }

  add(index) {
    final datas = category(index, items.length, 1);

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
    items.value.removeAt(index);
    redraw();
  }

  redraw() {
    _items.refresh();
  }
}
