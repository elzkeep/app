import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/data/view_controller.dart';
import 'package:zkeep/controllers/facility/facility_insert_controller.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/report.dart';
import 'package:zkeep/screens/facility/facility_view_screen.dart';
import 'package:zkeep/screens/facility/facility_insert_screen.dart';

facility() {
  return [
    GetPage(
      name: '/facility/:id',
      page: () => FacilityViewScreen(),
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
      name: '/facility/:id/insert',
      page: () => FacilityInsertScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        int building = 0;
        if (Get.arguments != null) {
          building = Get.arguments['building'];
        }
        Get.put(FacilityInsertController(0, building));
      }),
    ),
  ];
}
