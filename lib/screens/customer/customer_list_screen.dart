import 'package:common_control/common_control.dart';
import 'package:zkeep/components/customer_widget.dart';
import 'package:zkeep/components/cselectbutton.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/customer/customer_box.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/controllers/customer/customer_list_controller.dart';
import 'package:zkeep/models/customer.dart';

class CustomerListScreen extends CWidget {
  CustomerListScreen({super.key});

  final c = Get.find<CustomerListController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Layout(
        title: '고객관리',
        child: CColumn(gap: 20, children: [
          search(),
          customer(),
          buttons(),
          Expanded(child: lists())
        ])));
  }

  customer() {
    return CColumn(gap: 10, children: [
      SubTitle('',
          more: '고객 추가', onMore: () => Get.toNamed('/customer/insert')),
      CustomerBox(total: c.customerTotal, score: c.score)
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
    return InfiniteScroll<Customer>(
      axis: Axis.vertical,
      controller: c,
      builder: list,
      empty: Container(),
    );
  }

  Widget list(Customer item, int index) {
    return CustomerWidget(item);
  }
}
