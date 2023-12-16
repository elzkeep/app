import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/mypage/customer/list_controller.dart';
import 'package:zkeep/controllers/mypage/customer/insert_controller.dart';
import 'package:zkeep/controllers/mypage/customer/view_controller.dart';
import 'package:zkeep/controllers/mypage/customer/detail_controller.dart';
import 'package:zkeep/screens/mypage/customer/list_screen.dart';
import 'package:zkeep/screens/mypage/customer/insert_screen.dart';
import 'package:zkeep/screens/mypage/customer/view_screen.dart';
import 'package:zkeep/screens/mypage/customer/detail_screen.dart';

customer() {
  return [
    GetPage(
      name: '/mypage/customer',
      page: () => ListScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(ListController());
      }),
    ),
    GetPage(
      name: '/mypage/customer/insert',
      page: () => InsertScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(InsertController());
      }),
    ),
    GetPage(
      name: '/mypage/customer/:id',
      page: () => ViewScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(ViewController());

        c.id = int.parse(Get.parameters['id']!);
        c.read();
      }),
    ),
    GetPage(
      name: '/mypage/customer/:id/detail',
      page: () => DetailScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(DetailController());

        c.id = int.parse(Get.parameters['id']!);
        c.read();
      }),
    ),
  ];
}
