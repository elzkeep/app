import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/data/data_controller.dart';
import 'package:zkeep/controllers/data/low_controller.dart';
import 'package:zkeep/controllers/data/view_controller.dart';
import 'package:zkeep/controllers/join_controller.dart';
import 'package:zkeep/controllers/login_controller.dart';
import 'package:zkeep/controllers/main_controller.dart';
import 'package:zkeep/controllers/write_controller.dart';
import 'package:zkeep/screens/data/change_screen.dart';
import 'package:zkeep/screens/data/charger_screen.dart';
import 'package:zkeep/screens/data/etc_screen.dart';
import 'package:zkeep/screens/data/generator_screen.dart';
import 'package:zkeep/screens/data/high_screen.dart';
import 'package:zkeep/screens/data/list_screen.dart';
import 'package:zkeep/screens/data/load_screen.dart';
import 'package:zkeep/screens/data/low_screen.dart';
import 'package:zkeep/screens/data/sunlight_screen.dart';
import 'package:zkeep/screens/data/view_screen.dart';
import 'package:zkeep/screens/join_screen.dart';
import 'package:zkeep/screens/login_screen.dart';
import 'package:zkeep/screens/main_screen.dart';
import 'package:zkeep/screens/write_screen.dart';

index() {
  return [
    GetPage(
      name: '/',
      page: () => MainScreen(),
      //middlewares: [AuthService()],
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
