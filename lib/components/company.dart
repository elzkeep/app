import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

class CompanyWidget extends CWidget {
  CompanyWidget(this.item, {super.key});

  final Company item;

  @override
  Widget build(BuildContext context) {
    return CContainer(
      onTap: () => Get.toNamed('/mypage/customer/${item.id}'),
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
        Expanded(
            child: CColumn(gap: 10, children: [
          CText(item.name),
          CRow(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CText('',
                textStyle:
                    const TextStyle(color: Colors.black54, fontSize: 12)),
            CText('',
                textStyle:
                    const TextStyle(color: Colors.black54, fontSize: 12)),
            CText('',
                textStyle: const TextStyle(color: Colors.black54, fontSize: 12))
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
}
