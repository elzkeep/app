import 'package:common_control/common_control.dart';
import 'package:zkeep/models/customer.dart';
import 'package:zkeep/models/report.dart';

class CustomerViewController extends GetxController {
  CustomerViewController(this.id, this.item);

  final int id;
  final Customer item;

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  @override
  onInit() async {
    super.onInit();
    find(item.company);
  }

  find(int company) async {
    final ret = await ReportManager.find(params: 'company=$company');

    items = ret;
  }
}
