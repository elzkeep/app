import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem low(index, order, suborder) {
  final items = lows(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> lows(index, order, suborder) {
  return [
    Dataitem(
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
          Item(
              type: ItemType.text,
              title: 'A상',
              unit: 'V',
              extra: {'visible': 1}),
          Item(
              type: ItemType.text,
              title: 'B상',
              unit: 'V',
              extra: {'visible': 1}),
          Item(
              type: ItemType.text,
              title: 'C상',
              unit: 'V',
              extra: {'visible': 1}),
          Item(
              type: ItemType.text,
              title: 'N상',
              unit: 'V',
              extra: {'visible': 1, 'end': true}),
          Item(
              type: ItemType.text, title: '', unit: 'V', extra: {'visible': 2}),
          Item(
              type: ItemType.text,
              title: 'N상',
              unit: 'V',
              extra: {'visible': 2, 'end': true}),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '배선용 차단기 적정성',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
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
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '계전기',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '외관 및 파손 상태'),
          Item(type: ItemType.status, title: '통신 연결상태'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '콘덴서 관리상태',
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
          Item(type: ItemType.status, title: '외관 및 간선 연결상태'),
          Item(type: ItemType.status, title: '규격에 맞는 기기(차단기, 전선 등) 사용 여부'),
          Item(type: ItemType.status, title: '누전차단기 작동여부'),
          Item(type: ItemType.status, title: '부하장비명 표기 상태'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: 'MCC반 운용상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ])
  ];
}
