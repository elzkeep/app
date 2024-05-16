import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/mypage/mypage_controller.dart';
import 'package:zkeep/controllers/mypage/mypage_edit_controller.dart';
import 'package:zkeep/controllers/mypage/mypage_edit_license_controller.dart';
import 'package:zkeep/models/license.dart';
import 'package:zkeep/screens/mypage/mypage_edit_screen.dart';
import 'package:zkeep/screens/mypage/mypage_editrecod_license_screen.dart';
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
    GetPage(
      name: '/mypage/editrecod/license',
      page: () => MypageEditRecodLicenseScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final index = Get.arguments['index'];
        License license = License();
        if (Get.arguments['license'] != null) {
          license = Get.arguments['license'];
        }
        Get.put(MypageEditLicenseController(index, license));
      }),
    ),
  ];
}
