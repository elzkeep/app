import 'package:common_control/common_control.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class ChargerController extends GetxController {
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
              title: '인입선 전선의 종류, 굵기, 지상고 등의 상태',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status),
          ]);
    } else if (index == 2) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '분배전반',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status, title: '설치장소 구조 및 공간확보 등의 관리상태'),
            Item(type: ItemType.status, title: '외함의 방수/방습조치, 방청등 조치 상태'),
            Item(type: ItemType.status, title: '전원 및 충전부 접촉방지 상태'),
          ]);
    } else if (index == 3) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '개폐기',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status, title: '전원부 개폐기, 과전류차단기 설치 상태'),
            Item(type: ItemType.status, title: '누전차단기 동작 및 상태'),
          ]);
    } else if (index == 4) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '옥내배선 및 기구 등',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status, title: '전선의 관리상태(종류, 굵기, 배선방법 등)'),
            Item(type: ItemType.status, title: '배선기구의 충전부 노출상태'),
            Item(type: ItemType.status, title: '저압배선기구의 방습/방수 상태'),
          ]);
    } else if (index == 5) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.multi,
              title: '충전시설',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.status, title: '충전소 설치장소 주변 배수시설 상태'),
            Item(type: ItemType.status, title: '외함 관리상태(누수, 파손, 고정상태 등)'),
            Item(type: ItemType.status, title: '차량 충돌 방지 조치여부'),
            Item(type: ItemType.status, title: '충전케이블 손상여부 확인'),
            Item(type: ItemType.status, title: '충전기의 외기 노출 적합성'),
            Item(type: ItemType.status, title: '방습/방수/방진 대비 상태'),
            Item(type: ItemType.status, title: '전기차 전용 장소의 표시 상태'),
            Item(type: ItemType.status, title: '충전소 설치지역(침수 및 분진 미발생)의 적정성'),
            Item(type: ItemType.status, title: '충전소 주변 위험 표지 설치 여부'),
          ]);
    } else if (index == 6) {
      return Dataitem(
          order: order,
          data: Data(
              type: DataType.single,
              title: '충전시설-전기자동차 간의 접지 연속성',
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

    for (var i = 1; i <= 5; i++) {
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
