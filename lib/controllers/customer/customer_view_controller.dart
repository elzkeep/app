import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/report.dart';

class CustomerViewController extends GetxController {
  CustomerViewController(this.id);

  final int id;

  final _item = Company().obs;
  Company get item => _item.value;
  set item(Company value) => _item.value = value;

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  @override
  onInit() async {
    super.onInit();
    item = await CompanyManager.get(id);
    find(1);
  }

  find(int companyNo) async {
    final ret = await ReportManager.find(params: 'company=$companyNo');

    items = ret;
  }
}
