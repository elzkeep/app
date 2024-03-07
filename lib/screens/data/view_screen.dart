import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
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
      title: c.report.title,
      popup: true,
      child: CFixedBottom(bottom: bottom(), children: [
        SingleChildScrollView(
            child: CColumn(children: [
          title('고객 정보'),
          Obx(
            () => customer(),
          ),
          const SizedBox(height: 10),
          title('설비 기본 정보'),
          Obx(
            () => info(),
          ),
          const SizedBox(height: 20),
          view(),
          const SizedBox(height: 10),
          Obx(() => wrapbtn()),
          CRow(margin: const EdgeInsets.only(top: 10), gap: 10, children: [
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/1',
                        arguments: {'item': c.report}),
                    child: roundBorder(CText('저압설비')))),
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/2',
                        arguments: {'item': c.report}),
                    child: roundBorder(CText('고압설비')))),
          ]),
          CRow(margin: const EdgeInsets.only(top: 10), gap: 10, children: [
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/3',
                        arguments: {'item': c.report}),
                    child: roundBorder(CText('변전설비')))),
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/4',
                        arguments: {'item': c.report}),
                    child: roundBorder(CText('부하설비')))),
          ]),
          CRow(margin: const EdgeInsets.only(top: 10), gap: 10, children: [
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/5',
                        arguments: {'item': c.report}),
                    child: roundBorder(CText('발전설비')))),
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/6',
                        arguments: {'item': c.report}),
                    child: roundBorder(CText('기타안전설비')))),
          ]),
          CRow(margin: const EdgeInsets.only(top: 10), gap: 10, children: [
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/7',
                        arguments: {'item': c.report}),
                    child: roundBorder(CText('태양광 발전설비')))),
            Expanded(
                child: CContainer(
                    onTap: () => Get.toNamed('/data/${c.id}/write/8',
                        arguments: {'item': c.report}),
                    child: roundBorder(CText('전기차충전기')))),
          ]),
          const SizedBox(height: 20),
          CTextField(
            text: '종합 검토 의견',
            maxLines: 5,
            controller: c.content,
          ),
        ])),
      ]),
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

  clickSave() async {
    await c.save();
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
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: child);
  }

  customer() {
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
          CText(c.building.name),
          CRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CText('담당자: ${c.building.ceo}',
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
          CRow(children: [
            Expanded(
              child: CText('수전 용량: ${c.item.value2}kW'),
            ),
            Expanded(
              child: CText(
                  '수전 형태: ${c.types[int.tryParse(c.item.value3) ?? 0].value}'),
            ),
          ]),
          CText('발전 설비 현황: ${c.facilityStatus()}'),
          CRow(
              margin: const EdgeInsets.only(top: 5),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CText(
                  '더보기',
                  textStyle:
                      const TextStyle(fontSize: 12, color: Colors.black54),
                  onTap: () => Get.toNamed('/facility/${c.id}',
                      arguments: {'building': c.report.building.id}),
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
            CText(c.report.title),
            CRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CText(item['name'],
                  textStyle:
                      const TextStyle(color: Colors.black54, fontSize: 12)),
              CText('|',
                  textStyle:
                      const TextStyle(color: Colors.black54, fontSize: 12)),
              CText(
                  '${DateFormat('MM월 dd일').format(DateTime.parse(c.report.checkdate))} ${c.report.checktime}',
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

  btn(url, name) {
    return CContainer(
        width: (Get.width - 30) / 2,
        onTap: () => Get.toNamed(url, arguments: {'item': c.report}),
        child: roundBorder(CText(name)));
  }

  wrapbtn() {
    List<Widget> widgets = [];
    for (var i = 0; i < c.other.length; i++) {
      if (c.other[i] == true) {
        final widget = btn('/data/${c.id}/write/${i + 5}', c.othername[i]);
        widgets.add(widget);
      }
    }
    return Wrap(spacing: 10, runSpacing: 10, children: widgets);
  }
}
