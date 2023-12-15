import 'package:zkeep/components/circle_navigation.dart';
import 'package:zkeep/controllers/auth_controller.dart';
import 'package:zkeep/controllers/mypage_controller.dart';
import 'package:common_control/common_control.dart';

class MypageScreen extends CWidget {
  MypageScreen({super.key});

  final c = Get.find<MypageController>();

  @override
  Widget build(BuildContext context) {
    return CScaffold(
        appBar: AppBar(
          title: const Text('마이페이지', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: true,
        ),
        body: body(),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Get.toNamed('/write', arguments: {'mode': 'write'}),
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromRGBO(237, 92, 66, 1.000),
            child: const Icon(Icons.add)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CircleNavigation());
  }

  Widget profile() {
    return CColumn(
        padding: const EdgeInsets.only(top: 46, left: 20, right: 20),
        children: [
          CRow(mainAxisAlignment: MainAxisAlignment.center, children: [
            CContainer(
                onTap: () => clickLogout(),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black45),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                padding: const EdgeInsets.all(5),
                child: CText(
                  '로그아웃',
                  textStyle: const TextStyle(fontSize: 14),
                ))
          ]),
        ]);
  }

  clickLogout() async {
    final authController = Get.find<AuthController>();
    await authController.logout();

    Get.offAllNamed('/');
  }

  Widget body() {
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: CColumn(children: [
          CColumn(
              margin: const EdgeInsets.only(bottom: 8),
              children: [profile(), const SizedBox(height: 26)]),
        ]));
  }
}
