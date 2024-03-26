import 'package:common_control/common_control.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/customer.dart';
import 'package:zkeep/models/facility.dart';

class CustomerDetailController extends GetxController {
  CustomerDetailController(this.id);

  final int id;

  final _item = Customer().obs;
  Customer get item => _item.value;
  set item(Customer value) => _item.value = value;

  final _company = Company().obs;
  Company get company => _company.value;
  set company(Company value) => _company.value = value;

  final _building = Building().obs;
  Building get building => _building.value;
  set building(Building value) => _building.value = value;

  final _facility = Facility().obs;
  Facility get facility => _facility.value;
  set facility(Facility value) => _facility.value = value;

  @override
  onInit() async {
    super.onInit();
    await getItem();
    await getFacility(item.building.id);
  }

  getItem() async {
    final res = await CustomerManager.get(id);
    item = res;
    company = res.buildingcompany;
    building = res.building;
  }

  getFacility(int building) async {
    final res = await FacilityManager.find(
        page: 1, params: 'building=$building&category=10');

    if (res.isNotEmpty) {
      facility = res[0];
    }
  }
}
