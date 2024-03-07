import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/facility/facility_insert_controller.dart';
import 'package:zkeep/screens/facility/facility_view_screen.dart';
import 'package:zkeep/screens/facility/facility_insert_screen.dart';

facility() {
  return [
    GetPage(
      name: '/facility/:id',
      page: () => FacilityViewScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        // int building = 0;
        // if (Get.arguments != null) {
        //   building = Get.arguments['building'];
        // }
        // Get.put(ViewController());
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
