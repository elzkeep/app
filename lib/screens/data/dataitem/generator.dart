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
          /* 분기, 반기일때 점검시에만 나옴
          Item(type: ItemType.status, title: '비상정지 장치시험 상태'),
          Item(type: ItemType.status, title: '부하운전시험 상태'),
          Item(type: ItemType.status, title: '부하차단시험 상태'),
          Item(type: ItemType.status, title: '조속장치 상태'),
          Item(type: ItemType.status, title: '상용전원 측과 접속상태 적정여부'),
          Item(type: ItemType.status, title: '분배전반 및 보호시설의 적정여부'),
          Item(type: ItemType.status, title: '축전지 및 충전장치의 적정여부'),
          Item(type: ItemType.none, title: '연료유계통'),
          Item(type: ItemType.status),
          Item(type: ItemType.status),
          // 반기일때 점검시에만 나옴
          Item(type: ItemType.none, title: '부하용량(kW)'),
          Item(type: ItemType.text, title: '정전시', unit: 'kW'),
          Item(
              type: ItemType.text,
              title: '화재시',
              unit: 'kW',
              extra: {'end': true}),
          Item(type: ItemType.none, title: '계측정보'),
          Item(
              type: ItemType.text,
              title: '절연저항',
              unit: 'MΩ',
              extra: {'end': true}),
          Item(type: ItemType.text, title: '접지저항(중심점)', unit: 'Ω'),
          Item(type: ItemType.text, title: '접지저항(외함)', unit: 'Ω'),
          Item(type: ItemType.text, title: '축전지전압', unit: 'V'),
          Item(type: ItemType.text, title: '비중', extra: {'end': true}),
          */
        ])
  ];
}
