import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/data/charger_controller.dart';
import 'package:zkeep/controllers/data/change_controller.dart';
import 'package:zkeep/controllers/data/data_controller.dart';
import 'package:zkeep/controllers/data/etc_controller.dart';
import 'package:zkeep/controllers/data/generator_controller.dart';
import 'package:zkeep/controllers/data/high_controller.dart';
import 'package:zkeep/controllers/data/load_controller.dart';
import 'package:zkeep/controllers/data/low_controller.dart';
import 'package:zkeep/controllers/data/sunlight_controller.dart';
import 'package:zkeep/controllers/data/view_controller.dart';
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

data() {
  return [
    GetPage(
      name: '/data',
      page: () => ListScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(DataController());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/data/:id',
      page: () => ViewScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(ViewController());

        c.id = int.parse(Get.parameters['id']!);
      }),
    ),
    GetPage(
      name: '/data/:id/low',
      page: () => LowScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(LowController());

        c.id = int.parse(Get.parameters['id']!);
      }),
    ),
    GetPage(
      name: '/data/:id/high',
      page: () => HighScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(HighController());

        c.id = int.parse(Get.parameters['id']!);
      }),
    ),
    GetPage(
      name: '/data/:id/change',
      page: () => ChangeScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(ChangeController());

        c.id = int.parse(Get.parameters['id']!);
      }),
    ),
    GetPage(
      name: '/data/:id/load',
      page: () => LoadScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(LoadController());

        c.id = int.parse(Get.parameters['id']!);
      }),
    ),
    GetPage(
      name: '/data/:id/generator',
      page: () => GeneratorScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(GeneratorController());

        c.id = int.parse(Get.parameters['id']!);
      }),
    ),
    GetPage(
      name: '/data/:id/etc',
      page: () => EtcScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(EtcController());

        c.id = int.parse(Get.parameters['id']!);
      }),
    ),
    GetPage(
      name: '/data/:id/sunlight',
      page: () => SunlightScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(SunlightController());

        c.id = int.parse(Get.parameters['id']!);
      }),
    ),
    GetPage(
      name: '/data/:id/charger',
      page: () => ChargerScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final c = Get.put(ChargerController());

        c.id = int.parse(Get.parameters['id']!);
      }),
    )
  ];
}
