import 'package:zkeep/components/company.dart';
import 'package:zkeep/components/cselectbutton.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/mypage/customer_box.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/controllers/mypage/customer/list_controller.dart';
import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

class ListScreen extends CWidget {
  ListScreen({super.key});

  final c = Get.find<ListController>();

  @override
  Widget build(BuildContext context) {
    return Layout(
        title: '고객관리',
        popup: true,
        child: CColumn(
            gap: 20, children: [search(), customer(), buttons(), Expanded(child: lists())]));
  }

  customer() {
    return CColumn(gap: 10, children: [
      SubTitle('',
          more: '고객 추가', onMore: () => Get.toNamed('/mypage/customer/insert')),
      CustomerBox()
    ]);
  }

  search() {
    return CTextField(
      text: '고객명, 건물명',
      svg: 'assets/imgs/search.svg',
      margin: const EdgeInsets.only(top: 10),
    );
  }

  buttons() {
    return Obx(() => CSelectButton(
        items: const ['가나다순', '점검대상별', '관리점수순', '예정일순', '계약일순'],
        index: c.search,
        onSelected: (index) => c.search = index));
  }

  lists() {
    return InfiniteScroll<Company>(
      axis: Axis.vertical,
      controller: c,
      builder: list,
      empty: Container(),
    );
  }

  Widget list(Company item, int index) {
    return CompanyWidget(item);
  }
}
