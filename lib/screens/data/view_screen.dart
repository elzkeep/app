import 'package:common_control/ccolumn.dart';
import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:hand_signature/signature.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:zkeep/components/cselectbox.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/data/view_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zkeep/models/report.dart';

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
            // CText('사진'),
            // c.report.image != ''
            //     ? CContainer(
            //         width: 100,
            //         height: 100,
            //         child: Image.network(
            //           '${Config.serverUrl}/webdata/${c.report.image}',
            //           fit: BoxFit.cover,
            //         ))
            //     : c.image != ''
            //         ? CContainer(
            //             width: 100,
            //             height: 100,
            //             child: Image.asset(
            //               c.image,
            //               fit: BoxFit.cover,
            //             ))
            //         : CContainer(
            //             height: 100,
            //             width: 100,
            //             decoration: BoxDecoration(
            //                 color: backgroundColor,
            //                 border: Border.all(
            //                   color: const Color(0xffE0E0E0),
            //                   width: 1,
            //                 ),
            //                 borderRadius: BorderRadius.circular(8)),
            //             child: const Icon(CupertinoIcons.plus),
            //             onTap: () async {
            //               final returnedImage = await ImagePicker()
            //                   .pickImage(source: ImageSource.gallery);
            //               if (returnedImage == null) return;
            //               c.image = returnedImage.path;
            //               c.redraw();
            //             },
            //           ),
            const SizedBox(height: 20),
            CTextField(
              text: '종합 검토 의견',
              readOnly: c.report.status == ReportStatus.complete,
              maxLines: 5,
              controller: c.content,
            ),
            const SizedBox(height: 20),
            if (c.report.status == ReportStatus.check ||
                c.report.status == ReportStatus.complete)
              CRow(
                gap: 10,
                children: [
                  Expanded(
                    child: CContainer(
                      height: 130,
                      child: roundBorder(Stack(
                        children: [
                          Positioned(
                              child: c.report.sign1 != ''
                                  ? SvgPicture.string(c.report.sign1)
                                  : c.sign1.toSvg() != null
                                      ? SvgPicture.string(c.sign1!.toSvg())
                                      : CContainer()),
                          Positioned(child: CText('점검자'))
                        ],
                      )),
                      onTap: () {
                        if (c.report.sign1 == '') {
                          clickSign(c.sign1);
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: CContainer(
                      height: 130,
                      child: roundBorder(Stack(
                        children: [
                          Positioned(
                              child: c.report.sign2 != ''
                                  ? SvgPicture.string(c.report.sign2)
                                  : c.sign2.toSvg() != null
                                      ? SvgPicture.string(c.sign2!.toSvg())
                                      : CContainer()),
                          Positioned(child: CText('관리담당자'))
                        ],
                      )),
                      onTap: () {
                        if (c.report.sign2 == '') {
                          clickSign(c.sign2);
                        }
                      },
                    ),
                  ),
                ],
              ),
            // if (c.report.status == ReportStatus.complete ||
            //     c.report.status == ReportStatus.check)
            //   CButton(
            //     text: '점검지 다운로드',
            //     margin: const EdgeInsets.only(top: 10),
            //     onPressed: () => clickDown(),
            //   ),
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
            text: c.report.status == ReportStatus.check
                ? '점검완료'
                : c.report.status == ReportStatus.complete
                    ? '완료'
                    : '작성완료',
            disabled: c.report.status == ReportStatus.complete,
            flex: 1,
            size: CButtonSize.large,
            onPressed: () => clickSave(),
          ),
        ]);
  }

  clickDown() {
    c.getPdf();
  }

  clickCancel() {
    Get.back();
  }

  clickSave() async {
    if (c.report.status == ReportStatus.newer) {
      print("새로운 점검 데이터 입니다.");
    }
    if (c.report.status == ReportStatus.ing) {
      bool check = true;
      for (int i = 0; i < c.otherdata.length; i++) {
        if (c.otherdata[i] == true && c.data[i] == false) {
          check = false;
          break;
        }
      }
      if (check) {
        c.save();
        Get.back();
      }
    }
    if (c.report.status == ReportStatus.check &&
        c.sign1.toSvg() != null &&
        c.sign2.toSvg() != null) {
      await c.save();
      Get.back();
    }
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
            onPressed: () async {
              c.redraw();
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
                      const TextStyle(fontSize: 12, color: Config.primaryColor),
                  onTap: () => Get.toNamed('/facility/${c.id}',
                      arguments: {'building': c.report.building}),
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
          // color: const Color(0xffE0E0E0),
          // border: Border.all(
          //   color: const Color(0xffE0E0E0),
          //   width: 1,
          // ),
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: CRow(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CContainer(
            margin: const EdgeInsets.only(top: 4),
            backgroundColor: Config.primaryColor,
            width: 5,
            height: 14,
            child: Container()),
        const SizedBox(width: 10),
        Expanded(
            child: CColumn(gap: 5, children: [
          CRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(c.report.title),
              // CText('정보수정',
              //     textStyle: const TextStyle(color: Config.primaryColor))
            ],
          ),
          CText(
              '${DateFormat('MM월 dd일').format(DateTime.parse(c.report.checkdate))} ${c.report.checktime}',
              textStyle: const TextStyle(color: Colors.black54, fontSize: 12)),
          CText('${period[c.report.period].value} 점검',
              textStyle: const TextStyle(color: Colors.black54, fontSize: 12)),
        ])),
        const SizedBox(width: 20),
      ]),
    );
  }

  btn(int num, String name) {
    final url = '/data/${c.id}/write/$num';
    return CContainer(
        width: (Get.width - 30) / 2,
        onTap: () => Get.toNamed(url, arguments: {
              'item': c.report,
              'disable': c.report.status == ReportStatus.complete ? true : false
            }),
        child: roundBorder(Stack(children: [
          CText(name, alignment: Alignment.center),
          if (c.data[num - 1])
            Positioned(
                right: 0,
                child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Config.primaryColor,
                      shape: BoxShape.circle,
                    )))
        ])));
  }

  wrapbtn() {
    List<Widget> widgets = [];

    Widget widget = btn(1, '저압설비');
    widgets.add(widget);
    c.otherdata[0] = true;

    if (c.item.value3 == '2') {
      widget = btn(2, '고압설비');
      widgets.add(widget);
      c.otherdata[1] = true;
      widget = btn(3, '변전설비');
      widgets.add(widget);
      c.otherdata[2] = true;
    }

    widget = btn(4, '부하설비');
    widgets.add(widget);
    c.otherdata[3] = true;

    if (c.other[0] == true) {
      widget = btn(5, c.othername[0]);
      widgets.add(widget);
      c.otherdata[4] = true;
    }

    widget = btn(6, '기타안전설비');
    widgets.add(widget);
    c.otherdata[5] = true;

    if (c.other[1] == true) {
      widget = btn(7, c.othername[1]);
      widgets.add(widget);
      c.otherdata[6] = true;
    }

    if (c.other[2] == true) {
      widget = btn(8, c.othername[2]);
      widgets.add(widget);
      c.otherdata[7] = true;
    }

    if (c.other[3] == true) {
      widget = btn(9, c.othername[3]);
      widgets.add(widget);
      c.otherdata[8] = true;
    }

    if (c.other[4] == true) {
      widget = btn(10, c.othername[4]);
      widgets.add(widget);
      c.otherdata[9] = true;
    }

    if (c.other[5] == true) {
      widget = btn(11, c.othername[5]);
      widgets.add(widget);
      c.otherdata[10] = true;
    }

    if (c.other[6] == true) {
      widget = btn(12, c.othername[6]);
      widgets.add(widget);
      c.otherdata[11] = true;
    }

    if (c.other[7] == true) {
      widget = btn(13, c.othername[7]);
      widgets.add(widget);
      c.otherdata[12] = true;
    }

    if (c.other[8] == true) {
      widget = btn(14, c.othername[8]);
      widgets.add(widget);
      c.otherdata[13] = true;
    }

    return Wrap(spacing: 10, runSpacing: 10, children: widgets);
  }
}
