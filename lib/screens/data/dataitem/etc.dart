import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem etc(index, order, suborder) {
  var items = etcs(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> etcs(index, order, suborder) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '한전 인입강선 상태',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '접지 설비 상태',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '보호울타리 및 위험표시 상태',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '시건 잠금 장치의 설치 상태',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '빗물 누수 및 침수 우려',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '계측장비 설치상태',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '기타 안전 설비',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)])
  ];
}
