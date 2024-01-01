import 'package:common_control/common_control.dart';
import 'package:zkeep/components/company.dart';
import 'package:zkeep/components/layout.dart';
import 'package:zkeep/controllers/customer/customer_view_controller.dart';

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
          CButton(
              text: '더보기',
              margin: const EdgeInsets.only(top: 10),
              flex: 1,
              size: CButtonSize.xsmall,
              type: CButtonStyle.outlined,
              onPressed: () => clickMore()),
          Expanded(child: Container())
        ]));
  }

  clickMore() {
    Get.toNamed('/customer/${c.id}/detail');
  }
}
