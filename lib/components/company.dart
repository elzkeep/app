import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:zkeep/models/customer.dart';

class CompanyWidget extends CWidget {
  CompanyWidget(this.item, {super.key});

  final Customer item;

  @override
  Widget build(BuildContext context) {
    return CContainer(
      onTap: () =>
          Get.toNamed('/customer/${item.id}', arguments: {'item': item}),
      decoration: BoxDecoration(
          color: const Color(0xffE0E0E0),
          border: Border.all(
            color: const Color(0xffE0E0E0),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: CRow(children: [
        Expanded(
          child: CColumn(gap: 10, children: [
            CText(item.managername),
            CText(
                '계약 종료일: ${DateFormat('yyyy.MM.dd').format(DateTime.parse(item.contractenddate))}',
                textStyle:
                    const TextStyle(color: Colors.black54, fontSize: 12)),
          ]),
        ),
        Expanded(
          child: CColumn(gap: 10, children: [
            CText('750KW / 2점 1회',
                textStyle:
                    const TextStyle(color: Colors.black54, fontSize: 12)),
            CText('다음점검일 : 7월 10일',
                textStyle: const TextStyle(color: Colors.black54, fontSize: 12))
          ]),
        ),
        CRow(
          gap: 10,
          children: [
            CSvg('assets/imgs/call.svg'),
            CSvg('assets/imgs/message.svg'),
          ],
        )
      ]),
    );
  }
}
