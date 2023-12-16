import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class ChangeController extends GetxController {
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
              type: DataType.multi,
              title: '변압기 (TR 1)',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.select, title: '형식', extra: {
              'select': [
                CItem(id: 0, value: '없음'),
                CItem(id: 1, value: '몰드형'),
                CItem(id: 2, value: '유입형'),
              ]
            }),
            Item(type: ItemType.none, title: '전압 및 전류 계측 정보'),
            Item(type: ItemType.text, title: 'TR용량', unit: 'KVA'),
            Item(type: ItemType.text, title: '전압', unit: 'V'),
            Item(type: ItemType.text, title: 'A상', unit: 'V'),
            Item(type: ItemType.text, title: 'B상', unit: 'V'),
            Item(type: ItemType.text, title: 'C상', unit: 'V'),
            Item(type: ItemType.text, title: 'N상', unit: 'V'),
            Item(type: ItemType.text, title: '온도', unit: '°C', extra: {'end': true}),
            Item(type: ItemType.status),
            Item(type: ItemType.status, title: '외관 관리상태'),
            Item(type: ItemType.status, title: '관리 온도 이상 여부', extra: {'visible': 1}),
          ]);
    }

    return Dataitem.empty();
  }

  @override
  onInit() {
    super.onInit();

    List<Dataitem> datas = [];

    for (var i = 1; i <= 1; i++) {
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
