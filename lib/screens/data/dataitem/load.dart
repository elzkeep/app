import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem load(index, order, suborder) {
  var items = loads(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> loads(index, order, suborder) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '전열기구 운용상태',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        parent: '조명설비',
        data: Data(
            type: DataType.multi,
            title: '조명설비 및 관리상태',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        parent: '조명설비',
        data: Data(
            type: DataType.multi,
            title: '용도에 맞는 조도상태',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        parent: '구내전선',
        data: Data(
            type: DataType.multi,
            title: '구내전선 외관 및 관리상태',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        parent: '구내전선',
        data: Data(
            type: DataType.multi,
            title: '시공방법의 적합성',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '기타 부하설비',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)])
  ];
}
