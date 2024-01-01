import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/join_controller.dart';
import 'package:zkeep/controllers/login_controller.dart';
import 'package:zkeep/controllers/main_controller.dart';
import 'package:zkeep/controllers/write_controller.dart';
import 'package:zkeep/screens/join_screen.dart';
import 'package:zkeep/screens/login_screen.dart';
import 'package:zkeep/screens/main_screen.dart';
import 'package:zkeep/screens/write_screen.dart';
import 'package:zkeep/services/auth_service.dart';

index() {
  return [
    GetPage(
      name: '/',
      page: () => MainScreen(),
      middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(MainController());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),
    GetPage(
      name: '/join',
      page: () => JoinScreen(),
      binding: BindingsBuilder(() {
        Get.put(JoinController());
      }),
    ),
    GetPage(
      name: '/write',
      page: () => WriteScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(WriteController());
      }),
    ),
  ];
}
