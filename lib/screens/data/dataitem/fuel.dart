import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem fuel(index, order, suborder) {
  var items = fuels(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> fuels(index, order, suborder) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '일반 사항',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '외형적(손상 및 변형 등) 관리상태'),
          Item(type: ItemType.status, title: '설비별 누수 여부 확인'),
          Item(type: ItemType.status, title: '각 기기별 접지상태 확인'),
          Item(type: ItemType.status, title: '기계설비 및 배관 등 누설상태 확인'),
          Item(type: ItemType.status, title: '고온 노출부 단열상태 확인'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '연료전지',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '자동정지장치 동작상태'),
          Item(type: ItemType.status, title: '운전 계측장치 상태 확인'),
          Item(type: ItemType.status, title: '비상정지 및 안전장치 동작상태 확인'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '인버터 및 제어, 보호장치',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '인버터 입/출력 운전상태'),
          Item(type: ItemType.status, title: '경보장치 작동상태'),
          Item(type: ItemType.status, title: '배선 손상, 접속단자 체결 등 마감처리 상태'),
          Item(type: ItemType.status, title: '보호계전기 설정값 및 계전기 연동상태'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '부하운전 상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '기타 사항',
        data: Data(
            type: DataType.multi,
            title: '절연/접지저항 측정',
            category: index,
            order: suborder),
        items: [
          // Item(type: ItemType.none),
          Item(type: ItemType.text, title: '접지저항', unit: 'Ω'),
          Item(
              type: ItemType.text,
              title: '절연저항',
              unit: 'MΩ',
              extra: {'end': true}),
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '기타 사항',
        data: Data(
            type: DataType.multi,
            title: '경보장치 작동상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '기타 사항',
        data: Data(
            type: DataType.multi,
            title: '기타 보호장치의 설계 동작상태 여부 확인',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '기타 사항',
        data: Data(
            type: DataType.single,
            title: '기타 기술기준 등 관련규정 적합 여부',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
  ];
}
