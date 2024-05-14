import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/join_controller.dart';
import 'package:zkeep/controllers/login_controller.dart';
import 'package:zkeep/controllers/main_controller.dart';
import 'package:zkeep/controllers/write_controller.dart';
import 'package:zkeep/screens/join/join_buisness_company_screen.dart';
import 'package:zkeep/screens/join/join_buisness_user_screen.dart';
import 'package:zkeep/screens/join/join_company_detail_screen.dart';
import 'package:zkeep/screens/join/join_screen.dart';
import 'package:zkeep/screens/join/join_user_detail_screen.dart';
import 'package:zkeep/screens/join/join_user_screen.dart';
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
        Get.put(JoinController(0, 0));
      }),
    ),
    GetPage(
      name: '/join/user',
      page: () => JoinUserScreen(),
      binding: BindingsBuilder(() {
        int companyId = 0;
        int departmentId = 0;
        if (Get.parameters['company'] != null) {
          companyId = int.parse(Get.parameters['company']!);
        }
        if (Get.parameters['department'] != null) {
          departmentId = int.parse(Get.parameters['department']!);
        }
        Get.put(JoinController(companyId, departmentId));
      }),
    ),
    GetPage(
      name: '/join/user/detail',
      page: () => JoinUserDetailScreen(),
      binding: BindingsBuilder(() {
        Get.put(JoinController(0, 0));
      }),
    ),
    GetPage(
      name: '/join/buisness',
      page: () => JoinScreen(),
      binding: BindingsBuilder(() {
        Get.put(JoinController(0, 0));
      }),
    ),
    GetPage(
      name: '/join/buisness/user',
      page: () => JoinBuisnessUserScreen(),
      binding: BindingsBuilder(() {
        Get.put(JoinController(0, 0));
      }),
    ),
    GetPage(
      name: '/join/buisness/company',
      page: () => JoinBuisnessCompanyScreen(),
      binding: BindingsBuilder(() {
        Get.put(JoinController(0, 0));
      }),
    ),
    GetPage(
      name: '/join/buisness/company/detail',
      page: () => JoinCompanyDetailScreen(),
      binding: BindingsBuilder(() {
        Get.put(JoinController(0, 0));
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
