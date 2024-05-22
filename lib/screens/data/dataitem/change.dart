import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem change(index, order, suborder, period) {
  var items = changes(index, order, suborder, period);
  return items[index - 1];
}

List<Dataitem> changes(index, order, suborder, period) {
  return [
    Dataitem(
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
          Item(
              type: ItemType.text,
              title: '온도',
              unit: '°C',
              extra: {'end': true}),
          Item(type: ItemType.status),
          Item(type: ItemType.status, title: '외관 관리상태'),
          Item(
              type: ItemType.status,
              title: '관리 온도 이상 여부',
              extra: {'visible': 1}),
          // /* 연차일때 점검시에만 나옴
          if (period == 4) ...[
            Item(type: ItemType.none, title: '절연저항 (MΩ)'),
            Item(type: ItemType.text, title: '1차 - 대지'),
            Item(type: ItemType.text, title: '2차 - 대지'),
            Item(type: ItemType.text, title: '1차 - 2차', extra: {'end': true}),
            Item(type: ItemType.status),
            Item(type: ItemType.none, title: '유입형 내부점검'),
            Item(type: ItemType.text, title: 'OT내전압 (5회평균)'),
            Item(
                type: ItemType.text,
                title: 'OT산가도 (mgkoH/g)',
                extra: {'end': true}),
            Item(type: ItemType.text, title: '유량'),
            Item(type: ItemType.text, title: '탭위치', extra: {'end': true}),
            Item(type: ItemType.status),
          ]
          // */
        ])
  ];
}
