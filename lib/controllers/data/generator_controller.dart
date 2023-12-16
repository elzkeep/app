import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class GeneratorController extends GetxController {
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
              title: '발전기',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.none, title: '발전기 운전'),

            Item(type: ItemType.text, title: '출력전압', unit: 'V'),
            Item(type: ItemType.text, title: '부하전류', unit: 'A'),
            Item(type: ItemType.text, title: '운전시간', unit: 'h/m', extra: {'end': true}),
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
