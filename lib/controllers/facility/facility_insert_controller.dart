import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

class FacilityInsertController extends GetxController {
  FacilityInsertController(this.id);

  final int id;

  final _item = Company().obs;
  Company get item => _item.value;
  set item(Company value) => _item.value = value;

  final _type = 0.obs;
  int get type => _type.value;
  set type(int value) => _type.value = value;

  final _position = 0.obs;
  int get position => _position.value;
  set position(int value) => _position.value = value;

  @override
  onInit() async {
    super.onInit();
    item = await CompanyManager.get(id);
  }
}
