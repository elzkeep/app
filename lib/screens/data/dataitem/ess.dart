import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

Dataitem ess(index, order, suborder) {
  var items = esss(index, order, suborder);
  return items[index - 1];
}

List<Dataitem> esss(index, order, suborder) {
  return [
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '일반사항',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: 'ESS충전부 노출 상태'),
          Item(type: ItemType.status, title: '전선 및 케이블 피복 손상여부'),
          Item(type: ItemType.status, title: '설치 장소 내 온도 적정성'),
          Item(type: ItemType.status, title: '설비내 오염 여부 및 환기 설비 관리상태'),
          Item(type: ItemType.status, title: '폭발 및 가연성 물질로부터 격리안정성 여부'),
          Item(type: ItemType.status, title: '소방설비 상태 확인'),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.multi,
            title: '전력변환장치',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.status, title: 'PCS 및 외관 관리상태'),
          Item(type: ItemType.status, title: 'PCS 환기설비 상태 확인'),
          Item(type: ItemType.status, title: '배전반 계기 및 경보장치 이상유무'),
          Item(type: ItemType.status, title: '비상스위치 동작상태 확인'),
          Item(type: ItemType.none, title: '절연/접지저항 측정'),
          Item(type: ItemType.text, title: '접지저항', unit: 'Ω'),
          Item(
              type: ItemType.text,
              title: '절연저항',
              unit: 'MΩ',
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
          Item(type: ItemType.status, title: '적재하중 및 외부 충격 방지 안정성'),
          Item(type: ItemType.status, title: '침수 방지 대비 상태'),
          Item(type: ItemType.status, title: 'ESS 내부 오염 및 침수 상태확인'),
          Item(type: ItemType.none, title: '절연/접지저항 측정'),
          Item(type: ItemType.text, title: '접지저항', unit: 'Ω'),
          Item(
              type: ItemType.text,
              title: '절연저항',
              unit: 'MΩ',
              extra: {'end': true}),
        ]),
    Dataitem(
        order: order,
        data: Data(
            type: DataType.single,
            title: '충전율(SOC)',
            category: index,
            order: suborder),
        items: [
          Item(type: ItemType.select, title: '설치장소', extra: {
            'select': [
              CItem(id: 0, value: '없음'),
              CItem(id: 1, value: '부속공간'),
              CItem(id: 2, value: '전용건물'),
            ]
          }),
          Item(type: ItemType.status),
        ]),
  ];
}
