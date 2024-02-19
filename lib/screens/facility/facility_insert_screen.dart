import 'package:common_control/ccolumn.dart';
import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/cselectbutton.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/facility/facility_insert_controller.dart';
import 'package:zkeep/models/facility.dart';

class FacilityInsertScreen extends CWidget {
  FacilityInsertScreen({super.key});

  final c = Get.find<FacilityInsertController>();

  final titleStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Config.titleColor);
  final labelStyle = const TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return CFixedBottom(
        bottom: bottom(), children: [SingleChildScrollView(child: form())]);
  }

  form() {
    return Obx(
      () => CColumn(
        children: [
          basic(),
          receivingtype(),
          title('기타 전력 설비'),
          other(),
        ],
      ),
    );
  }

  bottom() {
    return CRow(padding: const EdgeInsets.only(bottom: 10), gap: 10, children: [
      CButton(
        text: '취소',
        flex: 1,
        size: CButtonSize.normal,
        type: CButtonStyle.outlined,
        onPressed: () => clickCancel(),
      ),
      CButton(
        text: '저장',
        flex: 1,
        size: CButtonSize.normal,
        onPressed: () => clickSave(),
      ),
    ]);
  }

  clickCancel() {
    Get.back();
  }

  clickSave() async {
    Get.back();
  }

  title(title, [Function()? onPlus]) {
    return CBothSide(
      children: [
        CText(
          title,
          textStyle: titleStyle,
          margin: const EdgeInsets.symmetric(vertical: 10),
        ),
        onPlus == null
            ? const SizedBox.shrink()
            : CContainer(
                onTap: onPlus, child: const Icon(CupertinoIcons.plus, size: 20))
      ],
    );
  }

  titleSwitch(title, value, Function(bool)? onChanged) {
    return CBothSide(
      children: [
        CText(
          title,
          textStyle: titleStyle,
          margin: const EdgeInsets.symmetric(vertical: 10),
        ),
        CupertinoSwitch(
          value: value,
          activeColor: Config.primaryColor,
          onChanged: onChanged,
        ),
      ],
    );
  }

  round(widgets) {
    return CRound(
        backgroundColor: Config.backgroundColor,
        child: CColumn(
            gap: 10,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widgets));
  }

  entry(title, widget) {
    return CRow(children: [
      CText(
        title,
        width: 70,
        textStyle: labelStyle,
      ),
      Expanded(child: widget)
    ]);
  }

  entry2(title, widget, title2, widget2) {
    return CRow(children: [
      CText(
        title,
        width: 70,
        textStyle: labelStyle,
      ),
      Expanded(child: widget),
      const SizedBox(width: 10),
      CText(
        title2,
        width: 70,
        textStyle: labelStyle,
      ),
      Expanded(child: widget2)
    ]);
  }

  entry3(title, widget, title2, widget2, title3, widget3) {
    return CRow(children: [
      CText(
        title,
        width: 70,
        textStyle: labelStyle,
      ),
      Expanded(child: widget),
      const SizedBox(width: 10),
      CText(
        title2,
        width: 20,
        textStyle: labelStyle,
      ),
      Expanded(child: widget2),
      const SizedBox(width: 10),
      CText(
        title2,
        width: 20,
        textStyle: labelStyle,
      ),
      Expanded(child: widget3)
    ]);
  }

  entryAdd(title, widget, click, expand) {
    return CRow(children: [
      CText(
        title,
        width: 70,
        textStyle: labelStyle,
      ),
      Expanded(child: widget),
      const SizedBox(width: 40),
      CContainer(
          onTap: () => click(),
          child: expand == true
              ? const Icon(CupertinoIcons.plus, size: 20)
              : const Icon(CupertinoIcons.minus, size: 20)),
    ]);
  }

  basic() {
    return CColumn(children: [
      titleSwitch('수전설비', c.toBoolean(c.item.value1), (bool val) {
        c.item.value1 = '$val';
      }),
      round(<Widget>[
        entry(
          '수전용량',
          CTextField(
            text: c.item.value2,
            onChanged: (value) => c.item.value2 = value,
            controller: c.item.extra['value2'],
            filledColor: Colors.white,
            suffixText: 'kW',
            textStyle: labelStyle,
          ),
        ),
        entry(
          '수전형태',
          CSelectbox(
            backgroundColor: Colors.white,
            items: c.types,
            selected: int.tryParse(c.item.value3) ?? 0,
            onSelected: (pos) {
              c.item.value3 = pos.toString();
              c.itemRedraw();
            },
          ),
        ),
        entry(
          '수전위치',
          CSelectbox(
            backgroundColor: Colors.white,
            items: c.positions,
            selected: int.tryParse(c.item.value4) ?? 0,
            onSelected: (pos) {
              c.item.value4 = pos.toString();
              c.itemRedraw();
            },
          ),
        ),
      ]),
      const SizedBox(height: 10),
      title('수배전설비'),
      round(<Widget>[
        entry(
            '수전전압',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.volts,
              selected: int.tryParse(c.item.value6) ?? 0,
              onSelected: (pos) {
                c.item.value6 = pos.toString();
                c.itemRedraw();
              },
            )),
        entry2(
            '형식',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.arrangementtypes,
              selected: int.tryParse(c.item.value7) ?? 0,
              onSelected: (pos) {
                c.item.value7 = pos.toString();
                c.itemRedraw();
              },
            ),
            '면수',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.faces,
              selected: int.tryParse(c.item.value8) ?? 0,
              onSelected: (pos) {
                c.item.value8 = pos.toString();
                c.itemRedraw();
              },
            )),
      ]),
      const SizedBox(height: 10),
      CColumn(
        gap: 10,
        children: [
          for (int i = 0; i < c.items.length; i++)
            distributation(c.items[i], i),
        ],
      ),
      manufacture(),
    ]);
  }

  distributation(items, index) {
    return round(<Widget>[
      entryAdd(
        '분배전 전압',
        CSelectbox(
          backgroundColor: Colors.white,
          items: c.volts,
          selected: int.tryParse(items.value1) ?? 0,
          onSelected: (pos) {
            items.value1 = pos.toString();
            c.itemsRedraw();
          },
        ),
        () {
          index == 0 ? c.items.add(Facility()) : c.remove(c.items, index);
        },
        index == 0 ? true : false,
      ),
      entry2(
          '형식',
          CSelectbox(
            backgroundColor: Colors.white,
            items: c.distributationtypes,
            selected: int.tryParse(items.value3) ?? 0,
            onSelected: (pos) {
              items.value3 = pos.toString();
              c.itemsRedraw();
            },
          ),
          '면수',
          CSelectbox(
            backgroundColor: Colors.white,
            items: c.faces,
            selected: int.tryParse(items.value4) ?? 0,
            onSelected: (pos) {
              items.value4 = pos.toString();
              c.itemsRedraw();
            },
          )),
    ]);
  }

  manufacture() {
    return CColumn(padding: const EdgeInsets.all(10), gap: 10, children: [
      entry2(
          '제조사',
          CTextField(
            textStyle: labelStyle,
            filledColor: Colors.white,
            text: c.item.value10,
            controller: c.item.extra['value10'],
            onChanged: (value) => c.item.value10 = value,
          ),
          '설치년월',
          CSelectbox(
            backgroundColor: Colors.white,
            items: c.years,
            selected: int.tryParse(c.item.value11) ?? 0,
            onSelected: (pos) {
              c.item.value11 = pos.toString();
              c.itemRedraw();
            },
          )),
      entry(
        '단선결선도',
        CButton(
          text: '첨부',
          size: CButtonSize.small,
          type: CButtonStyle.outlined,
          onPressed: () => {},
        ),
      )
    ]);
  }

  receivingtype() {
    if (c.item.value3 == '2') {
      return Column(children: [
        const SizedBox(height: 10),
        title('변전설비'),
        CColumn(
          gap: 10,
          children: [
            for (int i = 0; i < c.transs.length; i++) change(c.transs[i], i),
          ],
        ),
        const SizedBox(height: 10),
        title('고압차단기'),
        CColumn(
          gap: 10,
          children: [
            for (int i = 0; i < c.highs.length; i++) highBreaker(c.highs[i], i),
          ],
        ),
      ]);
    } else {
      return Container();
    }
  }

  change(transs, index) {
    return round(<Widget>[
      entryAdd(
        '설비명',
        CTextField(
          text: transs.value1,
          controller: transs.extra['value1'],
          onChanged: (value) => transs.value1 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        () {
          index == 0 ? c.transs.add(Facility()) : c.remove(c.transs, index);
        },
        index == 0 ? true : false,
      ),
      entry2(
        '형식',
        CSelectbox(
          backgroundColor: Colors.white,
          items: c.transstypes,
          selected: int.tryParse(transs.value2) ?? 0,
          onSelected: (pos) {
            transs.value2 = pos.toString();
            c.transsRedraw();
          },
        ),
        '정격용량',
        CTextField(
          text: transs.value3,
          controller: transs.extra['value3'],
          onChanged: (value) => transs.value3 = value,
          suffixText: 'kVA',
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '%Z',
        CTextField(
          text: transs.value4,
          controller: transs.extra['value4'],
          onChanged: (value) => transs.value4 = value,
          suffixText: '%',
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '정격전압',
        CTextField(
          text: transs.value5,
          controller: transs.extra['value5'],
          onChanged: (value) => transs.value5 = value,
          suffixText: 'V',
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '제조사',
        CTextField(
          text: transs.value6,
          controller: transs.extra['value6'],
          onChanged: (value) => transs.value6 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '제조번호',
        CTextField(
          text: transs.value7,
          controller: transs.extra['value7'],
          onChanged: (value) => transs.value7 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '제작년월',
        CRow(gap: 10, children: [
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: c.years,
              selected: int.tryParse(transs.value8) ?? 0,
              onSelected: (pos) {
                transs.value8 = pos.toString();
                c.transsRedraw();
              },
            ),
          ),
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: c.months,
              selected: int.tryParse(transs.value9) ?? 0,
              onSelected: (pos) {
                transs.value9 = pos.toString();
                c.transsRedraw();
              },
            ),
          ),
        ]),
      ),
    ]);
  }

  highBreaker(highs, index) {
    return round(<Widget>[
      entryAdd(
        '설치 장소',
        CTextField(
          text: highs.value1,
          controller: highs.extra['value1'],
          onChanged: (value) => highs.value1 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        () {
          index == 0 ? c.highs.add(Facility()) : c.remove(c.highs, index);
        },
        index == 0 ? true : false,
      ),
      entry2(
        '차단기명',
        CSelectbox(
          backgroundColor: Colors.white,
          items: c.breakers,
          selected: int.tryParse(highs.value2) ?? 0,
          onSelected: (pos) {
            highs.value2 = pos.toString();
            c.highsRedraw();
          },
        ),
        '차단용량',
        CTextField(
          text: highs.value3,
          controller: highs.extra['value3'],
          onChanged: (value) => highs.value3 = value,
          suffixText: 'kVA',
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '정격전압',
        CTextField(
          text: highs.value4,
          controller: highs.extra['value4'],
          onChanged: (value) => highs.value4 = value,
          suffixText: 'kV',
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '전류',
        CTextField(
          text: highs.value5,
          controller: highs.extra['value5'],
          onChanged: (value) => highs.value5 = value,
          suffixText: 'A',
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '제조사',
        CTextField(
          text: highs.value6,
          controller: highs.extra['value6'],
          onChanged: (value) => highs.value6 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '제조번호',
        CTextField(
          text: highs.value7,
          controller: highs.extra['value7'],
          onChanged: (value) => highs.value7 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '제작년월',
        CRow(gap: 10, children: [
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: c.years,
              selected: int.tryParse(highs.value8) ?? 0,
              onSelected: (pos) {
                highs.value8 = pos.toString();
                c.highsRedraw();
              },
            ),
          ),
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: c.months,
              selected: int.tryParse(highs.value9) ?? 0,
              onSelected: (pos) {
                highs.value9 = pos.toString();
                c.highsRedraw();
              },
            ),
          ),
        ]),
      ),
      const SizedBox(height: 10),
      CColumn(
        gap: 10,
        children: [
          // for (int i = 0; i < highs.content; i++)
          round(<Widget>[
            entryAdd(
              '계전기1',
              CSelectbox(
                backgroundColor: Colors.white,
                items: c.relays,
                selected: c.relay,
                onSelected: (pos) => c.relay = pos,
              ),
              () {
                index == 0
                    ? highs.centent.add(Facility())
                    : c.remove(highs.content, index);
              },
              index == 0 ? true : false,
            ),
            entry2(
              '제조사',
              CTextField(
                suffixText: '',
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
              '제작년도',
              CTextField(
                suffixText: '',
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
            entry2(
              '형식',
              CTextField(
                suffixText: '',
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
              '계전기번호',
              CTextField(
                suffixText: '',
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
            entry2(
                '설치장소',
                CTextField(
                  suffixText: '',
                  filledColor: Colors.white,
                  textStyle: labelStyle,
                ),
                '연결기기',
                CSelectbox(
                  backgroundColor: Colors.white,
                  items: c.breakers,
                  selected: c.relayconnect,
                  onSelected: (pos) => c.relayconnect = pos,
                )),
          ]),
        ],
      ),
    ]);
  }

  other() {
    return CColumn(gap: 10, children: [
      Wrap(
        children: [
          CSelectButton(
              items: const [
                '발전설비',
                '태양광 발전',
                '전기차 충전기',
                'ESS',
                'UPS',
                '연료전지',
                '풍려발전',
                '수력발전',
                '소방펌프 발전기',
                '공동주택 세대점검',
              ],
              index: 0,
              onSelected: (index) {
                // item.status = ItemStatus.values[index];
                // onSelected(item);
              })
        ],
      ),
      c.sunlight.name == "" ? Container() : sun(),
      c.charger.name == "" ? Container() : ev(),
      ess(),
      ups(),
      fuelcell(),
      wind(),
      hydro(),
    ]);
  }

  sun() {
    return round(<Widget>[
      entry(
        '태양광 발전',
        CTextField(
          text: c.sunlight.value1,
          controller: c.sunlight.extra['value1'],
          onChanged: (value) => c.sunlight.value1 = value,
          textStyle: labelStyle,
          filledColor: Colors.white,
        ),
      ),
      entry(
          '설치장소',
          CSelectbox(
            backgroundColor: Colors.white,
            items: c.place,
            selected: int.tryParse(c.sunlight.value2) ?? 0,
            onSelected: (pos) {
              c.sunlight.value2 = pos.toString();
              c.sunlightRedraw();
            },
          )),
      entry2(
        '발전전압',
        CTextField(
          text: c.sunlight.value3,
          controller: c.sunlight.extra['value3'],
          onChanged: (value) => c.sunlight.value3 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '발전용량',
        CTextField(
          text: c.sunlight.value4,
          controller: c.sunlight.extra['value4'],
          onChanged: (value) => c.sunlight.value4 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      CText('태양광 모듈'),
      entry2(
        '형식',
        CTextField(
          text: c.sunlight.value5,
          controller: c.sunlight.extra['value5'],
          onChanged: (value) => c.sunlight.value5 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '최대전력용량',
        CTextField(
          text: c.sunlight.value6,
          controller: c.sunlight.extra['value6'],
          onChanged: (value) => c.sunlight.value6 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'kW',
        ),
      ),
      entry2(
        '최대동작전압',
        CTextField(
          text: c.sunlight.value7,
          controller: c.sunlight.extra['value7'],
          onChanged: (value) => c.sunlight.value7 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '최대동작전류',
        CTextField(
          text: c.sunlight.value8,
          controller: c.sunlight.extra['value8'],
          onChanged: (value) => c.sunlight.value8 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'A',
        ),
      ),
      CText('인버터'),
      entry2(
        '형식',
        CTextField(
          text: c.sunlight.value9,
          controller: c.sunlight.extra['value9'],
          onChanged: (value) => c.sunlight.value9 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '정격용량',
        CTextField(
          text: c.sunlight.value10,
          controller: c.sunlight.extra['value10'],
          onChanged: (value) => c.sunlight.value10 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'kW',
        ),
      ),
      entry2(
        '최소 입력전압',
        CTextField(
          text: c.sunlight.value11,
          controller: c.sunlight.extra['value11'],
          onChanged: (value) => c.sunlight.value11 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'V',
        ),
        '최대 입력전압',
        CTextField(
          text: c.sunlight.value12,
          controller: c.sunlight.extra['value12'],
          onChanged: (value) => c.sunlight.value12 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'V',
        ),
      ),
      entry(
        '출력전압',
        CTextField(
          text: c.sunlight.value13,
          controller: c.sunlight.extra['value13'],
          onChanged: (value) => c.sunlight.value13 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'V',
        ),
      ),
    ]);
  }

  ev() {
    return round(<Widget>[
      CText('EV 충전기'),
      entry(
        '설비명',
        CTextField(
          text: c.charger.value1,
          controller: c.charger.extra['value1'],
          onChanged: (value) => c.charger.value1 = value,
          textStyle: labelStyle,
          filledColor: Colors.white,
        ),
      ),
      entry(
        '전력공급설비',
        CButton(
          text: '수배전설비와 동일',
          onPressed: () {},
        ),
      ),
      entry(
          '설치장소',
          CSelectbox(
            backgroundColor: Colors.white,
            items: c.evplace,
            selected: int.tryParse(c.charger.value2) ?? 0,
            onSelected: (pos) {
              c.charger.value2 = pos.toString();
              c.chargerRedraw();
            },
          )),
      entry2(
        '전압',
        CSelectbox(
          backgroundColor: Colors.white,
          items: c.voltage,
          selected: int.tryParse(c.charger.value3) ?? 0,
          onSelected: (pos) {
            c.charger.value3 = pos.toString();
            c.chargerRedraw();
          },
        ),
        '용량',
        CTextField(
          text: c.charger.value5,
          controller: c.charger.extra['value5'],
          onChanged: (value) => c.charger.value5 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'kW',
        ),
      ),
      entry(
        '충전설비',
        CText('총${c.chargertotal} kW'),
      ),
      for (int i = 0; i < c.chargeritems.length; i++)
        round(<Widget>[
          entryAdd(
            '충전기',
            CContainer(),
            () {
              i == 0
                  ? c.chargeritems.add(Facility())
                  : c.remove(c.chargeritems, i);
            },
            i == 0 ? true : false,
          ),
          entry2(
            '설치현황',
            CTextField(
              text: c.chargeritems[i].value1,
              controller: c.chargeritems[i].extra['value1'],
              onChanged: (value) => c.chargeritems[i].value1 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            'X',
            CTextField(
              text: c.chargeritems[i].value2,
              controller: c.chargeritems[i].extra['value2'],
              onChanged: (value) => c.chargeritems[i].value2 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry2(
            '설치장소',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.evplace,
              selected: int.tryParse(c.chargeritems[i].value3) ?? 0,
              onSelected: (pos) {
                c.chargeritems[i].value3 = pos.toString();
                c.chargeritemsRedraw();
              },
            ),
            '충전형식',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.evform,
              selected: int.tryParse(c.chargeritems[i].value4) ?? 0,
              onSelected: (pos) {
                c.chargeritems[i].value4 = pos.toString();
                c.chargeritemsRedraw();
              },
            ),
          ),
          entry2(
            '출력전압',
            CTextField(
              text: c.chargeritems[i].value5,
              controller: c.chargeritems[i].extra['value5'],
              onChanged: (value) => c.chargeritems[i].value5 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '충전용량',
            CTextField(
              text: c.chargeritems[i].value6,
              controller: c.chargeritems[i].extra['value6'],
              onChanged: (value) => c.chargeritems[i].value6 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry2(
            '제조사',
            CTextField(
              text: c.chargeritems[i].value7,
              controller: c.chargeritems[i].extra['value7'],
              onChanged: (value) => c.chargeritems[i].value7 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '모델명',
            CTextField(
              text: c.chargeritems[i].value8,
              controller: c.chargeritems[i].extra['value8'],
              onChanged: (value) => c.chargeritems[i].value8 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry(
            '제작년월',
            CRow(gap: 10, children: [
              Expanded(
                child: CSelectbox(
                  backgroundColor: Colors.white,
                  items: c.years,
                  selected: int.tryParse(c.chargeritems[i].value9) ?? 0,
                  onSelected: (pos) {
                    c.chargeritems[i].value9 = pos.toString();
                    c.chargeritemsRedraw();
                  },
                ),
              ),
              Expanded(
                child: CSelectbox(
                  backgroundColor: Colors.white,
                  items: c.months,
                  selected: int.tryParse(c.chargeritems[i].value10) ?? 0,
                  onSelected: (pos) {
                    c.chargeritems[i].value10 = pos.toString();
                    c.chargeritemsRedraw();
                  },
                ),
              ),
            ]),
          ),
        ]),
    ]);
  }

  ess() {
    return round(<Widget>[
      entry(
        '전기저장장치',
        CTextField(
          text: c.ess.value1,
          controller: c.ess.extra['value1'],
          onChanged: (value) => c.ess.value1 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      CText('전력변환장치(PCS)'),
      entry2(
        '출력전압',
        CSelectbox(
          backgroundColor: Colors.white,
          items: c.voltage,
          selected: int.tryParse(c.ess.value2) ?? 0,
          onSelected: (pos) {
            c.ess.value2 = pos.toString();
            c.essRedraw();
          },
        ),
        '정격용량',
        CTextField(
          text: c.ess.value4,
          controller: c.ess.extra['value4'],
          onChanged: (value) => c.ess.value4 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'kW',
        ),
      ),
      entry2(
        '입력전압',
        CTextField(
          text: c.ess.value5,
          controller: c.ess.extra['value5'],
          onChanged: (value) => c.ess.value5 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'V',
        ),
        '~',
        CTextField(
          text: c.ess.value6,
          controller: c.ess.extra['value6'],
          onChanged: (value) => c.ess.value6 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'V',
        ),
      ),
      entry2(
        '제조사',
        CTextField(
          text: c.ess.value7,
          controller: c.ess.extra['value7'],
          onChanged: (value) => c.ess.value7 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '제조번호',
        CTextField(
          text: c.ess.value8,
          controller: c.ess.extra['value8'],
          onChanged: (value) => c.ess.value8 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '제작년월',
        CRow(gap: 10, children: [
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: c.years,
              selected: int.tryParse(c.ess.value9) ?? 0,
              onSelected: (pos) {
                c.ess.value9 = pos.toString();
                c.essRedraw();
              },
            ),
          ),
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: c.months,
              selected: int.tryParse(c.ess.value10) ?? 0,
              onSelected: (pos) {
                c.ess.value10 = pos.toString();
                c.essRedraw();
              },
            ),
          ),
        ]),
      ),
      CText('배터리'),
      entry2(
        '최대저장용량',
        CTextField(
          text: c.ess.value11,
          controller: c.ess.extra['value11'],
          onChanged: (value) => c.ess.value11 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'kWh',
        ),
        '종류',
        CSelectbox(
          backgroundColor: Colors.white,
          items: c.esstype,
          selected: int.tryParse(c.ess.value12) ?? 0,
          onSelected: (pos) {
            c.ess.value12 = pos.toString();
            c.essRedraw();
          },
        ),
      ),
      entry3(
        '구성',
        CTextField(
          text: '셀',
          controller: c.ess.extra['value14'],
          onChanged: (value) => c.ess.value14 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        'X',
        CTextField(
          text: '팩',
          controller: c.ess.extra['value15'],
          onChanged: (value) => c.ess.value15 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        'X',
        CTextField(
          text: '렉',
          controller: c.ess.extra['value16'],
          onChanged: (value) => c.ess.value16 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '최대동작전압',
        CTextField(
          text: c.ess.value17,
          controller: c.ess.extra['value17'],
          onChanged: (value) => c.ess.value17 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'V',
        ),
        '최대동작전류',
        CTextField(
          text: c.ess.value18,
          controller: c.ess.extra['value18'],
          onChanged: (value) => c.ess.value18 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'A',
        ),
      ),
      entry2(
        '제조사',
        CTextField(
          text: c.ess.value19,
          controller: c.ess.extra['value19'],
          onChanged: (value) => c.ess.value19 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '형식',
        CTextField(
          text: c.ess.value20,
          controller: c.ess.extra['value20'],
          onChanged: (value) => c.ess.value20 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '제작년월',
        CRow(gap: 10, children: [
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: c.years,
              selected: int.tryParse(c.ess.value21) ?? 0,
              onSelected: (pos) {
                c.ess.value21 = pos.toString();
                c.essRedraw();
              },
            ),
          ),
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: c.months,
              selected: int.tryParse(c.ess.value22) ?? 0,
              onSelected: (pos) {
                c.ess.value22 = pos.toString();
                c.essRedraw();
              },
            ),
          ),
        ]),
      ),
    ]);
  }

  ups() {
    final upsplaces = CItem.list(['', '옥내', '옥상(컨테이너)', '옥외(전용건물)', '직접입력']);
    final cctv = CItem.list(['', '설치', '미설치']);
    final upsusage = CItem.list(['', '통신부하', '전산부하', '비상부하', '소방/EL등', '직접입력']);
    final upsmethod = CItem.list(['', '온라인', '오프라인']);
    final upsperiod = CItem.list(['', '보관안함', '보관(6개월)', '보관(1년)', '직력입력']);

    List<CItem> years = [CItem(id: 0, value: '')];
    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1970, value: '$i년'));
    }

    List<CItem> months = [CItem(id: 0, value: '')];

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }

    return round(<Widget>[
      CText('UPS'),
      entry2(
        '설치장소',
        CSelectbox(
          backgroundColor: Colors.white,
          items: upsplaces,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
        'CCTV',
        CSelectbox(
          backgroundColor: Colors.white,
          items: cctv,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
      ),
      entry(
        '상시운영정보 별도장소 보관 기간',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '용도',
        CSelectbox(
          backgroundColor: Colors.white,
          items: upsusage,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
        '방식',
        CSelectbox(
          backgroundColor: Colors.white,
          items: upsmethod,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
      ),
      entry(
        '비상전원공급 지속시간',
        CSelectbox(
          backgroundColor: Colors.white,
          items: upsperiod,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
      ),
      CText('전력변환장치'),
      entry2(
        '출력전압',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '정격용량',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '제조사',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '제작번호',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '제작년월',
        CRow(gap: 10, children: [
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: years,
              selected: c.changeyear,
              onSelected: (pos) => c.changeyear = pos,
            ),
          ),
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: months,
              selected: c.changemonth,
              onSelected: (pos) => c.changemonth = pos,
            ),
          ),
        ]),
      ),
      CText('이차전지(배터리)'),
      entry2(
        '용량',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '종류',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '제조사',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '제작년도',
        CSelectbox(
          backgroundColor: Colors.white,
          items: years,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
      ),
    ]);
  }

  wind() {
    List<CItem> years = [CItem(id: 0, value: '')];
    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1970, value: '$i년'));
    }

    List<CItem> months = [CItem(id: 0, value: '')];

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }

    return round(<Widget>[
      CText('풍력발전소'),
      CText('풍차설비'),
      entry2(
        '형식',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '정격용량',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '제조사',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '제조번호',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '제작년월',
        CRow(gap: 10, children: [
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: years,
              selected: c.changeyear,
              onSelected: (pos) => c.changeyear = pos,
            ),
          ),
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: months,
              selected: c.changemonth,
              onSelected: (pos) => c.changemonth = pos,
            ),
          ),
        ]),
      ),
      entry(
        '풍차날개',
        CRow(
          gap: 10,
          children: [
            Expanded(
              child: CTextField(
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
            Expanded(
              child: CTextField(
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
          ],
        ),
      ),
      entry(
        '풍향조건',
        CRow(
          gap: 10,
          children: [
            Expanded(
              child: CTextField(
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
            Expanded(
              child: CTextField(
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
            Expanded(
              child: CTextField(
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
          ],
        ),
      ),
      CText('발전설비'),
      entry2(
        '형식',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '정격용량',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '제조사',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '제조번호',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '제작년월',
        CRow(gap: 10, children: [
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: years,
              selected: c.changeyear,
              onSelected: (pos) => c.changeyear = pos,
            ),
          ),
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: months,
              selected: c.changemonth,
              onSelected: (pos) => c.changemonth = pos,
            ),
          ),
        ]),
      ),
      entry2(
        '극수',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '역률',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '정격전압',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '정격전류',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '절연저항',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '접지저항',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
    ]);
  }

  hydro() {
    return round(<Widget>[
      CText('수력발전설비'),
      entry2(
        '정격전압',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '정격용량',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
    ]);
  }

  fuelcell() {
    final gass = CItem.list(['', '도시가스', 'LPG', '바이오가스', '직접입력']);
    final placemethods = CItem.list(['', '옥상형', '옥외형']);
    final places = CItem.list(['', '독립형', '계통연계형']);
    List<CItem> years = [CItem(id: 0, value: '')];
    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1970, value: '$i년'));
    }

    List<CItem> months = [CItem(id: 0, value: '')];

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }

    return round(<Widget>[
      CText('연료전지 발전설비'),
      entry2(
        '형식',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '사용가스',
        CSelectbox(
          backgroundColor: Colors.white,
          items: gass,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
      ),
      entry2(
        '정격출력',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '가스소비량',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '가스압력범위',
        CRow(gap: 10, children: [
          Expanded(
            child: CTextField(
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          CText('~'),
          Expanded(
            child: CTextField(
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
        ]),
      ),
      entry2(
        '정격전압',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '주파수',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '발전효율',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '열효율',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '계통연계',
        CSelectbox(
          backgroundColor: Colors.white,
          items: placemethods,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
        '설치위치',
        CSelectbox(
          backgroundColor: Colors.white,
          items: places,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
      ),
      entry2(
        '급배기방식',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '배기통길이',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '제조사',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '제조번호',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '제작년월',
        CRow(gap: 10, children: [
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: years,
              selected: c.changeyear,
              onSelected: (pos) => c.changeyear = pos,
            ),
          ),
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: months,
              selected: c.changemonth,
              onSelected: (pos) => c.changemonth = pos,
            ),
          ),
        ]),
      ),
    ]);
  }
}
