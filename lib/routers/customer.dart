import 'package:common_control/common_control.dart';
import 'package:zkeep/controllers/customer/customer_detail_controller.dart';
import 'package:zkeep/controllers/customer/customer_insert_controller.dart';
import 'package:zkeep/controllers/customer/customer_list_controller.dart';
import 'package:zkeep/controllers/customer/customer_update_controller.dart';
import 'package:zkeep/controllers/customer/customer_view_controller.dart';
import 'package:zkeep/models/customer.dart';
import 'package:zkeep/screens/customer/customer_detail_screen.dart';
import 'package:zkeep/screens/customer/customer_insert_screen.dart';
import 'package:zkeep/screens/customer/customer_list_screen.dart';
import 'package:zkeep/screens/customer/customer_update_screen.dart';
import 'package:zkeep/screens/customer/customer_view_screen.dart';

customer() {
  return [
    GetPage(
      name: '/customer',
      page: () => CustomerListScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(CustomerListController());
      }),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: '/customer/insert',
      page: () => CustomerInsertScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        Get.put(CustomerInsertController());
      }),
    ),
    GetPage(
      name: '/customer/:id',
      page: () => CustomerViewScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final id = int.parse(Get.parameters['id']!);
        Customer item = Customer();
        if (Get.arguments != null) {
          item = Get.arguments['item'];
        }
        Get.put(CustomerViewController(id, item));
      }),
    ),
    GetPage(
      name: '/customer/:id/detail',
      page: () => CustomerDetailScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final id = int.parse(Get.parameters['id']!);
        Get.put(CustomerDetailController(id));
      }),
    ),
    GetPage(
      name: '/customer/:id/update',
      page: () => CustomerUpdateScreen(),
      //middlewares: [AuthService()],
      binding: BindingsBuilder(() {
        final id = int.parse(Get.parameters['id']!);
        final index = Get.arguments['index'];
        Get.put(CustomerUpdateController(id, index));
      }),
    ),
  ];
}
