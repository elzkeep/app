import 'package:zkeep/components/layout.dart';
import 'package:zkeep/components/mypage/customer_box.dart';
import 'package:zkeep/components/sub_title.dart';
import 'package:zkeep/controllers/mypage/mypage_controller.dart';
import 'package:common_control/common_control.dart';

class MypageScreen extends CWidget {
  MypageScreen({super.key});

  final c = Get.find<MypageController>();

  @override
  Widget build(BuildContext context) {
    return Layout(title: '마이페이지', child: CColumn(children: [customer()]));
  }

  customer() {
    return CColumn(gap: 10, children: [
      SubTitle('고객관리',
          more: '더보기', onMore: () => Get.toNamed('/mypage/customer')),
      CustomerBox()
    ]);
  }
}
