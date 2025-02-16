import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/data/list_controller.dart';
import 'package:zkeep/controllers/data/view_controller.dart';
import 'package:zkeep/controllers/data/write_controller.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/report.dart';
import 'package:zkeep/screens/data/list_screen.dart';
import 'package:zkeep/screens/data/view_screen.dart';
import 'package:zkeep/screens/data/write_screen.dart';

data() {
  return [
    GetPage(
      name: '/data',
      page: () => ListScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(ListController());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/data/:id',
      page: () => ViewScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Report item = Report();
        Building building = Building();
        if (Get.arguments['item'] != null) {
          item = Get.arguments['item'];
        }
        if (Get.arguments['building'] != null) {
          building = Get.arguments['building'];
        }
        final id = int.parse(Get.parameters['id']!);
        Get.put(ViewController(id, building, item));
      }),
    ),
    GetPage(
      name: '/data/:id/write/:category',
      page: () => WriteScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final id = int.parse(Get.parameters['id']!);
        final category = int.parse(Get.parameters['category']!);
        bool diable = false;
        Report item = Report();
        if (Get.arguments != null) {
          item = Get.arguments['item'];
          diable = Get.arguments['disable'];
        }
        Get.put(WriteController(id, category, item, diable));
      }),
    ),
  ];
}
