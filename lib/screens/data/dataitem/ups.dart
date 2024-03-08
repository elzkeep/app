import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem ups(index, order, suborder) {
  var items = upss(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> upss(index, order, suborder) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '일반사항',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '충전부 감전 보호시설 설치 여부 및 상태'),
          Item(type: ItemType.status, title: '전선 및 케이블 피복 손상여부'),
          Item(type: ItemType.status, title: '설치 장소 내 온도 적정성'),
          Item(type: ItemType.status, title: '설비내 오염 여부 및 환기 설비 관리상태'),
          Item(type: ItemType.status, title: '무정전전원장치 시설 표시 상태'),
          Item(type: ItemType.status, title: '비상연락처 및 매뉴얼 등 비치여부'),
          Item(type: ItemType.status, title: '적재하중 및 외부 충격 방지 안정성'),
          Item(type: ItemType.status, title: '침수 및 누수/결로 방지 대비 상태'),
          Item(type: ItemType.status, title: '소방설비 상태 확인'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '제어 및 보호장치',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '환기설비 상태 확인'),
          Item(type: ItemType.status, title: '배전반 계기 및 경보장치 이상유무'),
          Item(type: ItemType.status, title: '만충 후 추가충전 여부'),
          Item(
              type: ItemType.text,
              title: '충전율 설정값',
              unit: '%',
              extra: {'end': true}),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '배터리',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: '배터리 관리시스템(BMS) 점검상태'),
          Item(type: ItemType.status, title: '외관(파손 및 액 누출 등)점검 상태'),
          Item(type: ItemType.status, title: '단자 접속 상태 '),
          Item(type: ItemType.status, title: '배터리 지지물 부식상태'),
          Item(type: ItemType.status, title: '장비 식별을 위한 명판 부착상태'),
          Item(type: ItemType.status, title: '금속 지지물의 녹방지 처리 상태 및 부식여부'),
          Item(type: ItemType.none, title: '권장 온습도 관리의 적정성 여부'),
          Item(type: ItemType.text, title: '온도', unit: '°C'),
          Item(
              type: ItemType.text,
              title: '습도',
              unit: '%',
              extra: {'end': true}),
          Item(type: ItemType.status),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '기타 사항',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.none, title: '절연/접지저항 측정'),
          Item(type: ItemType.text, title: '접지저항', unit: 'Ω'),
          Item(
              type: ItemType.text,
              title: '절연저항',
              unit: 'MΩ',
              extra: {'end': true}),
          Item(type: ItemType.status, title: '기타 기술기준 등 관련규정 적합 여부'),
        ]),
  ];
}
