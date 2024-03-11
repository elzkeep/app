import 'package:common_control/common_control.dart';
import 'package:hand_signature/signature.dart';
import 'package:intl/intl.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/controllers/data/view_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewScreen extends CWidget {
  ViewScreen({super.key});

  final c = Get.find<ViewController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Layout(
        title: c.report.title,
        popup: true,
        child: CFixedBottom(bottom: bottom(), children: [
          SingleChildScrollView(
              child: CColumn(children: [
            title('고객 정보'),
            customer(),
            const SizedBox(height: 10),
            title('설비 기본 정보'),
            info(),
            const SizedBox(height: 20),
            view(),
            const SizedBox(height: 10),
            wrapbtn(),
            const SizedBox(height: 20),
            CTextField(
              text: '종합 검토 의견',
              maxLines: 5,
              controller: c.content,
            ),
            CRow(
              gap: 10,
              children: [
                Expanded(
                  child: CContainer(
                    height: 130,
                    child: roundBorder(Stack(
                      children: [
                        Positioned(
                            child: c.sign.toSvg() != null
                                ? SvgPicture.string(c.sign.toSvg())
                                : CContainer()),
                        Positioned(child: CText('점검자'))
                      ],
                    )),
                    onTap: () {
                      clickSign(c.sign);
                    },
                  ),
                ),
                Expanded(
                  child: CContainer(
                    height: 130,
                    child: roundBorder(Stack(
                      children: [
                        Positioned(
                            child: c.csign.toSvg() != null
                                ? SvgPicture.string(c.csign.toSvg())
                                : CContainer()),
                        Positioned(child: CText('관리담당자'))
                      ],
                    )),
                    onTap: () {
                      clickSign(c.csign);
                    },
                  ),
                ),
              ],
            ),
          ])),
        ]),
      ),
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

  clickSign(controller) {
    Get.dialog(
      barrierDismissible: true,
      AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: Get.width - 40,
          height: Get.height / 3,
          child: HandSignature(
            control: controller,
            color: Colors.black,
            type: SignatureDrawType.shape,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => controller.clear(),
            child: const Text('지우기'),
          ),
          TextButton(
            onPressed: () {
              print('tosvg : ' + controller.toSvg());
              Get.back();
            },
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }

  title(str) {
    return CText(str,
        margin: const EdgeInsets.only(top: 10),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
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
    final period = [
      CItem(id: 0, value: '주기'),
      CItem(id: 1, value: '월차'),
      CItem(id: 2, value: '분기'),
      CItem(id: 3, value: '반기'),
      CItem(id: 4, value: '연차')
    ];

    // final ordinal = [
    //   CItem(id: 0, value: '차수'),
    //   CItem(id: 1, value: '1차'),
    //   CItem(id: 2, value: '2차'),
    //   CItem(id: 3, value: '3차'),
    //   CItem(id: 4, value: '4차')
    // ];

    return CContainer(
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
            CText('${period[c.report.period].value} 점검',
                textStyle:
                    const TextStyle(color: Colors.black54, fontSize: 12)),
            CText('|',
                textStyle:
                    const TextStyle(color: Colors.black54, fontSize: 12)),
            CText(
                '${DateFormat('MM월 dd일').format(DateTime.parse(c.report.checkdate))} ${c.report.checktime}',
                textStyle: const TextStyle(color: Colors.black54, fontSize: 12))
          ]),
        ])),
        const SizedBox(width: 20),
      ]),
    );
  }

  btn(url, name) {
    return CContainer(
        width: (Get.width - 30) / 2,
        onTap: () => Get.toNamed(url, arguments: {'item': c.report}),
        child: roundBorder(CText(name)));
  }

  wrapbtn() {
    List<Widget> widgets = [];

    Widget widget = btn('/data/${c.id}/write/1', '저압설비');
    widgets.add(widget);

    if (c.item.value3 == '2') {
      widget = btn('/data/${c.id}/write/2', '고압설비');
      widgets.add(widget);
      widget = btn('/data/${c.id}/write/3', '변전설비');
      widgets.add(widget);
    }

    widget = btn('/data/${c.id}/write/4', '부하설비');
    widgets.add(widget);

    if (c.other[0] == true) {
      widget = btn('/data/${c.id}/write/5', c.othername[0]);
      widgets.add(widget);
    }

    widget = btn('/data/${c.id}/write/6', '기타안전설비');
    widgets.add(widget);

    if (c.other[1] == true) {
      widget = btn('/data/${c.id}/write/7', c.othername[1]);
      widgets.add(widget);
    }

    if (c.other[2] == true) {
      widget = btn('/data/${c.id}/write/8', c.othername[2]);
      widgets.add(widget);
    }

    if (c.other[3] == true) {
      widget = btn('/data/${c.id}/write/9', c.othername[3]);
      widgets.add(widget);
    }

    if (c.other[4] == true) {
      widget = btn('/data/${c.id}/write/10', c.othername[4]);
      widgets.add(widget);
    }

    if (c.other[5] == true) {
      widget = btn('/data/${c.id}/write/11', c.othername[5]);
      widgets.add(widget);
    }

    if (c.other[6] == true) {
      widget = btn('/data/${c.id}/write/12', c.othername[6]);
      widgets.add(widget);
    }

    return Wrap(spacing: 10, runSpacing: 10, children: widgets);
  }
}
