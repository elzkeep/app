import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem wind(index, order, suborder) {
  var items = winds(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> winds(index, order, suborder) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '풍차 설비',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '터빈 자동정지장치 동작상태'),
          Item(type: ItemType.status, title: '터빈 운전상태 및 계측장치 확인'),
          Item(type: ItemType.status, title: '풍력설비 비상정지 및 안전장치 상태'),
          Item(type: ItemType.status, title: '기어박스 윤활유 및 유압장치 작동유 누유여부 확인'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '발전기',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '비상정지 및 안전장치 상태'),
          Item(type: ItemType.status, title: '부하운전상태 및 계측장치 확인(전압, 전류)'),
          Item(type: ItemType.status, title: '운전 시 이상소음 발생여부'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '전력변환장치',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '외형적(손상 및 변형 등) 관리상태'),
          Item(type: ItemType.status, title: '배선 및 접속단자 상태'),
          Item(type: ItemType.status, title: '설치환경(온습도, 청결 등)의 상태'),
          Item(type: ItemType.status, title: '인버터 입/출력 운전상태'),
        ]),
    Dataitem(
        order: order,
        parent: '보호장치 및 경보장치',
        data: Data(
            type: DataType.multi,
            title: '보호계전기 설정값 및 계전기 연동상태',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        parent: '보호장치 및 경보장치',
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
        parent: '보호장치 및 경보장치',
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
        data: Data(
            type: DataType.single,
            title: '지지물',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '지지물 결속 상태 및 기초부지 배수 처리 상태'),
          Item(type: ItemType.status, title: '지지물의 볼트체결 상태 및 이상여부'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '기타 사항',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '운전/유지보수 기록 및 서류보존 상태'),
          Item(type: ItemType.none, title: '절연/접지저항 측정'),
          Item(type: ItemType.text, title: '접지저항', unit: 'Ω'),
          Item(
              type: ItemType.text,
              title: '절연저항',
              unit: 'MΩ',
              extra: {'end': true}),
          Item(type: ItemType.status),
          Item(type: ItemType.status, title: '소방설비 상태'),
        ]),
  ];
}
