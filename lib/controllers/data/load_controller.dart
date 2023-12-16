import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class LoadController extends GetxController {
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
              title: '전열기구 운용상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status)
          ]);
    } else if (index == 2) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '조명설비 및 관리상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status)
          ]);
    } else if (index == 3) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '용도에 맞는 조도상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status)
          ]);
    } else if (index == 4) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '구내전선 외관 및 관리상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status)
          ]);

    } else if (index == 5) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '시공방법의 적합성',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status)
          ]);

    } else if (index == 6) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '기타 부하설비',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status)
          ]);

    }

    return Dataitem.empty();
  }

  @override
  onInit() {
    super.onInit();

    List<Dataitem> datas = [];

    for (var i = 1; i <= 6; i++) {
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
