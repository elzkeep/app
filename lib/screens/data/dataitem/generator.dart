import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem generator(index, order, suborder) {
  var items = generators(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> generators(index, order, suborder) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '발전기',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.none, title: '발전기 운전'),
          Item(type: ItemType.text, title: '출력전압', unit: 'V'),
          Item(type: ItemType.text, title: '부하전류', unit: 'A'),
          Item(
              type: ItemType.text,
              title: '운전시간',
              unit: 'h/m',
              extra: {'end': true}),
        ])
  ];
}
