import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

class ViewController extends GetxController {
  final _id = 0.obs;
  int get id => _id.value;
  set id(int value) => _id.value = value;

  final _item = Company().obs;
  Company get item => _item.value;
  set item(Company value) => _item.value = value;

  read() async {
    item = await CompanyManager.get(id);
    print(item.name);
  }
}
