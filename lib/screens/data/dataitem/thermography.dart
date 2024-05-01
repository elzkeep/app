import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem thermography(index, order, suborder) {
  var items = thermographys(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> thermographys(index, order, suborder) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '열화상 카메라',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.text, title: '사용전압', unit: 'V'),
          Item(type: ItemType.text, title: '측정조건', extra: {'end': true}),
          Item(type: ItemType.select, title: '판정기준', extra: {
            'select': [
              CItem(id: 0, value: '판정기준'),
              CItem(id: 1, value: '3성 비교법'),
              CItem(id: 2, value: '온도패턴법'),
            ],
            'default': 1
          }),
          Item(type: ItemType.none, title: '부위별 측정온도'),
          Item(type: ItemType.text, title: '측정부위', extra: {'end': true}),
          Item(type: ItemType.text, title: 'point1', unit: '°C'),
          Item(type: ItemType.text, title: 'point2', unit: '°C'),
          Item(type: ItemType.text, title: 'point3', unit: '°C'),
          Item(
              type: ItemType.text,
              title: '온도차',
              unit: '°C',
              extra: {'end': true}),
          Item(type: ItemType.status),
        ]),
  ];
}
