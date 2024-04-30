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
        parent: '전압 및 전류 계측정보',
        data: Data(
            type: DataType.single,
            title: '태양광 모듈',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.text, title: '형식', unit: ''),
          Item(type: ItemType.text, title: '최대전력용량', unit: 'kW'),
          Item(type: ItemType.text, title: '최대동작전압', unit: 'V'),
          Item(
              type: ItemType.text,
              title: '최대동작전류',
              unit: 'A',
              extra: {'end': true}),
        ]),
    Dataitem(
        order: order,
        parent: '전압 및 전류 계측정보',
        data: Data(
            type: DataType.single,
            title: '인버터',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.text, title: '형식', unit: ''),
          Item(type: ItemType.text, title: '정격용량', unit: 'kW'),
          Item(type: ItemType.text, title: '최소 입력전압', unit: 'V'),
          Item(type: ItemType.text, title: '최대 입력전압', unit: 'V'),
          Item(
              type: ItemType.text,
              title: '출력전압',
              unit: 'V',
              extra: {'end': true}),
        ]),
    Dataitem(
        order: order,
        parent: '전압 및 전류 계측정보',
        data: Data(
            type: DataType.multi,
            title: '절연저항',
            category: index,
            order: suborder),
        items: [Item(type: ItemType.status)]),
    Dataitem(
        order: order,
        parent: '태양광 모듈 점검사항',
        data: Data(
            type: DataType.multi,
            title: '외형적 관리상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '인버터(전략변환장치) 점검사항',
        data: Data(
            type: DataType.multi,
            title: '외형적 관리상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '인버터(전략변환장치) 점검사항',
        data: Data(
            type: DataType.single,
            title: '작동(소음, 진동, 발열 등) 상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '인버터(전략변환장치) 점검사항',
        data: Data(
            type: DataType.single,
            title: '배선 및 접속 단자 상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '인버터(전략변환장치) 점검사항',
        data: Data(
            type: DataType.single,
            title: '설치환경(온습도, 청결 등)의 상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '인버터(전략변환장치) 점검사항',
        data: Data(
            type: DataType.single,
            title: '설정값(저주파, 계전기, 보호장치 등)의 적정성 여부',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '인버터(전략변환장치) 점검사항',
        data: Data(
            type: DataType.single,
            title: '표시부 동작 확인',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
  ];
}
