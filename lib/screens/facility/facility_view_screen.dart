import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/data/view_controller.dart';

class FacilityViewScreen extends CWidget {
  FacilityViewScreen({super.key});

  final c = Get.find<ViewController>();

  entry(text1, answer1) {
    return CRow(
      gap: 5,
      children: [CText(text1), CText(answer1)],
    );
  }

  entry2(text1, answer1, text2, answer2) {
    return CRow(
      children: [
        Expanded(
          child: CRow(
            gap: 5,
            children: [CText(text1), CText(answer1)],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CRow(
            gap: 5,
            children: [CText(text2), CText(answer2)],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Layout(
        popup: true,
        child: CScroll(
          gap: 20,
          children: [
            basic(),
            building(),
            receivingtype(),
            loopgenerator(),
            sun(),
            ev(),
            ess(),
            loopups(),
            loopfuel(),
            loopwind(),
            water(),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }

  basic() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '설비 기본 정보',
        more: '정보 수정',
        onMore: () => clickUpdate(),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry2('수전용량:', '${c.item.value2} kW', '관리점수:', ''),
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

  clickUpdate() {
    Get.toNamed('/facility/${c.id}/insert',
        arguments: {'building': c.building.id});
  }

  building() {
    return CColumn(children: [
      SubTitle('수배전 설비'),
      const SizedBox(height: 10),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry(
                    '수전전압:',
                    c.item.value6 == '3'
                        ? c.item.value7
                        : c.volts[int.tryParse(c.item.value6) ?? 0].value),
                entry2(
                    '형태:',
                    c.arrangementtypes[int.tryParse(c.item.value8) ?? 0].value,
                    '면수:',
                    c.item.value9 == '13'
                        ? c.item.value10
                        : c.faces[int.tryParse(c.item.value9) ?? 0].value),
              ])),
      // for (int i = 0; i < c.items.length; i++) distributiation(c.items[i]),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: c.items.length,
        itemBuilder: (context, index) {
          return distributiation(c.items[index]);
        },
      ),
      const SizedBox(height: 10),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: entry2('제조사:', c.item.value10, '설치년월:',
              c.years[int.tryParse(c.item.value11) ?? 0].value))
    ]);
  }

  distributiation(items) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry(
                    '분배전 전압:',
                    items.value1 == '3'
                        ? items.value2
                        : c.volts[int.tryParse(items.value1) ?? 0].value),
                entry2(
                    '형식:',
                    c.distributationtypes[int.tryParse(items.value3) ?? 0]
                        .value,
                    '면수:',
                    items.value4 == '13'
                        ? items.value5
                        : c.faces[int.tryParse(items.value4) ?? 0].value),
              ])),
    );
  }

  receivingtype() {
    if (c.item.value3 == '2') {
      return CColumn(children: [
        SubTitle('변전 설비'),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: c.transs.length,
          itemBuilder: (context, index) {
            return contract(c.transs[index]);
          },
        ),
        const SizedBox(height: 20),
        SubTitle('고압차단기'),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: c.highs.length,
          itemBuilder: (context, index) {
            return check(c.highs[index]);
          },
        ),
      ]);
    } else {
      return Container();
    }
  }

  contract(transs) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry('설비명:', transs.name),
                entry2(
                    '형식:',
                    c.transstypes[int.tryParse(transs.value2) ?? 0].value,
                    '정격용량:',
                    '${transs.value3} kVA'),
                entry2(
                    '%Z:', '${transs.value4} %', '정격전압:', '${transs.value5} V'),
                entry2('제조사:', transs.value6, '제조번호:', transs.value7),
                entry('제작년월:',
                    '${c.years[int.tryParse(transs.value8) ?? 0].value}년 ${c.months[int.tryParse(transs.value9) ?? 0].value}'),
              ])),
    );
  }

  check(highs) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: CRound(
        backgroundColor: Config.backgroundColor,
        child: CColumn(
            lineWidth: 1,
            lineColor: Colors.black12,
            gap: 10,
            children: [
              entry('설치 장소: ', highs.value1),
              entry2('차단기명:', c.breakers[int.tryParse(highs.value2) ?? 0].value,
                  '차단용량:', '${highs.value3} kVA'),
              entry2('정격전압:', '${highs.value4} kV', '전류:', '${highs.value5} A'),
              entry2('제조사:', highs.value6, '제조번호:', highs.value7),
              entry('제작년월:',
                  '${c.years[int.tryParse(highs.value8) ?? 0].value}년 ${c.months[int.tryParse(highs.value9) ?? 0].value}'),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: highs.contents.length,
                itemBuilder: (context, index) {
                  return relay(highs.contents[index]);
                },
              ),
            ]),
      ),
    );
  }

  relay(highsContents) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry('계전기명: ', highsContents.value1),
                entry2(
                    '제조사:',
                    c.relays[int.tryParse(highsContents.value2) ?? 0].value,
                    '제작년도:',
                    highsContents.value3),
                entry2('형식:', highsContents.value4, '계전기번호:',
                    highsContents.value5),
                entry2('설치장소:', highsContents.value6, '연결기기:',
                    c.years[int.tryParse(highsContents.value7) ?? 0].value),
              ])),
    );
  }

  loopgenerator() {
    if (c.other[0] == true) {
      return CColumn(children: [
        SubTitle('발전설비'),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: c.generator.length,
          itemBuilder: (context, index) {
            return generator(c.generator[index]);
          },
        ),
      ]);
    } else {
      return Container();
    }
  }

  generator(generator) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry('발전설비명: ', generator.name),
                entry2('원동기', '', '발전기', ''),
                entry2('형식(모델명):', generator.value2, '형식(모델명):',
                    generator.value11),
                entry2('정격용량:', '${generator.value3} kVA', '정격용량:',
                    '${generator.value12} kVA'),
                entry2('회전수:', '${generator.value4} rpm', '회전수:',
                    '${generator.value13} rpm'),
                entry2('제조사:', generator.value5, '제조사:', generator.value14),
                entry2('제작번호:', generator.value6, '제작번호:', generator.value15),
                entry2('제작년월:', generator.value7, '제작년월:', generator.value16),
                entry2(
                    '냉각방식:',
                    c.coolings[int.tryParse(generator.value8) ?? 0].value,
                    '정격전압:',
                    '${generator.value17} V'),
                entry2(
                    '기동방식:',
                    c.activations[int.tryParse(generator.value9) ?? 0].value,
                    '정격전류:',
                    '${generator.value18} A'),
                entry(
                    '차단기종류:',
                    c.generatortype[int.tryParse(generator.value10) ?? 0]
                        .value),
                entry('역률:', '${generator.value19} %'),
              ])),
    );
  }

  sun() {
    if (c.other[1] == true) {
      return CColumn(gap: 10, children: [
        SubTitle('태양광 발전'),
        CRound(
            backgroundColor: Config.backgroundColor,
            child: CColumn(
                lineWidth: 1,
                lineColor: Colors.black12,
                gap: 10,
                children: [
                  entry('태양광 발전명:', c.sunlight.name),
                  entry2(
                    '설치장소:',
                    c.sunlight.value2 == '4'
                        ? c.sunlight.value3
                        : c.place[int.tryParse(c.sunlight.value2) ?? 0].value,
                    '발전전압:',
                    c.sunlight.value4 == '3'
                        ? c.sunlight.value5
                        : c.voltage[int.tryParse(c.sunlight.value4) ?? 0].value,
                  ),
                  entry('발전용량:', c.sunlight.value6),
                  entry2('형식:', c.sunlight.value7, '최대전력용량:',
                      '${c.sunlight.value8} kW'),
                  entry2('최대동작전압:', '${c.sunlight.value9} V', '최대동작전류:',
                      '${c.sunlight.value10} A'),
                  entry2('형식:', c.sunlight.value11, '정격용량:',
                      '${c.sunlight.value12} kW'),
                  entry2('최소 입력전압:', '${c.sunlight.value13} V', '최대 입력전압:',
                      '${c.sunlight.value14} V'),
                  entry('출력전압:', '${c.sunlight.value15} V')
                ])),
      ]);
    } else {
      return Container();
    }
  }

  ev() {
    if (c.other[2] == true) {
      return CColumn(gap: 10, children: [
        SubTitle('EV 충전기'),
        CRound(
            backgroundColor: Config.backgroundColor,
            child: CColumn(
                lineWidth: 1,
                lineColor: Colors.black12,
                gap: 10,
                children: [
                  entry('EV 설비명:', c.charger.name),
                  entry2(
                    '설치장소:',
                    c.charger.value2,
                    '전압:',
                    c.charger.value3 == '3'
                        ? c.charger.value4
                        : c.voltage[int.tryParse(c.charger.value3) ?? 0].value,
                  ),
                  entry('용량:', '${c.charger.value5} kW'),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: c.chargeritems.length,
                    itemBuilder: (context, index) {
                      return chargerItem(c.chargeritems[index]);
                    },
                  ),
                ])),
      ]);
    } else {
      return Container();
    }
  }

  chargerItem(chargeritems) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry(
                    '설치현황:', '${chargeritems.value1} X ${chargeritems.value2}'),
                entry2(
                    '설치장소:',
                    chargeritems.value3 == '3'
                        ? chargeritems.value4
                        : c.evplace[int.tryParse(chargeritems.value3) ?? 0]
                            .value,
                    '충전형식:',
                    c.evform[int.tryParse(chargeritems.value5) ?? 0].value),
                entry2(
                    '출력전압:', chargeritems.value6, '충전용량:', chargeritems.value7),
                entry2(
                    '제조사:', chargeritems.value8, '모델명:', chargeritems.value9),
                entry('제작년월:',
                    '${c.years[int.tryParse(chargeritems.value10) ?? 0].value}년 ${c.months[int.tryParse(chargeritems.value11) ?? 0].value}'),
              ])),
    );
  }

  ess() {
    if (c.other[3] == true) {
      return CColumn(gap: 10, children: [
        SubTitle('전기저장장치'),
        CRound(
            backgroundColor: Config.backgroundColor,
            child: CColumn(
                lineWidth: 1,
                lineColor: Colors.black12,
                gap: 10,
                children: [
                  entry('전기저장장치명:', c.ess.name),
                  entry2(
                      '출력전압:',
                      c.ess.value2 == '3'
                          ? c.ess.value3
                          : c.voltage[int.tryParse(c.ess.value2) ?? 0].value,
                      '정격용량:',
                      '${c.ess.value4} kW'),
                  entry2(
                      '입력전압:', '${c.ess.value5} V', '~', '${c.ess.value6} V'),
                  entry2('제조사:', c.ess.value7, '제조번호:', c.ess.value8),
                  entry('제작년월:',
                      '${c.years[int.tryParse(c.ess.value9) ?? 0].value}년 ${c.months[int.tryParse(c.ess.value10) ?? 0].value}'),
                  entry('배터리', ''),
                  entry('최대저장용량: ', '${c.ess.value11} kWh'),
                  entry2(
                      '종류:',
                      c.ess.value12 == '7'
                          ? c.ess.value13
                          : c.esstype[int.tryParse(c.ess.value12) ?? 0].value,
                      '구성:',
                      '${c.ess.value14} X ${c.ess.value15} X ${c.ess.value16}'),
                  entry2('최대동작전압:', '${c.ess.value17} V', '최대동작전류:',
                      '${c.ess.value18} A'),
                  entry2('제조사:', c.ess.value19, '형식:', c.ess.value20),
                  entry('제작년월:',
                      '${c.years[int.tryParse(c.ess.value21) ?? 0].value}년 ${c.months[int.tryParse(c.ess.value22) ?? 0].value}'),
                ])),
      ]);
    } else {
      return Container();
    }
  }

  loopups() {
    if (c.other[4] == true) {
      return CColumn(children: [
        SubTitle(
          'ups',
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: c.ups.length,
          itemBuilder: (context, index) {
            return ups(c.ups[index]);
          },
        ),
      ]);
    } else {
      return Container();
    }
  }

  ups(ups) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry('UPS 설비명:', ups.name),
                entry2(
                    '설치장소:',
                    ups.value1 == '4'
                        ? ups.value2
                        : c.upspositions[int.tryParse(ups.value1) ?? 0].value,
                    'CCTV:',
                    c.upscctvs[int.tryParse(ups.value3) ?? 0].value),
                entry(
                    '상시운영정보 별도장소 보관 기간:',
                    ups.value4 == '4'
                        ? ups.value5
                        : c.upskeeps[int.tryParse(ups.value4) ?? 0].value),
                entry2(
                    '용도:',
                    ups.value6 == '4'
                        ? ups.value7
                        : c.upsusages[int.tryParse(ups.value6) ?? 0].value,
                    '방식:',
                    c.upstypes[int.tryParse(ups.value8) ?? 0].value),
                entry(
                  '비상전원공급 지속시간:',
                  ups.value9 == '6'
                      ? ups.value10
                      : c.upstimes[int.tryParse(ups.value9) ?? 0].value,
                ),
                entry('전력변환장치', ''),
                entry2(
                    '출력전압:', '${ups.value11} V', '정격용량:', '${ups.value12} kVA'),
                entry2('제조사:', ups.value13, '제작번호:', ups.value14),
                entry('제작년월:',
                    '${c.years[int.tryParse(ups.value15) ?? 0].value}년 ${c.months[int.tryParse(ups.value16) ?? 0].value}'),
                entry('이차전지(배터리)', ''),
                entry2('용량:', '${ups.value17} kW', '종류:', '${ups.value18} V'),
                entry2('제조사:', ups.value19, '제작년도:',
                    c.years[int.tryParse(ups.value20) ?? 0].value)
              ])),
    );
  }

  loopfuel() {
    if (c.other[5] == true) {
      return CColumn(children: [
        SubTitle(
          '연료전지 발전설비',
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: c.fuel.length,
          itemBuilder: (context, index) {
            return fuel(c.fuel[index]);
          },
        ),
      ]);
    } else {
      return Container();
    }
  }

  fuel(fuel) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry('연료전지 발전설비:', fuel.name),
                entry2(
                  '형식:',
                  fuel.value1,
                  '사용가스:',
                  fuel.value2 == '4'
                      ? fuel.value3
                      : c.gass[int.tryParse(fuel.value2) ?? 0].value,
                ),
                entry2('정격출력:', fuel.value4, '가스소비량:', fuel.value5),
                entry('가스압력범위:', '${fuel.value6} ~ ${fuel.value7}'),
                entry2('정격전압:', fuel.value8, '주파수:', fuel.value9),
                entry2('발전효율:', fuel.value10, '열효율:', fuel.value11),
                entry2(
                  '계통연계:',
                  c.fuelpositions[int.tryParse(fuel.value12) ?? 0].value,
                  '설치위치:',
                  c.fueltypes[int.tryParse(fuel.value13) ?? 0].value,
                ),
                entry2('급배기방식:', fuel.value14, '배기통길이:', fuel.value15),
                entry2('제조사:', fuel.value16, '제조번호:', fuel.value17),
                entry('제작년월:',
                    '${c.years[int.tryParse(fuel.value18) ?? 0].value}년 ${c.months[int.tryParse(fuel.value19) ?? 0].value}'),
              ])),
    );
  }

  loopwind() {
    if (c.other[6] == true) {
      return CColumn(children: [
        SubTitle(
          '풍력발전',
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: c.wind.length,
          itemBuilder: (context, index) {
            return wind(c.wind[index]);
          },
        ),
      ]);
    } else {
      return Container();
    }
  }

  wind(wind) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                entry('풍력발전소:', wind.name),
                entry2('형식:', wind.value1, '정격용량:', '${wind.value2} kW'),
                entry2('제조사:', wind.value3, '제조번호:', wind.value4),
                entry('제작년월:',
                    '${c.years[int.tryParse(wind.value5) ?? 0].value}년 ${c.months[int.tryParse(wind.value6) ?? 0].value}'),
                entry('풍차날개:', '${wind.value7} 개  ${wind.value8} 개'),
                entry('풍향조건:',
                    '${wind.value9} m/s    ${wind.value10} m/s    ${wind.value11} m/s'),
                entry2('형식:', wind.value12, '정격용량:', '${wind.value13} kW'),
                entry2('제조사:', wind.value14, '제작번호:', wind.value15),
                entry('제작년월:',
                    '${c.years[int.tryParse(wind.value16) ?? 0].value}년 ${c.months[int.tryParse(wind.value17) ?? 0].value}'),
                entry2('극수:', '${wind.value18} 극', '역률:', '${wind.value19} %'),
                entry2(
                    '정격전압:', '${wind.value20} V', '정격전류:', '${wind.value21} A'),
                entry2('절연저항:', '${wind.value22} MΩ', '접지저항:',
                    '${wind.value23} Ω'),
              ])),
    );
  }

  water() {
    if (c.other[7] == true) {
      return CColumn(gap: 10, children: [
        SubTitle(
          '수력 발전',
        ),
        CRound(
            backgroundColor: Config.backgroundColor,
            child: CColumn(
                lineWidth: 1,
                lineColor: Colors.black12,
                gap: 10,
                children: [
                  entry('수력발전설비:', c.water.name),
                  entry2('정격전압:', '${c.water.value1} V', '정격용량:',
                      '${c.ess.value2} kW'),
                ])),
      ]);
    } else {
      return Container();
    }
  }
}
