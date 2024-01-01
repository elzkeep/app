import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

class FacilityViewController extends GetxController {
  FacilityViewController(this.id);

  final int id;

  final _item = Company().obs;
  Company get item => _item.value;
  set item(Company value) => _item.value = value;

  @override
  onInit() async {
    super.onInit();
    item = await CompanyManager.get(id);
  }
}
