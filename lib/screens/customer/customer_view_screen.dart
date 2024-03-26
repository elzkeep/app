import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/dround.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/line_chart.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/customer/customer_view_controller.dart';
import 'package:zkeep/models/report.dart';
import 'package:zkeep/models/reportstatusextension.dart';

class CustomerViewScreen extends CWidget {
  CustomerViewScreen({super.key});

  final c = Get.find<CustomerViewController>();

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return Obx(() => CScroll(gap: 20, children: [
          CContainer(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CRow(children: [
              Expanded(
                child: CColumn(gap: 10, children: [
                  CText(
                    c.item.building.name,
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
              CRow(
                gap: 10,
                children: [
                  CSvg('assets/imgs/corner-up-right.svg'),
                  CSvg('assets/imgs/call.svg'),
                  CSvg('assets/imgs/message.svg'),
                ],
              )
            ]),
          ),
          info(),
          CButton(
              text: '더보기',
              size: CButtonSize.xsmall,
              type: CButtonStyle.outlined,
              onPressed: () => clickMore()),
          title('설비 기본 정보'),
          facilityInfo(),
          graph(),
          history(),
          const SizedBox(height: 50),
        ]));
  }

  title(str) {
    return CText(str,
        // margin: const EdgeInsets.only(top: 10),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  info() {
    return CColumn(gap: 10, children: [
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 20,
              children: [
                CText('고객명: ${c.item.buildingcompany.name}'),
                CRow(gap: 10, children: [
                  CText(
                    '담당자 명: ${c.item.managername}',
                    expanded: true,
                  ),
                  CText(
                    '점검일: 매월 ${c.item.contractday}일',
                    expanded: true,
                  ),
                ]),
              ]))
    ]);
  }

  facilityInfo() {
    return CContainer(
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffE0E0E0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8)),
      // margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: CRow(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: CColumn(gap: 10, children: [
          CRow(children: [
            Expanded(
              child: CText('수전 용량: ${c.facility.value2}kW'),
            ),
            Expanded(
              child: CText(
                  '수전 형태: ${c.types[int.tryParse(c.facility.value3) ?? 0].value}'),
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
                      arguments: {'building': c.item.building}),
                ),
              ]),
        ])),
      ]),
    );
  }

  graph() {
    return CColumn(children: [
      SubTitle('부적합 개소',
          more: '더보기', onMore: () => Get.toNamed('/mypage/customer')),
      const CLineChart(),
    ]);
  }

  history() {
    return CColumn(children: [
      SubTitle('점검 이력'),
      lists(),
    ]);
  }

  lists() {
    if (c.items.isEmpty) {
      return CContainer(
        height: 100,
        alignment: Alignment.topCenter,
        child: CText('아직 등록된 일정이 없어요'),
      );
    }
    return Obx(
      () => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: c.items.length,
        itemBuilder: (context, index) {
          return list(c.items[index], index);
        },
      ),
    );
  }

  Widget list(Report item, int index) {
    return CColumn(
      children: [
        CContainer(
          onTap: () => Get.toNamed('/data/${item.id}',
              arguments: {'item': item, 'building': c.item.building}),
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
            const SizedBox(width: 10),
            Expanded(
                child: CColumn(gap: 10, children: [
              CText(item.title),
              CRow(mainAxisAlignment: MainAxisAlignment.start, children: [
                CText('점검일: ',
                    textStyle:
                        const TextStyle(color: Colors.black54, fontSize: 12)),
                CText(item.checkdate,
                    textStyle:
                        const TextStyle(color: Colors.black54, fontSize: 12)),
              ]),
            ])),
            const SizedBox(width: 20),
            DRound(
                backgroundColor: item.status.color,
                child: CText(
                  item.status.name,
                  textStyle: const TextStyle(fontSize: 11, color: Colors.white),
                )),
          ]),
        ),
      ],
    );
  }

  clickMore() {
    Get.toNamed('/customer/${c.id}/detail', arguments: {'item': c.item});
  }
}
