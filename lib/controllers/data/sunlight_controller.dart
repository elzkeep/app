import 'package:common_control/common_control.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class SunlightController extends GetxController {
  final _id = 0.obs;
  int get id => _id.value;
  set id(int value) => _id.value = value;

  final _volt = 1.obs;
  int get volt => _volt.value;
  set volt(int value) => _volt.value = value;

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  Dataitem category(index, order, suborder) {
    if (index == 1) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.single,
              title: '전압 및 전류 계측정보',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.none, title: '태양광 모듈'),
            Item(type: ItemType.text, title: '형식', unit: ''),
            Item(type: ItemType.text, title: '최대전력용량', unit: 'kW'),
            Item(type: ItemType.text, title: '최대동작전압', unit: 'V'),
            Item(
                type: ItemType.text,
                title: '최대동작전류',
                unit: 'A',
                extra: {'end': true}),
            Item(type: ItemType.none, title: '인버터'),
            Item(type: ItemType.text, title: '형식', unit: ''),
            Item(type: ItemType.text, title: '정격용량', unit: 'kW'),
            Item(type: ItemType.text, title: '최소 입력전압', unit: 'V'),
            Item(type: ItemType.text, title: '최대 입력전압', unit: 'V'),
            Item(
                type: ItemType.text,
                title: '출력전압',
                unit: 'V',
                extra: {'end': true}),
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
