import 'package:zkeep/controllers/join_controller.dart';
import 'package:common_control/common_control.dart';

class JoinScreen extends CWidget {
  JoinScreen({Key? key}) : super(key: key);

  final JoinController c = Get.find<JoinController>();

  @override
  Widget build(BuildContext context) {
    return CScaffold(
      autoLostFocus: true,
      appBar: AppBar(
        title: const Text('회원가입', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              c.form = false;
              Get.back();
            }),
      ),
      body: CColumn(
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        children: [
          CColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            expanded: true,
            gap: 8,
            children: [
              CButton(
                text: c.form ? '건물사용자' : '개인회원',
                onPressed: () async {
                  if (c.form) {
                    Get.toNamed('/join/buisness/user');
                  } else {
                    Get.toNamed('/join/user');
                  }
                },
                size: CButtonSize.large,
                type: CButtonStyle.outlined,
                margin: const EdgeInsets.only(top: 14, bottom: 0),
              ),
              CButton(
                  text: c.form ? '점검회사' : '사업자',
                  onPressed: () async {
                    if (c.form) {
                      Get.toNamed('/join/buisness/company');
                    } else {
                      Get.toNamed('/join/buisness');
                      c.form = true;
                    }
                  },
                  size: CButtonSize.large,
                  type: CButtonStyle.outlined,
                  margin: const EdgeInsets.only(top: 0, bottom: 0)),
            ],
          ),
        ],
      ),
    );
  }
}
