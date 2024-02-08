import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:zkeep/components/box_title.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/cselectbutton.dart';
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
          title('기본 정보'),
          basic(),
          const SizedBox(height: 10),
          title('수배전설비'),
          arrangement(),
          const SizedBox(height: 10),
          distributation(),
          manufacture(),
          receivingtype(),
          const SizedBox(height: 10),
          title('기타 전력 설비'),
          other(),
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
      Expanded(child: widget2)
    ]);
  }

  basic() {
    final types = CItem.list(['', '저압', '특고압']);
    final positions =
        CItem.list(['', '지하', '단독/옥내', '옥상', '옥외', '복도/계단', '현관', '직접입력']);

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
          '분배전 전압',
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
            selected: c.manufactureYear,
            onSelected: (pos) => c.manufactureYear = pos,
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

  receivingtype() {
    if (c.type == 2) {
      return Column(children: [
        const SizedBox(height: 10),
        title('변전설비', () => clickAddChange()),
        change(),
        const SizedBox(height: 10),
        title('고압차단기', () => clickAddHighBreaker()),
        highBreaker(),
      ]);
    } else {
      return Container();
    }
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
          selected: c.changetype,
          onSelected: (pos) => c.changetype = pos,
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

  clickAddChange() {}

  highBreaker() {
    final breakers = CItem.list(['', 'VCB', 'GCV']);
    final relays = CItem.list(['', 'OCR', 'OCGR', 'UVR', 'OVR', 'POR']);
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
        '설치 장소',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '차단기명',
        CSelectbox(
          backgroundColor: Colors.white,
          items: breakers,
          selected: c.highbreaker,
          onSelected: (pos) => c.highbreaker = pos,
        ),
        '차단용량',
        CTextField(
          suffixText: 'kVA',
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '정격전압',
        CTextField(
          suffixText: 'kV',
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '전류',
        CTextField(
          suffixText: 'A',
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
              selected: c.highbreakeryear,
              onSelected: (pos) => c.highbreakeryear = pos,
            ),
          ),
          Expanded(
            child: CSelectbox(
              backgroundColor: Colors.white,
              items: months,
              selected: c.highbreakermonth,
              onSelected: (pos) => c.highbreakermonth = pos,
            ),
          ),
        ]),
      ),
      const SizedBox(height: 10),
      title('계전기', () => clickAddrelay()),
      entry(
          '계전기1',
          CSelectbox(
            backgroundColor: Colors.white,
            items: relays,
            selected: c.relay,
            onSelected: (pos) => c.relay = pos,
          )),
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
            items: breakers,
            selected: c.relayconnect,
            onSelected: (pos) => c.relayconnect = pos,
          )),
    ]);
  }

  clickAddHighBreaker() {}

  clickAddrelay() {}

  other() {
    List<CItem> years = [CItem(id: 0, value: '')];

    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1970, value: '$i년'));
    }

    List<CItem> months = [CItem(id: 0, value: '')];

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }

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
      sun(),
      ev(),
      ess(),
      ups(),
      fuelcell(),
      wind(),
      hydro(),
    ]);
  }

  sun() {
    final place = CItem.list(['', '옥상', '옥외', '임야', '직접입력']);

    return round(<Widget>[
      entry(
        '태양광 발전',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '설치장소',
        CSelectbox(
          backgroundColor: Colors.white,
          items: place,
          selected: c.changetype,
          onSelected: (pos) => c.changetype = pos,
        ),
      ),
      entry2(
        '발전전압',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '발전용량',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
    ]);
  }

  ev() {
    final evplace = CItem.list(['', '옥상', '옥외', '직접입력']);
    final evform = CItem.list(['', 'DC차데모', 'DC콤보', 'AC3상']);

    List<CItem> years = [CItem(id: 0, value: '')];

    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1970, value: '$i년'));
    }

    List<CItem> months = [CItem(id: 0, value: '')];

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }

    return round(<Widget>[
      CText('EV 충전기'),
      entry(
        '설치장소',
        CSelectbox(
          backgroundColor: Colors.white,
          items: evplace,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
      ),
      entry2(
        '전압',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '용량',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry(
        '충전설비',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      CText('충전기'),
      entry2(
        '설치현황',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        'X',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '설치장소',
        CSelectbox(
          backgroundColor: Colors.white,
          items: evplace,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
        '충전형식',
        CSelectbox(
          backgroundColor: Colors.white,
          items: evform,
          selected: c.changeyear,
          onSelected: (pos) => c.changeyear = pos,
        ),
      ),
      entry2(
        '출력전압',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '충전용량',
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
        '모델명',
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

  ess() {
    List<CItem> years = [CItem(id: 0, value: '')];
    for (var i = 1970; i <= 2024; i++) {
      years.add(CItem(id: i - 1970, value: '$i년'));
    }

    List<CItem> months = [CItem(id: 0, value: '')];

    for (var i = 1; i <= 12; i++) {
      months.add(CItem(id: i, value: '$i월'));
    }

    return round(<Widget>[
      CText('전기저장장치'),
      CText('전력변환장치(PCS)'),
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
        '입력전압',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '~',
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
      CText('배터리'),
      entry2(
        '최대저장용량',
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
      entry3(
        '구성',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        'X',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        'X',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
      ),
      entry2(
        '최대동작전압',
        CTextField(
          filledColor: Colors.white,
          textStyle: labelStyle,
        ),
        '최대동작전류',
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
        '형식',
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
