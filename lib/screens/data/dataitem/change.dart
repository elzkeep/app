import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem change(index, order, suborder) {
  var items = changes(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> changes(index, order, suborder) {
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
        ])
  ];
}
