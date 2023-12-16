import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/mypage/mypage_controller.dart';
import 'package:zkeep/screens/mypage/mypage_screen.dart';

mypage() {
  return [
    GetPage(
      name: '/mypage',
      page: () => MypageScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(MypageController());
      }),
      transition: Transition.noTransition,
    ),
  ];
}
