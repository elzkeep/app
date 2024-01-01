import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/customer/customer_detail_controller.dart';

class CustomerDetailScreen extends CWidget {
  CustomerDetailScreen({super.key});

  final c = Get.find<CustomerDetailController>();

  @override
  Widget build(BuildContext context) {
    return Layout(
        popup: true,
        child: Obx(() => CScroll(gap: 20, children: [
              company(),
              building(),
              check(),
              contract(),
              const SizedBox(height: 50)
            ])));
  }

  company() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '고객 정보',
        more: '수정',
        onMore: () => clickUpdate(1),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                CText('사업자번호: ${c.item.companyno}'),
                CBothSide(children: [
                  CText('고객명: ${c.item.name}'),
                  CText('대표자: ${c.item.ceo}')
                ]),
              ]))
    ]);
  }

  building() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '점검 대상 정보',
        more: '수정',
        onMore: () => clickUpdate(2),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                CText('시설명: '),
                CText('사업자번호: '),
                CText('주소: '),
              ]))
    ]);
  }

  check() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '점검 정보',
        more: '수정',
        onMore: () => clickUpdate(3),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CRow(children: [
                  CText(
                    '점검분야:',
                    expanded: true,
                  ),
                  CText(
                    '관리형태:',
                    expanded: true,
                  ),
                ]),
                CRow(children: [
                  CText(
                    '점검일:',
                    expanded: true,
                  ),
                  CText(
                    '점검예정일:',
                    expanded: true,
                  ),
                ]),
                CRow(children: [
                  CText(
                    '수전 용량:',
                    expanded: true,
                  ),
                  CText(
                    '관리점수:',
                    expanded: true,
                  ),
                ]),
                CRow(children: [
                  CText(
                    '담당자명:',
                    expanded: true,
                  ),
                  CText(
                    '연락처:',
                    expanded: true,
                  ),
                ]),
                CRow(children: [
                  CText(
                    '이메일:',
                    expanded: true,
                  ),
                ])
              ]))
    ]);
  }

  contract() {
    return CColumn(gap: 10, children: [
      SubTitle(
        '계약 정보',
        more: '수정',
        onMore: () => clickUpdate(4),
      ),
      CRound(
          backgroundColor: Config.backgroundColor,
          child: CColumn(
              lineWidth: 1,
              lineColor: Colors.black12,
              gap: 10,
              children: [
                CText('계약기간:'),
                CText('계약금액:'),
                CRow(children: [
                  CText(
                    '청구방식:',
                    expanded: true,
                  ),
                  CText(
                    '청구일:',
                    expanded: true,
                  ),
                ]),
                CRow(children: [
                  CText(
                    '담당자명:',
                    expanded: true,
                  ),
                  CText(
                    '연락처:',
                    expanded: true,
                  ),
                ]),
                CRow(children: [
                  CText(
                    '이메일:',
                    expanded: true,
                  ),
                ]),
              ]))
    ]);
  }

  clickUpdate(pos) {
    print('/customer/${c.id}/update');
    Get.toNamed('/customer/${c.id}/update', arguments: {'index': pos});
  }
}
