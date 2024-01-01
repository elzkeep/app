import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem sunlight(index, order, suborder) {
  var items = sunlights(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> sunlights(index, order, suborder) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '전압 및 전류 계측정보',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.none, title: '태양광 모듈'),
          Item(type: ItemType.text, title: '형식', unit: ''),
          Item(type: ItemType.text, title: '최대전력용량', unit: 'kW'),
          Item(type: ItemType.text, title: '최대동작전압', unit: 'V'),
          Item(
              type: ItemType.text,
              title: '최대동작전류',
              unit: 'A',
              extra: {'end': true}),
          Item(type: ItemType.none, title: '인버터'),
          Item(type: ItemType.text, title: '형식', unit: ''),
          Item(type: ItemType.text, title: '정격용량', unit: 'kW'),
          Item(type: ItemType.text, title: '최소 입력전압', unit: 'V'),
          Item(type: ItemType.text, title: '최대 입력전압', unit: 'V'),
          Item(
              type: ItemType.text,
              title: '출력전압',
              unit: 'V',
              extra: {'end': true}),
        ])
  ];
}
