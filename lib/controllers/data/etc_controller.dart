import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class EtcController extends GetxController {
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
              title: '한전 인입강선 상태',
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
              title: '접지 설비 상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status)
          ]);
    } else if (index == 3) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.single,
              title: '보호울타리 및 위험표시 상태',
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
              title: '시건 잠금 장치의 설치 상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status)
          ]);

    } else if (index == 5) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.single,
              title: '빗물 누수 및 침수 우려',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status)
          ]);

    } else if (index == 6) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.single,
              title: '계측장비 설치상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status)
          ]);
    } else if (index == 7) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '기타 안전 설비',
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

    for (var i = 1; i <= 7; i++) {
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
