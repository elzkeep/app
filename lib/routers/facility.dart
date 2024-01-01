import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/facility/facility_view_controller.dart';
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
        Get.put(FacilityViewController(0));
      }),
    ),
    GetPage(
      name: '/facility/:id/insert',
      page: () => FacilityInsertScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(FacilityInsertController(0));
      }),
    ),
  ];
}
