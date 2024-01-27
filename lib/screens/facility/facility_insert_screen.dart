import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/facility/facility_insert_controller.dart';

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
    return Obx(() => CColumn(children: [
          /*
          title('수배전설비'),
          basic(),
          const SizedBox(height: 10),
          arrangement(),
          const SizedBox(height: 10),
          distributation(),
          manufacture(),
          const SizedBox(height: 10),
          */
          title('변전설비', () => clickAddChange()),
          change(),
          const SizedBox(height: 20),
        ]));
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

  basic() {
    final types = CItem.list(['', '저압', '특고압']);
    final positions =
        CItem.list(['', '지하', '단독/옥내', '옥상', '옥외', '복도/계단', '현관', '직접입력']);
    final volts = CItem.list(['', '[저압]380/220', '[특고압]22,900']);
    final arrangetypes = CItem.list(['', '일반형', '일체형']);
    final disttypes = CItem.list(['', '매입형', '노출형']);

    return round(<Widget>[
      entry(
          '수전용량',
          CTextField(
            filledColor: Colors.white,
            suffixText: 'kW',
            textStyle: const TextStyle(fontSize: 14),
          )),
      entry(
          '수전형태',
          CSelectbox(
            backgroundColor: Colors.white,
            items: types,
            selected: c.type,
            onSelected: (pos) => c.type = pos,
          )),
      entry(
          '수전위치',
          CSelectbox(
            backgroundColor: Colors.white,
            items: positions,
            selected: c.position,
            onSelected: (pos) {
              c.position = pos;
            },
          )),
      c.position == positions.length - 1
          ? entry(
              '',
              CTextField(
                filledColor: Colors.white,
                textStyle: const TextStyle(fontSize: 14),
              ))
          : const SizedBox.shrink(),
    ]);
  }

  arrangement() {
    final volts = CItem.list(['', '[저압]380/220', '[특고압]22,900']);
    final arrangementtypes = CItem.list(['', '일반형', '일체형']);
    final faces = CItem.list([
      '',
      '1~5',
      '6~10',
      '11~20',
      '21~30',
      '31~40',
      '41~50',
      '51~60',
      '61~70',
      '71~80',
      '81~90',
      '91~100',
      '11~20',
      '101이상',
      '직접입력'
    ]);

    return round(<Widget>[
      entry(
          '수전전압',
          CSelectbox(
            backgroundColor: Colors.white,
            items: volts,
            selected: c.arrangement,
            onSelected: (pos) => c.arrangement = pos,
          )),
      entry2(
          '형식',
          CSelectbox(
            backgroundColor: Colors.white,
            items: arrangementtypes,
            selected: c.arrangementtype,
            onSelected: (pos) => c.arrangementtype = pos,
          ),
          '면수',
          CSelectbox(
            backgroundColor: Colors.white,
            items: faces,
            selected: c.arrangementface,
            onSelected: (pos) => c.arrangementface = pos,
          )),
    ]);
  }

  distributation() {
    final volts = CItem.list(['', '[저압]380/220', '[특고압]22,900']);
    final distributationtypes = CItem.list(['', '매입형', '노출형']);
    final faces = CItem.list([
      '',
      '1~5',
      '6~10',
      '11~20',
      '21~30',
      '31~40',
      '41~50',
      '51~60',
      '61~70',
      '71~80',
      '81~90',
      '91~100',
      '11~20',
      '101이상',
      '직접입력'
    ]);

    return round(<Widget>[
      entry(
          '배전전압',
          CSelectbox(
            backgroundColor: Colors.white,
            items: volts,
            selected: c.distributation,
            onSelected: (pos) => c.distributation = pos,
          )),
      entry2(
          '형식',
          CSelectbox(
            backgroundColor: Colors.white,
            items: distributationtypes,
            selected: c.distributationtype,
            onSelected: (pos) => c.distributationtype = pos,
          ),
          '면수',
          CSelectbox(
            backgroundColor: Colors.white,
            items: faces,
            selected: c.distributationface,
            onSelected: (pos) => c.distributationface = pos,
          )),
    ]);
  }

  manufacture() {
    List<CItem> years = [CItem(id: 0, value: '')];

    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1970, value: '$i'));
    }

    return CColumn(padding: const EdgeInsets.all(10), gap: 10, children: [
      entry2(
          '제조사',
          CTextField(
            textStyle: labelStyle,
            filledColor: Colors.white,
          ),
          '설치년월',
          CSelectbox(
            backgroundColor: Colors.white,
            items: years,
            selected: c.years,
            onSelected: (pos) => c.years = pos,
          )),
      entry(
        '단선결선도',
        CButton(
          text: '첨부',
          flex: 1,
          size: CButtonSize.small,
          type: CButtonStyle.outlined,
          onPressed: () => {},
        ),
      )
    ]);
  }

  change() {
    final types = CItem.list(['', '유입형', '몰드형']);
    List<CItem> years = [CItem(id: 0, value: '')];

    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1970, value: '$i년'));
    }

    List<CItem> months = [CItem(id: 0, value: '')];

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }

    return round(<Widget>[
      entry(
        '설비명',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '형식',
        CSelectbox(
          backgroundColor: Colors.white,
          items: types,
          selected: c.distributationtype,
          onSelected: (pos) => c.distributationtype = pos,
        ),
        '정격용량',
        CTextField(
          suffixText: 'kVA',
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '%Z',
        CTextField(
          suffixText: '%',
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '정격전압',
        CTextField(
          suffixText: 'V',
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
              selected: c.years,
              onSelected: (pos) => c.years = pos,
            ),
          ),
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: months,
              selected: c.years,
              onSelected: (pos) => c.years = pos,
            ),
          ),
        ]),
      ),
    ]);
  }

  clickAddChange() {}
}
