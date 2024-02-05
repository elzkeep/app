import 'package:common_control/common_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:zkeep/components/company.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/dround.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/customer/customer_view_controller.dart';
import 'package:zkeep/models/report.dart';

class CustomerViewScreen extends CWidget {
  CustomerViewScreen({super.key});

  final c = Get.find<CustomerViewController>();

  @override
  Widget build(BuildContext context) {
    return Layout(popup: true, child: body());
  }

  body() {
    return Obx(() => CColumn(children: [
          CompanyWidget(c.item),
          const SizedBox(height: 10),
          info(),
          CButton(
              text: '더보기',
              margin: const EdgeInsets.only(top: 10),
              flex: 1,
              size: CButtonSize.xsmall,
              type: CButtonStyle.outlined,
              onPressed: () => clickMore()),
          const SizedBox(height: 10),
          history(),
          Expanded(child: Container())
        ]));
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
                CBothSide(
                    gap: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CText('고객명: '),
                      CText('동부팀'),
                    ]),
                CBothSide(
                    gap: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText('담당자 명: '),
                          CText('홍길동'),
                        ],
                      ),
                      CRow(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CText('점검일: '),
                          CText('매월 7일'),
                        ],
                      ),
                    ]),
              ]))
    ]);
  }

  graph() {
    return CColumn(children: [
      SubTitle('부적합 개소',
          more: '더보기', onMore: () => Get.toNamed('/mypage/customer')),
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
          onTap: () =>
              Get.toNamed('/data/${item.id}', arguments: {'item': item}),
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
                backgroundColor:
                    item.status == 1 ? Colors.black54 : Colors.blue,
                child: CText(
                  '점검중',
                  textStyle: const TextStyle(fontSize: 11, color: Colors.white),
                )),
          ]),
        ),
      ],
    );
  }

  clickMore() {
    Get.toNamed('/customer/${c.id}/detail');
  }
}
