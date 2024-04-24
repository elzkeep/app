import 'package:common_control/common_control.dart';
import 'package:zkeep/components/cround.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/config/config.dart';
import 'package:zkeep/controllers/customer/customer_detail_controller.dart';
import 'package:zkeep/models/customertypeextension.dart';

class CustomerDetailScreen extends CWidget {
  CustomerDetailScreen({super.key});

  final c = Get.find<CustomerDetailController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Layout(
        popup: true,
        child: CScroll(gap: 20, children: [
          company(),
          building(),
          check(),
          contract(),
          const SizedBox(height: 50)
        ])));
  }

  entry(text1, answer1) {
    return CRow(
      gap: 5,
      children: [CText(text1), CText(answer1)],
    );
  }

  entry2(text1, answer1, text2, answer2) {
    return CRow(
      children: [
        Expanded(
          child: CRow(
            gap: 5,
            children: [CText(text1), CText(answer1)],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CRow(
            gap: 5,
            children: [CText(text2), CText(answer2)],
          ),
        )
      ],
    );
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
                entry('사업자번호:', c.company.companyno),
                entry2('고객명:', c.company.name, '대표자:', c.company.ceo),
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
                entry('시설명:', c.building.name),
                entry('사업자번호:', c.building.companyno),
                entry('주소:', '${c.building.address} ${c.building.addressetc}'),
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
                entry2('점검분야:', '전기', '관리형태:', c.item.type.name),
                entry2('점검일:', '${c.item.checkdate}일', '점검예정일:',
                    '${c.item.checkdate}일'),
                entry2('수전 용량:', '${c.facility.value2}kW', '관리점수:',
                    '${c.building.score}'),
                entry2('담당자명:', c.item.managername, '연락처:', c.item.managertel),
                entry('이메일:', c.item.manageremail),
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
                entry('계약기간:',
                    '${c.item.contractstartdate} ~ ${c.item.contractenddate}'),
                entry('계약금액:', '${c.item.contractprice}'),
                entry2('청구방식:', '', '청구일:', '${c.item.billingdate}일'),
                entry2('담당자명:', c.item.billingname, '연락처:', c.item.billingtel),
                entry('이메일:', c.item.billingemail),
              ]))
    ]);
  }

  clickUpdate(pos) {
    print('/customer/${c.id}/update');
    Get.toNamed('/customer/${c.id}/update', arguments: {'index': pos});
  }
}
