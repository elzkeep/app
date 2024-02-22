import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/facility/facility_view_controller.dart';

class FacilityViewScreen extends CWidget {
  FacilityViewScreen({super.key});

  final c = Get.find<FacilityViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Layout(
        popup: true,
        child: CScroll(gap: 20, children: [
          company(),
          building(),
          CColumn(gap: 10, children: [
            SubTitle(
              '고압차단기',
            ),
            for (int i = 0; i < c.highs.length; i++) check(c.highs[i]),
          ]),
          CColumn(gap: 10, children: [
            SubTitle(
              '변전 설비',
            ),
            for (int i = 0; i < c.transs.length; i++) contract(c.transs[i]),
          ]),
          // contract2(),
          const SizedBox(height: 50)
        ])));
  }

  entry(text1, answer1) {
    return CRow(
      children: [CText(text1), CText(answer1)],
    );
  }

  entry2(text1, answer1, text2, answer2) {
    return CRow(
      children: [
        Expanded(
          child: CRow(
            children: [CText(text1), CText(answer1)],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CRow(
            children: [CText(text2), CText(answer2)],
          ),
        )
      ],
    );
  }

  company() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '설비 기본 정보',
        more: '정보 수정',
        onMore: () => clickUpdate(1),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry2('수전용량: ', c.item.value2, '관리점수: ', ''),
                entry2(
                    '수전 위치:',
                    c.item.value4 == '7'
                        ? c.item.value5
                        : c.positions[int.tryParse(c.item.value4) ?? 0].value,
                    '수전 형태:',
                    c.types[int.tryParse(c.item.value3) ?? 0].value),
              ]))
    ]);
  }

  building() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '수배전 설비',
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry(
                    '수전전압: ',
                    c.item.value6 == '3'
                        ? c.item.value7
                        : c.volts[int.tryParse(c.item.value6) ?? 0].value),
                entry2(
                    '형태:',
                    c.arrangementtypes[int.tryParse(c.item.value8) ?? 0].value,
                    '면수:',
                    c.faces[int.tryParse(c.item.value9) ?? 0].value),
              ])),
      for (int i = 0; i < c.items.length; i++) distributiation(c.items[i]),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: entry2('제조사: ', c.item.value10, '설치년월',
              c.years[int.tryParse(c.item.value11) ?? 0].value))
    ]);
  }

  distributiation(items) {
    return CRound(
        backgroundColor: Config.backgroundColor,
        child: CColumn(
            lineWidth: 1,
            lineColor: Colors.black12,
            gap: 10,
            children: [
              entry(
                  '분배전 전압: ',
                  items.value1 == '3'
                      ? items.value2
                      : c.volts[int.tryParse(items.value1) ?? 0].value),
              entry2(
                  '형식:',
                  items.value3 == '3'
                      ? items.value4
                      : c.distributationtypes[int.tryParse(items.value3) ?? 0]
                          .value,
                  '면수:',
                  items.value5 == '3'
                      ? items.value6
                      : c.faces[int.tryParse(items.value5) ?? 0].value),
            ]));
  }

  check(highs) {
    return CRound(
        backgroundColor: Config.backgroundColor,
        child: CColumn(
            lineWidth: 1,
            lineColor: Colors.black12,
            gap: 10,
            children: [
              entry('설치 장소: ', highs.value1),
              entry2('차단기명:', c.breakers[int.tryParse(highs.value2) ?? 0].value,
                  '차단용량:', highs.value3),
              entry2('정격전압:', highs.value4, '전류:', highs.value5),
              entry2('제조사:', highs.value6, '제조번호:', highs.value7),
              entry('제작년월:',
                  '${c.years[int.tryParse(highs.value8) ?? 0].value}년 ${c.months[int.tryParse(highs.value9) ?? 0].value}'),
            ]));
  }

  contract(transs) {
    return CRound(
        backgroundColor: Config.backgroundColor,
        child: CColumn(
            lineWidth: 1,
            lineColor: Colors.black12,
            gap: 10,
            children: [
              entry('설비명: ', transs.name),
              entry2(
                  '형식:',
                  c.transstypes[int.tryParse(transs.value2) ?? 0].value,
                  '정격용량:',
                  transs.value3),
              entry2('%Z:', transs.value4, '정격전압:', transs.value5),
              entry2('제조사:', transs.value6, '제조번호:', transs.value7),
              entry('제작년월:',
                  '${c.years[int.tryParse(transs.value8) ?? 0].value}년 ${c.months[int.tryParse(transs.value9) ?? 0].value}'),
            ]));
  }

  contract2() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '발전 설비',
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                CBothSide(children: [
                  CText('비상용발전:'),
                  CText('발전용량:'),
                ]),
                CBothSide(children: [CText('태양광발전:'), CText('발전용량:')]),
              ]))
    ]);
  }

  clickUpdate(pos) {
    print(c.building);
    Get.toNamed('/facility/${c.id}/insert',
        arguments: {'building': c.building});
  }
}
