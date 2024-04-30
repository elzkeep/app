import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem charger(index, order, suborder) {
  var items = chargers(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> chargers(index, order, suborder) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '인입선 전선의 종류, 굵기, 지상고 등의 상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
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
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '개폐기',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '전원부 개폐기, 과전류차단기 설치 상태'),
          Item(type: ItemType.status, title: '누전차단기 동작 및 상태'),
        ]),
    Dataitem(
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
        ]),
    Dataitem(
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
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '충전시설-전기자동차 간의 접지 연속성',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    /* 반기일때 점검시에만 나옴
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '절연/접지저항 측정',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.text, title: '접지저항', unit: 'µA'),
          Item(
              type: ItemType.text,
              title: '절연저항',
              unit: 'MΩ',
              extra: {'end': true}),
          Item(type: ItemType.status),
        ]),
    */
  ];
}
