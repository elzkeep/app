import 'package:common_control/common_control.dart';
import 'package:zkeep/models/customer.dart';
import 'package:zkeep/models/facility.dart';

class CustomerDetailController extends GetxController {
  CustomerDetailController(this.id, this.item);

  final int id;
  final Customer item;

  final _facility = Facility().obs;
  Facility get facility => _facility.value;
  set facility(Facility value) => _facility.value = value;

  @override
  onInit() async {
    super.onInit();
    getFacility(item.building.id);
  }

  getFacility(int building) async {
    final res = await FacilityManager.find(
        page: 1, params: 'building=$building&category=10');

    if (res.isNotEmpty) {
      facility = res[0];
    }
  }
}
