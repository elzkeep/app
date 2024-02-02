import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/mypage/mypage_controller.dart';
import 'package:zkeep/controllers/mypage/mypage_edit_controller.dart';
import 'package:zkeep/screens/mypage/mypage_edit_screen.dart';
import 'package:zkeep/screens/mypage/mypage_editrecod_screen.dart';
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
    GetPage(
      name: '/mypage/edit',
      page: () => MypageEditScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(MypageEditController());
      }),
    ),
    GetPage(
      name: '/mypage/editrecod',
      page: () => MypageEditRecodScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(MypageEditController());
      }),
    ),
  ];
}
