import 'package:common_control/common_control.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:zkeep/components/box_title.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/status.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/data/low_controller.dart';
import 'package:zkeep/models/data.dart';
import 'package:zkeep/models/dataitem.dart';
import 'package:zkeep/models/item.dart';

class LowScreen extends CWidget {
  LowScreen({super.key});

  final c = Get.find<LowController>();

  @override
  Widget build(BuildContext context) {

    return Layout(
      title: '창천초등학교 - 저압설비',
      popup: true,
      child: CFixedBottom(children: [
        SingleChildScrollView(
            child: Obx(() => CColumn(children: [
                  volt(),
                  //const SizedBox(height: 20),
                  //pre(),

                  const SizedBox(height: 20),
                  category3(),
                  const SizedBox(height: 20),
                  /*
                  block1(),
                  const SizedBox(height: 20),
                  block2(),
                  const SizedBox(height: 20),
                  block3(),
                  const SizedBox(height: 20),
                  block4(),
                  const SizedBox(height: 20),

                  */
                ]))),
      ], bottom: bottom()),
    );
  }

  bottom() {
    return CRow(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        gap: 10,
        children: [
          CButton(
            text: '취소',
            flex: 1,
            size: CButtonSize.normal,
            type: CButtonStyle.outlined,
            onPressed: () => clickCancel(),
          ),
          CButton(
            text: '확인',
            flex: 1,
            size: CButtonSize.normal,
            onPressed: () => clickSave(),
          ),
        ]);
  }

  clickCancel() {
    Get.back();
  }

  clickSave() {
    Get.back();
  }

  title(str) {
    return CText(str,
        margin: const EdgeInsets.only(top: 10),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  box(title) {
    return Expanded(
        child: roundBorder(
            CColumn(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CText(title, margin: const EdgeInsets.only(left: 10)),
      CRow(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CText('52',
                textStyle:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            CText('/', textStyle: const TextStyle(fontSize: 18)),
            CText('60', textStyle: const TextStyle(fontSize: 18)),
          ]),
      CText('86%',
          margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
          textAlign: TextAlign.right,
          textStyle: const TextStyle(fontSize: 12, color: Colors.black38)),
      LinearPercentIndicator(
        lineHeight: 7.0,
        percent: 0.5,
        backgroundColor: Colors.grey,
        progressColor: Config.primaryColor,
      )
    ])));
  }

  roundBorder(child) {
    return CContainer(
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffE0E0E0),
              width: 1,
            ),
            color: Colors.black12,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: child);
  }

  customer() {
    final item = {
      'title': '창천초등학교 7월 2차 점검',
      'name': '담당자 : 홍길동',
      'wat': '',
    };

    return CContainer(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffE0E0E0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: CRow(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: CColumn(gap: 10, children: [
          CText(item['title']!),
          CRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CText(item['name']!,
                textStyle:
                    const TextStyle(color: Colors.black54, fontSize: 12)),
          ]),
        ])),
        const SizedBox(width: 20),
        CRow(
          margin: const EdgeInsets.all(10),
          gap: 10,
          children: [
            CSvg('assets/imgs/call.svg'),
            CSvg('assets/imgs/message.svg'),
          ],
        )
      ]),
    );
  }

  info() {
    final item = {
      'title': '창천초등학교 7월 2차 점검',
      'name': '담당자 : 홍길동',
      'wat': '',
    };

    return CContainer(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffE0E0E0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: CRow(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: CColumn(gap: 10, children: [
          CRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CText('수전 용량: 800kW'),
            CText(
              '수전 형태: 특고압',
              textAlign: TextAlign.right,
            ),
          ]),
          CRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CText('발전 설비 현황: 비상 발전기, 전기차 충전기'),
          ]),
          CRow(
              margin: const EdgeInsets.only(top: 5),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CText(
                  '더보기',
                  textStyle:
                      const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ]),
        ])),
      ]),
    );
  }

  view() {
    List<dynamic> datas = [
      {
        'title': '창천초등학교 7월 2차 점검',
        'name': '월차 점검',
        'wat': '7.10 10:00',
      },
    ];

    List<Widget> items = [];

    for (var i = 0; i < datas.length; i++) {
      final item = datas[i];
      final widget = CContainer(
        decoration: BoxDecoration(
            color: const Color(0xffE0E0E0),
            border: Border.all(
              color: const Color(0xffE0E0E0),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: CRow(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CContainer(
              margin: const EdgeInsets.only(top: 4),
              backgroundColor: const Color.fromRGBO(237, 92, 66, 1.000),
              width: 5,
              height: 14,
              child: Container()),
          const SizedBox(width: 10),
          Expanded(
              child: CColumn(gap: 10, children: [
            CText(item['title']),
            CRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CText(item['name'],
                  textStyle:
                      const TextStyle(color: Colors.black54, fontSize: 12)),
              CText('|',
                  textStyle:
                      const TextStyle(color: Colors.black54, fontSize: 12)),
              CText(item['wat'],
                  textStyle:
                      const TextStyle(color: Colors.black54, fontSize: 12))
            ]),
          ])),
          const SizedBox(width: 20),
        ]),
      );

      items.add(widget);
    }
    return CColumn(children: items);
  }



  volt() {
        final volt = [
      CItem(id: 0, value: '전압'),
      CItem(id: 1, value: '380v/220v'),
      CItem(id: 2, value: '220v'),
    ];

    return roundBorder(CColumn(
        gap: 10,
        children: [
          CText('전압 및 전류 계측값'),
          CSelectbox(
              items: volt,
              backgroundColor: Colors.white,
              selected: c.volt,
              onSelected: (pos) {
                c.volt = pos;
              }),
          CRow(gap: 10, children: [
            Expanded(child: CTextField(text: 'A상', filledColor: Colors.white,)),
            Expanded(child: CTextField(text: 'B상', filledColor: Colors.white)),
          ]),
          CRow(gap: 10, children: [
            Expanded(child: CTextField(text: 'C상', filledColor: Colors.white,)),
            Expanded(child: CTextField(text: 'N상', filledColor: Colors.white)),
          ]),
          ]));
  }

  /*

  pre() {
    return roundBorder(CColumn(
        gap: 10,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Status(
            title: '배관용 차단기 적정성',
              item: c.value1,
              onSelected: (item) {
                print('value.value = ${item.value}');
                c.value1 = item;
              }),
        ]));
  }
*/



  category3() {

    final entry = c.items[0];

    List<Widget> widgets = [];

    if (entry.data.type == DataType.multi) {
      final widget = BoxTitle(
        text: entry.data.title,
        controller: TextEditingController(),
        onExpand: (expand) => {},
      );
      widgets.add(widget);
    } else {
      final widget = CText('차단기 종류');
      widgets.add(widget);
    }

    for (var i = 0; i < entry.items.length; i++) {
      final item = entry.items[i];

      if (item.type == ItemType.select) {
        final widget = CColumn(gap: 10, children: [
            CText(item.title),
            CSelectbox(
                backgroundColor: Colors.white,
                items: item.extra['select'],
                selected: entry.items[i].value,
                onSelected: (pos) {
                  entry.items[i].value = pos;
                }),
          ]);

        widgets.add(widget);
      } else if (item.type == ItemType.status) {
        final widget = Status(
            title: item.title,
            item: item,
            onSelected: (value) => entry.items[i] = value);

        widgets.add(widget);
      }
    }

    return roundBorder(CColumn(
        gap: 20,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widgets));

    /*
    final volt = [
      CItem(id: 0, value: '없음'),
      CItem(id: 1, value: 'ABC'),
      CItem(id: 2, value: 'MCCB'),
      CItem(id: 3, value: 'ELB'),
    ];


    return roundBorder(CColumn(
        gap: 20,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BoxTitle(
            text: '저압차단기',
            controller: TextEditingController(),
            onExpand: (expand) => {},
          ),
          CColumn(gap: 10, children: [
            CText(
              '차단기 종류',
            ),
            CSelectbox(
                backgroundColor: Colors.white,
                items: volt,
                selected: c.type,
                onSelected: (pos) {
                  c.type = pos;
                }),
          ]),
          Status(
              title: '외관 및 간선 연결상태',
              item: c.value1,
              onSelected: (index) => c.value1 = index),
          Status(
              title: '자동/수동 조작시 작동여부',
              item: c.value1,
              onSelected: (index) => c.value2 = index),
          Status(
              title: '장비내 발열여부',
              item: c.value1,
              onSelected: (index) => c.value3 = index),
        ]));
    */
  }

  /*
  block1() {
    return roundBorder(CColumn(
        gap: 20,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BoxTitle(
            text: '계전기',
            controller: TextEditingController(),
            onExpand: (expand) => {},
          ),
          Status(
              title: '외관 및 파손 상태',
              item: c.value1,
              onSelected: (index) => c.value4 = index),
          Status(
              title: '통신 연결상태',
              item: c.value1,
              onSelected: (index) => c.value5 = index),
        ]));
  }

  block2() {
    return roundBorder(CColumn(
        gap: 20,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BoxTitle(
            text: '콘덴서 관리상태',
            controller: TextEditingController(),
            onExpand: (expand) => {},
          ),
          Status(item: c.value6, onSelected: (index) => c.value6 = index),
        ]));
  }

  block3() {
    return roundBorder(CColumn(
        gap: 20,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BoxTitle(
            text: '분배전반',
            controller: TextEditingController(),
            onExpand: (expand) => {},
          ),
          Status(
              title: '외관 및 간선 연결상태',
              item: c.value7,
              onSelected: (index) => c.value7 = index),
          Status(
              title: '규격에 맞는 기기(차단기, 전선 등) 사용 여부',
              item: c.value8,
              onSelected: (index) => c.value8 = index),
          Status(
              title: '누전차단기 작동 여부',
              item: c.value9,
              onSelected: (index) => c.value9 = index),
          Status(
              title: '부하장비명 표기 상태',
              item: c.value10,
              onSelected: (index) => c.value10 = index),
        ]));
  }

  block4() {
    return roundBorder(CColumn(
        gap: 20,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BoxTitle(
            text: 'MCC반 운용상태',
            controller: TextEditingController(),
            onExpand: (expand) => {},
          ),
          Status(
              item: c.value11,
              onSelected: (index) => c.value11 = index),
        ]));
  }
    */
}
