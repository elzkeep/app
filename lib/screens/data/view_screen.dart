import 'package:common_control/common_control.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/data/view_controller.dart';

class ViewScreen extends CWidget {
  ViewScreen({super.key});

  final c = Get.find<ViewController>();

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: '창천초등학교',
      popup: true,
      child: CFixedBottom(children: [
        SingleChildScrollView(
            child: CColumn(children: [
          title('고객 정보'),
          customer(),
          const SizedBox(height: 10),
          title('설비 기본 정보'),
          info(),
          const SizedBox(height: 20),
          view(),
          CRow(margin: const EdgeInsets.only(top: 10), gap: 10, children: [
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/1'),
                    child: roundBorder(CText('저압설비')))),
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/2'),
                    child: roundBorder(CText('고압설비')))),
          ]),
          CRow(margin: const EdgeInsets.only(top: 10), gap: 10, children: [
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/3'),
                    child: roundBorder(CText('변전설비')))),
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/4'),
                    child: roundBorder(CText('부하설비')))),
          ]),
          CRow(margin: const EdgeInsets.only(top: 10), gap: 10, children: [
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/5'),
                    child: roundBorder(CText('발전설비')))),
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/6'),
                    child: roundBorder(CText('기타안전설비')))),
          ]),
          CRow(margin: const EdgeInsets.only(top: 10), gap: 10, children: [
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/7'),
                    child: roundBorder(CText('태양광 발전설비')))),
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/8'),
                    child: roundBorder(CText('전기차충전기')))),
          ]),
          const SizedBox(height: 20),
          CTextField(
            text: '종합 검토 의견',
            maxLines: 5,
          ),
        ])),
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
            size: CButtonSize.large,
            type: CButtonStyle.outlined,
            onPressed: () => clickCancel(),
          ),
          CButton(
            text: '작성완료',
            flex: 1,
            size: CButtonSize.large,
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

  search() {
    return CTextField(
      text: '고객명, 점검일자, 점검지역',
      svg: 'assets/imgs/search.svg',
      margin: const EdgeInsets.only(top: 10),
    );
    //return CTextField(con: const Icon(Icons.search));
  }

  title(str) {
    return CText(str,
        margin: EdgeInsets.only(top: 10),
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
}
