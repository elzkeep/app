import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/dselectbutton.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/facility/facility_insert_controller.dart';
import 'package:zkeep/models/facilityitem.dart';

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
    await c.save();
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
              c.item.value5 = '';
              c.item.extra['value5'].text = '';
              c.item.value4 = pos.toString();
              c.itemRedraw();
            },
          ),
        ),
        if (c.item.value4 == '7')
          entry(
            '수전위치',
            CTextField(
              text: c.item.value5,
              onChanged: (value) => c.item.value5 = value,
              controller: c.item.extra['value5'],
              filledColor: Colors.white,
              textStyle: labelStyle,
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
                c.item.value7 = '';
                c.item.extra['value7'].text = '';
                c.item.value6 = pos.toString();
                c.itemRedraw();
              },
            )),
        if (c.item.value6 == '3')
          entry(
            '수전전압',
            CTextField(
              text: c.item.value7,
              onChanged: (value) => c.item.value7 = value,
              controller: c.item.extra['value7'],
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
        entry(
          '형식',
          CSelectbox(
            backgroundColor: Colors.white,
            items: c.arrangementtypes,
            selected: int.tryParse(c.item.value8) ?? 0,
            onSelected: (pos) {
              c.item.value8 = pos.toString();
              c.itemRedraw();
            },
          ),
        ),
        entry(
          '면수',
          CSelectbox(
            backgroundColor: Colors.white,
            items: c.faces,
            selected: int.tryParse(c.item.value9) ?? 0,
            onSelected: (pos) {
              c.item.value10 = '';
              c.item.extra['value10'].text = '';
              c.item.value9 = pos.toString();
              c.itemRedraw();
            },
          ),
        ),
        if (c.item.value9 == '13')
          entry(
            '면수',
            CTextField(
              text: c.item.value10,
              onChanged: (value) => c.item.value10 = value,
              controller: c.item.extra['value10'],
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
      ]),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: c.items.length,
        itemBuilder: (context, index) {
          return distributation(c.items[index], index);
        },
      ),
      manufacture(),
    ]);
  }

  distributation(items, index) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: round(
        <Widget>[
          entryAdd(
            '분배전 전압',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.volts,
              selected: int.tryParse(items.value1) ?? 0,
              onSelected: (pos) {
                items.value2 = '';
                items.extra['value2'].text = '';
                items.value1 = pos.toString();
                c.itemsRedraw();
              },
            ),
            () {
              index == 0
                  ? c.addItem(c.items, 'items')
                  : c.remove(c.items, index);
            },
            index == 0 ? true : false,
          ),
          if (items.value1 == '3')
            entry(
              '분배전 전압',
              CTextField(
                text: items.value2,
                onChanged: (value) => items.value2 = value,
                controller: items.extra['value2'],
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
          entry(
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
          ),
          entry(
            '면수',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.faces,
              selected: int.tryParse(items.value4) ?? 0,
              onSelected: (pos) {
                items.value5 = '';
                items.extra['value5'].text = '';
                items.value4 = pos.toString();
                c.itemsRedraw();
              },
            ),
          ),
          if (items.value4 == '13')
            entry(
              '면수',
              CTextField(
                text: items.value5,
                onChanged: (value) => items.value5 = value,
                controller: items.extra['value5'],
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
        ],
      ),
    );
  }

  manufacture() {
    return CColumn(padding: const EdgeInsets.all(10), gap: 10, children: [
      entry2(
          '제조사',
          CTextField(
            textStyle: labelStyle,
            filledColor: Colors.white,
            text: c.item.value11,
            controller: c.item.extra['value11'],
            onChanged: (value) => c.item.value11 = value,
          ),
          '설치년월',
          CSelectbox(
            backgroundColor: Colors.white,
            items: c.years,
            selected: int.tryParse(c.item.value12) ?? 0,
            onSelected: (pos) {
              c.item.value12 = pos.toString();
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
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: c.transs.length,
          itemBuilder: (context, index) {
            return change(c.transs[index], index);
          },
        ),
        const SizedBox(height: 10),
        title('고압차단기'),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: c.highs.length,
          itemBuilder: (context, index) {
            return highBreaker(c.highs[index], index);
          },
        ),
      ]);
    } else {
      return Container();
    }
  }

  change(transs, index) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: round(
        <Widget>[
          entryAdd(
            '설비명',
            CTextField(
              text: transs.name,
              controller: transs.extra['name'],
              onChanged: (value) => transs.name = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            () {
              index == 0
                  ? c.addItem(c.transs, 'transs')
                  : c.remove(c.transs, index);
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
        ],
      ),
    );
  }

  highBreaker(highs, index) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: round(
        <Widget>[
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
              index == 0
                  ? c.addItem(c.highs, 'highs')
                  : c.remove(c.highs, index);
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
              for (int i = 0; i < highs.contents.length; i++)
                round(<Widget>[
                  entryAdd(
                    '계전기1',
                    CTextField(
                      text: highs.contents[i].value1,
                      controller: highs.contents[i].extra['value1'],
                      onChanged: (value) => highs.contents[i].value1 = value,
                      filledColor: Colors.white,
                      textStyle: labelStyle,
                    ),
                    () {
                      if (i == 0) {
                        highs.contents.add(FacilityItem());
                        c.highsRedraw();
                      } else {
                        c.remove(highs.contents, i);
                      }
                    },
                    i == 0 ? true : false,
                  ),
                  entry2(
                    '제조사',
                    CSelectbox(
                      backgroundColor: Colors.white,
                      items: c.relays,
                      selected: int.tryParse(highs.contents[i].value2) ?? 0,
                      onSelected: (pos) {
                        highs.contents[i].value2 = pos.toString();
                        c.highsRedraw();
                      },
                    ),
                    '제작년도',
                    CTextField(
                      text: highs.contents[i].value3,
                      controller: highs.contents[i].extra['value3'],
                      onChanged: (value) => highs.contents[i].value3 = value,
                      filledColor: Colors.white,
                      textStyle: labelStyle,
                    ),
                  ),
                  entry2(
                    '형식',
                    CTextField(
                      text: highs.contents[i].value4,
                      controller: highs.contents[i].extra['value4'],
                      onChanged: (value) => highs.contents[i].value4 = value,
                      filledColor: Colors.white,
                      textStyle: labelStyle,
                    ),
                    '계전기번호',
                    CTextField(
                      text: highs.contents[i].value5,
                      controller: highs.contents[i].extra['value5'],
                      onChanged: (value) => highs.contents[i].value5 = value,
                      filledColor: Colors.white,
                      textStyle: labelStyle,
                    ),
                  ),
                  entry2(
                      '설치장소',
                      CTextField(
                        text: highs.contents[i].value6,
                        controller: highs.contents[i].extra['value6'],
                        onChanged: (value) => highs.contents[i].value6 = value,
                        filledColor: Colors.white,
                        textStyle: labelStyle,
                      ),
                      '연결기기',
                      CSelectbox(
                        backgroundColor: Colors.white,
                        items: c.years,
                        selected: int.tryParse(highs.contents[i].value7) ?? 0,
                        onSelected: (pos) {
                          highs.as[i].value7 = pos.toString();
                          c.highsRedraw();
                        },
                      )),
                ]),
            ],
          ),
        ],
      ),
    );
  }

  other() {
    return CColumn(children: [
      DSelectButton(
          items: const [
            '발전설비',
            '태양광 발전',
            '전기차 충전기',
            'ESS',
            'UPS',
            '연료전지',
            '풍력발전',
            '수력발전',
            // '소방펌프 발전기',
            // '공동주택 세대점검',
          ],
          index: 0,
          data: c.other,
          onSelected: (index) {
            c.other[index - 1] = !c.other[index - 1];
          }),
      c.other[0] == false ? Container() : loopgenerator(),
      const SizedBox(height: 10),
      c.other[1] == false ? Container() : sun(),
      const SizedBox(height: 10),
      c.other[2] == false ? Container() : ev(),
      const SizedBox(height: 10),
      c.other[3] == false ? Container() : ess(),
      c.other[4] == false ? Container() : loopups(),
      c.other[5] == false ? Container() : loopfuel(),
      c.other[6] == false ? Container() : loopwind(),
      const SizedBox(height: 10),
      c.other[7] == false ? Container() : water(),
      const SizedBox(height: 30),
    ]);
  }

  loopgenerator() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: c.generator.length,
      itemBuilder: (context, index) {
        return generator(c.generator[index], index);
      },
    );
  }

  generator(generator, index) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: round(
        <Widget>[
          entryAdd(
            '발전설비',
            CTextField(
              text: generator.name,
              controller: generator.extra['name'],
              onChanged: (value) => generator.name = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            () {
              index == 0
                  ? c.addItem(c.generator, 'generator')
                  : c.remove(c.generator, index);
            },
            index == 0 ? true : false,
          ),
          entry2(
            '원동기',
            Container(),
            '발전기',
            Container(),
          ),
          entry2(
            '형식(모델명)',
            CTextField(
              text: generator.value2,
              controller: generator.extra['value2'],
              onChanged: (value) => generator.value2 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '형식(모델명)',
            CTextField(
              text: generator.value11,
              controller: generator.extra['value11'],
              onChanged: (value) => generator.value11 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry2(
            '정격용량',
            CTextField(
              text: generator.value3,
              controller: generator.extra['value3'],
              onChanged: (value) => generator.value3 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'kVA',
            ),
            '정격용량',
            CTextField(
              text: generator.value12,
              controller: generator.extra['value12'],
              onChanged: (value) => generator.value12 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'kVA',
            ),
          ),
          entry2(
            '회전수',
            CTextField(
              text: generator.value4,
              controller: generator.extra['value4'],
              onChanged: (value) => generator.value4 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'rpm',
            ),
            '회전수',
            CTextField(
              text: generator.value13,
              controller: generator.extra['value13'],
              onChanged: (value) => generator.value13 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'rpm',
            ),
          ),
          entry2(
            '제조사',
            CTextField(
              text: generator.value5,
              controller: generator.extra['value5'],
              onChanged: (value) => generator.value5 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '제조사',
            CTextField(
              text: generator.value14,
              controller: generator.extra['value14'],
              onChanged: (value) => generator.value14 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry2(
            '제작번호',
            CTextField(
              text: generator.value6,
              controller: generator.extra['value6'],
              onChanged: (value) => generator.value6 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '제작번호',
            CTextField(
              text: generator.value15,
              controller: generator.extra['value15'],
              onChanged: (value) => generator.value15 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry2(
            '제작년월',
            CTextField(
              text: generator.value7,
              controller: generator.extra['value7'],
              onChanged: (value) => generator.value7 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '제작년월',
            CTextField(
              text: generator.value16,
              controller: generator.extra['value16'],
              onChanged: (value) => generator.value16 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry2(
            '냉각방식',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.coolings,
              selected: int.tryParse(generator.value8) ?? 0,
              onSelected: (pos) {
                generator.value8 = pos.toString();
                c.generatorRedraw();
              },
            ),
            '정격전압',
            CTextField(
              text: generator.value17,
              controller: generator.extra['value17'],
              onChanged: (value) => generator.value17 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'V',
            ),
          ),
          entry2(
            '기동방식',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.activations,
              selected: int.tryParse(generator.value9) ?? 0,
              onSelected: (pos) {
                generator.value9 = pos.toString();
                c.generatorRedraw();
              },
            ),
            '정격전류',
            CTextField(
              text: generator.value18,
              controller: generator.extra['value18'],
              onChanged: (value) => generator.value18 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'A',
            ),
          ),
          entry2(
            '차단기종류',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.generatortype,
              selected: int.tryParse(generator.value10) ?? 0,
              onSelected: (pos) {
                generator.value10 = pos.toString();
                c.generatorRedraw();
              },
            ),
            '역률',
            CTextField(
              text: generator.value19,
              controller: generator.extra['value19'],
              onChanged: (value) => generator.value19 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: '%',
            ),
          ),
        ],
      ),
    );
  }

  sun() {
    return round(<Widget>[
      entry(
        '태양광 발전',
        CTextField(
          text: c.sunlight.name,
          controller: c.sunlight.extra['name'],
          onChanged: (value) => c.sunlight.name = value,
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
            c.sunlight.value3 = '';
            c.sunlight.extra['value3'].text = '';
            c.sunlight.value2 = pos.toString();
            c.sunlightRedraw();
          },
        ),
      ),
      if (c.sunlight.value2 == '4')
        entry(
          '설치장소',
          CTextField(
            text: c.sunlight.value3,
            onChanged: (value) => c.sunlight.value3 = value,
            controller: c.sunlight.extra['value3'],
            filledColor: Colors.white,
            textStyle: labelStyle,
          ),
        ),
      entry(
        '발전전압',
        CSelectbox(
          backgroundColor: Colors.white,
          items: c.voltage,
          selected: int.tryParse(c.sunlight.value4) ?? 0,
          onSelected: (pos) {
            c.sunlight.value5 = '';
            c.sunlight.extra['value5'].text = '';
            c.sunlight.value4 = pos.toString();
            c.sunlightRedraw();
          },
        ),
      ),
      if (c.sunlight.value4 == '3')
        entry(
          '발전전압',
          CTextField(
            text: c.sunlight.value5,
            onChanged: (value) => c.sunlight.value5 = value,
            controller: c.sunlight.extra['value5'],
            filledColor: Colors.white,
            textStyle: labelStyle,
          ),
        ),
      entry(
        '발전용량',
        CTextField(
          text: c.sunlight.value6,
          controller: c.sunlight.extra['value6'],
          onChanged: (value) => c.sunlight.value6 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      CText('태양광 모듈'),
      entry2(
        '형식',
        CTextField(
          text: c.sunlight.value7,
          controller: c.sunlight.extra['value7'],
          onChanged: (value) => c.sunlight.value7 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '최대전력용량',
        CTextField(
          text: c.sunlight.value8,
          controller: c.sunlight.extra['value8'],
          onChanged: (value) => c.sunlight.value8 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'kW',
        ),
      ),
      entry2(
        '최대동작전압',
        CTextField(
          text: c.sunlight.value9,
          controller: c.sunlight.extra['value9'],
          onChanged: (value) => c.sunlight.value9 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'V',
        ),
        '최대동작전류',
        CTextField(
          text: c.sunlight.value10,
          controller: c.sunlight.extra['value10'],
          onChanged: (value) => c.sunlight.value10 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'A',
        ),
      ),
      CText('인버터'),
      entry2(
        '형식',
        CTextField(
          text: c.sunlight.value11,
          controller: c.sunlight.extra['value11'],
          onChanged: (value) => c.sunlight.value11 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '정격용량',
        CTextField(
          text: c.sunlight.value12,
          controller: c.sunlight.extra['value12'],
          onChanged: (value) => c.sunlight.value12 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'kW',
        ),
      ),
      entry2(
        '최소 입력전압',
        CTextField(
          text: c.sunlight.value13,
          controller: c.sunlight.extra['value13'],
          onChanged: (value) => c.sunlight.value13 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'V',
        ),
        '최대 입력전압',
        CTextField(
          text: c.sunlight.value14,
          controller: c.sunlight.extra['value14'],
          onChanged: (value) => c.sunlight.value14 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'V',
        ),
      ),
      entry(
        '출력전압',
        CTextField(
          text: c.sunlight.value15,
          controller: c.sunlight.extra['value15'],
          onChanged: (value) => c.sunlight.value15 = value,
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
          text: c.charger.name,
          controller: c.charger.extra['name'],
          onChanged: (value) => c.charger.name = value,
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
        CTextField(
          text: c.charger.value2,
          onChanged: (value) => c.charger.value2 = value,
          controller: c.charger.extra['value2'],
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '전압',
        CSelectbox(
          backgroundColor: Colors.white,
          items: c.voltage,
          selected: int.tryParse(c.charger.value3) ?? 0,
          onSelected: (pos) {
            c.charger.value4 = '';
            c.charger.extra['value4'].text = '';
            c.charger.value3 = pos.toString();
            c.chargerRedraw();
          },
        ),
      ),
      if (c.charger.value3 == '3')
        entry(
          '전압',
          CTextField(
            text: c.charger.value4,
            onChanged: (value) => c.charger.value4 = value,
            controller: c.charger.extra['value4'],
            filledColor: Colors.white,
            textStyle: labelStyle,
          ),
        ),
      entry(
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
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: c.chargeritems.length,
        itemBuilder: (context, index) {
          return chargerItem(c.chargeritems[index], index);
        },
      ),
    ]);
  }

  chargerItem(chargeritems, index) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: round(
        <Widget>[
          entryAdd(
            '충전기',
            CContainer(),
            () {
              index == 0
                  ? c.addItem(c.chargeritems, 'chargeritems')
                  : c.remove(c.chargeritems, index);
            },
            index == 0 ? true : false,
          ),
          entry2(
            '설치현황',
            CTextField(
              text: chargeritems.value1,
              controller: chargeritems.extra['value1'],
              onChanged: (value) => chargeritems.value1 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            'X',
            CTextField(
              text: chargeritems.value2,
              controller: chargeritems.extra['value2'],
              onChanged: (value) => chargeritems.value2 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry(
            '설치장소',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.evplace,
              selected: int.tryParse(chargeritems.value3) ?? 0,
              onSelected: (pos) {
                chargeritems.value4 = '';
                chargeritems.extra['value4'].text = '';
                chargeritems.value3 = pos.toString();
                c.chargeritemsRedraw();
              },
            ),
          ),
          if (chargeritems.value3 == '3')
            entry(
              '설치장소',
              CTextField(
                text: chargeritems.value4,
                onChanged: (value) => chargeritems.value4 = value,
                controller: chargeritems.extra['value4'],
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
          entry(
            '충전형식',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.evform,
              selected: int.tryParse(chargeritems.value5) ?? 0,
              onSelected: (pos) {
                chargeritems.value5 = pos.toString();
                c.chargeritemsRedraw();
              },
            ),
          ),
          entry2(
            '출력전압',
            CTextField(
              text: chargeritems.value6,
              controller: chargeritems.extra['value6'],
              onChanged: (value) => chargeritems.value6 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '충전용량',
            CTextField(
              text: chargeritems.value7,
              controller: chargeritems.extra['value7'],
              onChanged: (value) => chargeritems.value7 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry2(
            '제조사',
            CTextField(
              text: chargeritems.value8,
              controller: chargeritems.extra['value8'],
              onChanged: (value) => chargeritems.value8 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '모델명',
            CTextField(
              text: chargeritems.value9,
              controller: chargeritems.extra['value9'],
              onChanged: (value) => chargeritems.value9 = value,
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
                  selected: int.tryParse(chargeritems.value10) ?? 0,
                  onSelected: (pos) {
                    chargeritems.value10 = pos.toString();
                    c.chargeritemsRedraw();
                  },
                ),
              ),
              Expanded(
                child: CSelectbox(
                  backgroundColor: Colors.white,
                  items: c.months,
                  selected: int.tryParse(chargeritems.value11) ?? 0,
                  onSelected: (pos) {
                    chargeritems.value11 = pos.toString();
                    c.chargeritemsRedraw();
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  ess() {
    return round(<Widget>[
      entry(
        '전기저장장치',
        CTextField(
          text: c.ess.name,
          controller: c.ess.extra['name'],
          onChanged: (value) => c.ess.name = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      CText('전력변환장치(PCS)'),
      entry(
        '출력전압',
        CSelectbox(
          backgroundColor: Colors.white,
          items: c.voltage,
          selected: int.tryParse(c.ess.value2) ?? 0,
          onSelected: (pos) {
            c.ess.value3 = '';
            c.ess.extra['value3'].text = '';
            c.ess.value2 = pos.toString();
            c.essRedraw();
          },
        ),
      ),
      if (c.ess.value2 == '3')
        entry(
          '출력전압',
          CTextField(
            text: c.ess.value3,
            controller: c.ess.extra['value3'],
            onChanged: (value) => c.ess.value3 = value,
            filledColor: Colors.white,
            textStyle: labelStyle,
            suffixText: 'kW',
          ),
        ),
      entry(
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
      entry(
        '최대저장용량',
        CTextField(
          text: c.ess.value11,
          controller: c.ess.extra['value11'],
          onChanged: (value) => c.ess.value11 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'kWh',
        ),
      ),
      entry(
        '종류',
        CSelectbox(
          backgroundColor: Colors.white,
          items: c.esstype,
          selected: int.tryParse(c.ess.value12) ?? 0,
          onSelected: (pos) {
            c.ess.value13 = '';
            c.ess.extra['value13'].text = '';
            c.ess.value12 = pos.toString();
            c.essRedraw();
          },
        ),
      ),
      if (c.ess.value12 == '7')
        entry(
          '종류',
          CTextField(
            text: c.ess.value13,
            controller: c.ess.extra['value13'],
            onChanged: (value) => c.ess.value13 = value,
            filledColor: Colors.white,
            textStyle: labelStyle,
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

  loopups() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: c.ups.length,
      itemBuilder: (context, index) {
        return ups(c.ups[index], index);
      },
    );
  }

  ups(ups, index) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: round(
        <Widget>[
          entryAdd(
            'UPS',
            CTextField(
              text: ups.name,
              controller: ups.extra['name'],
              onChanged: (value) => ups.name = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            () {
              index == 0 ? c.addItem(c.ups, 'ups') : c.remove(c.ups, index);
            },
            index == 0 ? true : false,
          ),
          entry(
            '설치장소',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.upspositions,
              selected: int.tryParse(ups.value1) ?? 0,
              onSelected: (pos) {
                ups.value2 = '';
                ups.extra['value2'].text = '';
                ups.value1 = pos.toString();
                c.upsRedraw();
              },
            ),
          ),
          if (ups.value1 == '4')
            entry(
              '설치장소',
              CTextField(
                text: ups.value2,
                onChanged: (value) => ups.value2 = value,
                controller: ups.extra['value2'],
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
          entry(
            'CCTV',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.upscctvs,
              selected: int.tryParse(ups.value3) ?? 0,
              onSelected: (pos) {
                ups.value3 = pos.toString();
                c.upsRedraw();
              },
            ),
          ),
          entry(
            '상시운영정보 별도장소 보관 기간',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.upskeeps,
              selected: int.tryParse(ups.value4) ?? 0,
              onSelected: (pos) {
                ups.value5 = '';
                ups.extra['value5'].text = '';
                ups.value4 = pos.toString();
                c.upsRedraw();
              },
            ),
          ),
          if (ups.value4 == '4')
            entry(
              '상시운영정보 별도장소 보관 기간',
              CTextField(
                text: ups.value5,
                onChanged: (value) => ups.value5 = value,
                controller: ups.extra['value5'],
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
          entry(
            '용도',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.upsusages,
              selected: int.tryParse(ups.value6) ?? 0,
              onSelected: (pos) {
                ups.value7 = '';
                ups.extra['value7'].text = '';
                ups.value6 = pos.toString();
                c.upsRedraw();
              },
            ),
          ),
          if (ups.value6 == '5')
            entry(
              '용도',
              CTextField(
                text: ups.value7,
                onChanged: (value) => ups.value7 = value,
                controller: ups.extra['value7'],
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
          entry(
            '방식',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.upstypes,
              selected: int.tryParse(ups.value8) ?? 0,
              onSelected: (pos) {
                ups.value8 = pos.toString();
                c.upsRedraw();
              },
            ),
          ),
          entry(
            '비상전원공급 지속시간',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.upstimes,
              selected: int.tryParse(ups.value9) ?? 0,
              onSelected: (pos) {
                ups.value10 = '';
                ups.extra['value10'].text = '';
                ups.value9 = pos.toString();
                c.upsRedraw();
              },
            ),
          ),
          if (ups.value9 == '6')
            entry(
              '비상전원공급 지속시간',
              CTextField(
                text: ups.value10,
                onChanged: (value) => ups.value10 = value,
                controller: ups.extra['value10'],
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
          CText('전력변환장치'),
          entry2(
            '출력전압',
            CTextField(
              text: ups.value11,
              controller: ups.extra['value11'],
              onChanged: (value) => ups.value11 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'V',
            ),
            '정격용량',
            CTextField(
              text: ups.value12,
              controller: ups.extra['value12'],
              onChanged: (value) => ups.value12 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'kVA',
            ),
          ),
          entry2(
            '제조사',
            CTextField(
              text: ups.value13,
              controller: ups.extra['value13'],
              onChanged: (value) => ups.value13 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '제작번호',
            CTextField(
              text: ups.value14,
              controller: ups.extra['value14'],
              onChanged: (value) => ups.value14 = value,
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
                  selected: int.tryParse(ups.value15) ?? 0,
                  onSelected: (pos) {
                    ups.value15 = pos.toString();
                    c.upsRedraw();
                  },
                ),
              ),
              Expanded(
                child: CSelectbox(
                  backgroundColor: Colors.white,
                  items: c.months,
                  selected: int.tryParse(ups.value16) ?? 0,
                  onSelected: (pos) {
                    ups.value16 = pos.toString();
                    c.upsRedraw();
                  },
                ),
              ),
            ]),
          ),
          CText('이차전지(배터리)'),
          entry2(
            '용량',
            CTextField(
              text: ups.value17,
              controller: ups.extra['value17'],
              onChanged: (value) => ups.value17 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'kW',
            ),
            '종류',
            CTextField(
              text: ups.value18,
              controller: ups.extra['value18'],
              onChanged: (value) => ups.value18 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'V',
            ),
          ),
          entry2(
            '제조사',
            CTextField(
              text: ups.value19,
              controller: ups.extra['value19'],
              onChanged: (value) => ups.value19 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '제작년도',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.years,
              selected: int.tryParse(ups.value20) ?? 0,
              onSelected: (pos) {
                ups.value20 = pos.toString();
                c.upsRedraw();
              },
            ),
          ),
        ],
      ),
    );
  }

  loopwind() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: c.wind.length,
      itemBuilder: (context, index) {
        return wind(c.wind[index], index);
      },
    );
  }

  wind(wind, index) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: round(
        <Widget>[
          entryAdd(
            '풍력발전소',
            CTextField(
              text: wind.name,
              controller: wind.extra['name'],
              onChanged: (value) => wind.name = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            () {
              index == 0 ? c.addItem(c.wind, 'wind') : c.remove(c.wind, index);
            },
            index == 0 ? true : false,
          ),
          CText('풍차설비'),
          entry2(
            '형식',
            CTextField(
              text: wind.value1,
              controller: wind.extra['value1'],
              onChanged: (value) => wind.value1 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '정격용량',
            CTextField(
              text: wind.value2,
              controller: wind.extra['value2'],
              onChanged: (value) => wind.value2 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'kW',
            ),
          ),
          entry2(
            '제조사',
            CTextField(
              text: wind.value3,
              controller: wind.extra['value3'],
              onChanged: (value) => wind.value3 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '제조번호',
            CTextField(
              text: wind.value4,
              controller: wind.extra['value4'],
              onChanged: (value) => wind.value4 = value,
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
                  selected: int.tryParse(wind.value5) ?? 0,
                  onSelected: (pos) {
                    wind.value5 = pos.toString();
                    c.windRedraw();
                  },
                ),
              ),
              Expanded(
                child: CSelectbox(
                  backgroundColor: Colors.white,
                  items: c.months,
                  selected: int.tryParse(wind.value6) ?? 0,
                  onSelected: (pos) {
                    wind.value6 = pos.toString();
                    c.windRedraw();
                  },
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
                    text: wind.value7,
                    controller: wind.extra['value7'],
                    onChanged: (value) => wind.value7 = value,
                    filledColor: Colors.white,
                    textStyle: labelStyle,
                    suffixText: '개',
                  ),
                ),
                Expanded(
                  child: CTextField(
                    text: wind.value8,
                    controller: wind.extra['value8'],
                    onChanged: (value) => wind.value8 = value,
                    filledColor: Colors.white,
                    textStyle: labelStyle,
                    suffixText: 'm',
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
                    text: wind.value9,
                    controller: wind.extra['value9'],
                    onChanged: (value) => wind.value9 = value,
                    filledColor: Colors.white,
                    textStyle: labelStyle,
                    suffixText: 'm/s',
                  ),
                ),
                Expanded(
                  child: CTextField(
                    text: wind.value10,
                    controller: wind.extra['value10'],
                    onChanged: (value) => wind.value10 = value,
                    filledColor: Colors.white,
                    textStyle: labelStyle,
                    suffixText: 'm/s',
                  ),
                ),
                Expanded(
                  child: CTextField(
                    text: wind.value11,
                    controller: wind.extra['value11'],
                    onChanged: (value) => wind.value11 = value,
                    filledColor: Colors.white,
                    textStyle: labelStyle,
                    suffixText: 'm/s',
                  ),
                ),
              ],
            ),
          ),
          CText('발전설비'),
          entry2(
            '형식',
            CTextField(
              text: wind.value12,
              controller: wind.extra['value12'],
              onChanged: (value) => wind.value12 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '정격용량',
            CTextField(
              text: wind.value13,
              controller: wind.extra['value13'],
              onChanged: (value) => wind.value13 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'kW',
            ),
          ),
          entry2(
            '제조사',
            CTextField(
              text: wind.value14,
              controller: wind.extra['value14'],
              onChanged: (value) => wind.value14 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '제조번호',
            CTextField(
              text: wind.value15,
              controller: wind.extra['value15'],
              onChanged: (value) => wind.value15 = value,
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
                  selected: int.tryParse(wind.value16) ?? 0,
                  onSelected: (pos) {
                    wind.value16 = pos.toString();
                    c.windRedraw();
                  },
                ),
              ),
              Expanded(
                child: CSelectbox(
                  backgroundColor: Colors.white,
                  items: c.months,
                  selected: int.tryParse(wind.value17) ?? 0,
                  onSelected: (pos) {
                    wind.value17 = pos.toString();
                    c.windRedraw();
                  },
                ),
              ),
            ]),
          ),
          entry2(
            '극수',
            CTextField(
              text: wind.value18,
              controller: wind.extra['value18'],
              onChanged: (value) => wind.value18 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: '극',
            ),
            '역률',
            CTextField(
              text: wind.value19,
              controller: wind.extra['value19'],
              onChanged: (value) => wind.value19 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: '%',
            ),
          ),
          entry2(
            '정격전압',
            CTextField(
              text: wind.value20,
              controller: wind.extra['value20'],
              onChanged: (value) => wind.value20 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'V',
            ),
            '정격전류',
            CTextField(
              text: wind.value21,
              controller: wind.extra['value21'],
              onChanged: (value) => wind.value21 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'A',
            ),
          ),
          entry2(
            '절연저항',
            CTextField(
              text: wind.value22,
              controller: wind.extra['value22'],
              onChanged: (value) => wind.value22 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'MΩ',
            ),
            '접지저항',
            CTextField(
              text: wind.value23,
              controller: wind.extra['value23'],
              onChanged: (value) => wind.value23 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
              suffixText: 'Ω',
            ),
          ),
        ],
      ),
    );
  }

  water() {
    return round(<Widget>[
      entry(
        '수력발전설비',
        CTextField(
          text: c.water.name,
          controller: c.water.extra['name'],
          onChanged: (value) => c.water.name = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '정격전압',
        CTextField(
          text: c.water.value1,
          controller: c.water.extra['value1'],
          onChanged: (value) => c.water.value1 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'V',
        ),
        '정격용량',
        CTextField(
          text: c.water.value2,
          controller: c.water.extra['value2'],
          onChanged: (value) => c.water.value2 = value,
          filledColor: Colors.white,
          textStyle: labelStyle,
          suffixText: 'kW',
        ),
      ),
    ]);
  }

  loopfuel() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: c.fuel.length,
      itemBuilder: (context, index) {
        return fuel(c.fuel[index], index);
      },
    );
  }

  fuel(fuel, index) {
    return CContainer(
      margin: const EdgeInsets.only(top: 10),
      child: round(
        <Widget>[
          entryAdd(
            '연료전지 발전설비',
            CTextField(
              text: fuel.name,
              controller: fuel.extra['name'],
              onChanged: (value) => fuel.name = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            () {
              index == 0 ? c.addItem(c.fuel, 'fuel') : c.remove(c.fuel, index);
            },
            index == 0 ? true : false,
          ),
          entry(
            '형식',
            CTextField(
              text: fuel.value1,
              controller: fuel.extra['value1'],
              onChanged: (value) => fuel.value1 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry(
            '사용가스',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.gass,
              selected: int.tryParse(fuel.value2) ?? 0,
              onSelected: (pos) {
                fuel.value3 = '';
                fuel.extra['value3'].text = '';
                fuel.value2 = pos.toString();
                c.fuelRedraw();
              },
            ),
          ),
          if (fuel.value2 == '4')
            entry(
              '사용가스',
              CTextField(
                text: fuel.value3,
                onChanged: (value) => fuel.value3 = value,
                controller: fuel.extra['value3'],
                filledColor: Colors.white,
                textStyle: labelStyle,
              ),
            ),
          entry2(
            '정격출력',
            CTextField(
              text: fuel.value4,
              controller: fuel.extra['value4'],
              onChanged: (value) => fuel.value4 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '가스소비량',
            CTextField(
              text: fuel.value5,
              controller: fuel.extra['value5'],
              onChanged: (value) => fuel.value5 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry(
            '가스압력범위',
            CRow(gap: 10, children: [
              Expanded(
                child: CTextField(
                  text: fuel.value6,
                  controller: fuel.extra['value6'],
                  onChanged: (value) => fuel.value6 = value,
                  filledColor: Colors.white,
                  textStyle: labelStyle,
                ),
              ),
              CText('~'),
              Expanded(
                child: CTextField(
                  text: fuel.value7,
                  controller: fuel.extra['value7'],
                  onChanged: (value) => fuel.value7 = value,
                  filledColor: Colors.white,
                  textStyle: labelStyle,
                ),
              ),
            ]),
          ),
          entry2(
            '정격전압',
            CTextField(
              text: fuel.value8,
              controller: fuel.extra['value8'],
              onChanged: (value) => fuel.value8 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '주파수',
            CTextField(
              text: fuel.value9,
              controller: fuel.extra['value9'],
              onChanged: (value) => fuel.value9 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry2(
            '발전효율',
            CTextField(
              text: fuel.value10,
              controller: fuel.extra['value10'],
              onChanged: (value) => fuel.value10 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '열효율',
            CTextField(
              text: fuel.value11,
              controller: fuel.extra['value11'],
              onChanged: (value) => fuel.value11 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry2(
            '계통연계',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.fuelpositions,
              selected: int.tryParse(fuel.value12) ?? 0,
              onSelected: (pos) {
                fuel.value12 = pos.toString();
                c.fuelRedraw();
              },
            ),
            '설치위치',
            CSelectbox(
              backgroundColor: Colors.white,
              items: c.fueltypes,
              selected: int.tryParse(fuel.value13) ?? 0,
              onSelected: (pos) {
                fuel.value13 = pos.toString();
                c.fuelRedraw();
              },
            ),
          ),
          entry2(
            '급배기방식',
            CTextField(
              text: fuel.value14,
              controller: fuel.extra['value14'],
              onChanged: (value) => fuel.value14 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '배기통길이',
            CTextField(
              text: fuel.value15,
              controller: fuel.extra['value15'],
              onChanged: (value) => fuel.value15 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
          ),
          entry2(
            '제조사',
            CTextField(
              text: fuel.value16,
              controller: fuel.extra['value16'],
              onChanged: (value) => fuel.value16 = value,
              filledColor: Colors.white,
              textStyle: labelStyle,
            ),
            '제조번호',
            CTextField(
              text: fuel.value17,
              controller: fuel.extra['value17'],
              onChanged: (value) => fuel.value17 = value,
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
                  selected: int.tryParse(fuel.value18) ?? 0,
                  onSelected: (pos) {
                    fuel.value18 = pos.toString();
                    c.fuelRedraw();
                  },
                ),
              ),
              Expanded(
                child: CSelectbox(
                  backgroundColor: Colors.white,
                  items: c.months,
                  selected: int.tryParse(fuel.value19) ?? 0,
                  onSelected: (pos) {
                    fuel.value19 = pos.toString();
                    c.fuelRedraw();
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
