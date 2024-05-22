import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem high(index, order, suborder, period) {
  var items = highs(index, order, suborder, period);
  return items[index - 1];
}

List<Dataitem> highs(index, order, suborder, period) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '전압 및 전류 계측값',
            category: index,
            order: suborder),
        items: [
          Item(
              type: ItemType.text,
              title: '전압',
              unit: 'kV',
              extra: {'end': true}),
          Item(
            type: ItemType.text,
            title: 'A상',
            unit: 'V',
          ),
          Item(
            type: ItemType.text,
            title: 'B상',
            unit: 'V',
          ),
          Item(
            type: ItemType.text,
            title: 'C상',
            unit: 'V',
          ),
          Item(
              type: ItemType.text,
              title: 'N상',
              unit: 'V',
              extra: {'end': true}),
        ]),
    Dataitem(
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
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '변성기(MOF, PT, C) 관리상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
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
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '계전기',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '외관 및 파손상태'),
          Item(type: ItemType.status, title: '통신 연결상태'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '피뢰기 관리상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    // /* 연차일때 점검시에만 나옴
    if (period == 4) ...[
      Dataitem(
          order: order,
          parent: '절연저항',
          data: Data(
              type: DataType.multi,
              title: '측정회로 및 기기',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.text, title: '전선-대지', unit: 'MΩ'),
            Item(type: ItemType.text, title: 'A-B', unit: 'MΩ'),
            Item(type: ItemType.text, title: 'B-C', unit: 'MΩ'),
            Item(
                type: ItemType.text,
                title: 'C-A',
                unit: 'MΩ',
                extra: {'end': true}),
            Item(type: ItemType.status),
          ]),
      Dataitem(
          order: order,
          parent: '접지저항',
          data: Data(
              type: DataType.multi,
              title: '점검대상 명',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.select, title: '접지선', extra: {
              'select': [
                CItem(id: 0, value: '접지선'),
                CItem(id: 1, value: 'HIV'),
                CItem(id: 2, value: 'GV'),
              ],
              'default': 1
            }),
            Item(type: ItemType.text, title: '접지선 두깨', unit: 'mm'),
            Item(type: ItemType.text, title: '기준치', unit: 'Ω'),
            Item(
                type: ItemType.text,
                title: '측정치',
                unit: 'Ω',
                extra: {'end': true}),
            Item(type: ItemType.status),
          ]),
      Dataitem(
          order: order,
          parent: '절연내력',
          data: Data(
              type: DataType.multi,
              title: '시험항목',
              category: index,
              order: suborder),
          items: [
            Item(type: ItemType.text, title: '시험전압', unit: 'kV'),
            Item(type: ItemType.text, title: '누적전류', unit: 'µA'),
            Item(
                type: ItemType.text,
                title: '절연저항',
                unit: 'MΩ',
                extra: {'end': true}),
            Item(type: ItemType.status),
          ]),
    ],
    // */
  ];
}
