import 'package:common_control/common_control.dart';
import 'package:zkeep/models/customer.dart';

class CustomerListController extends InfiniteController {
  CustomerListController() : super(reader: CustomerManager.find, params: '');

  final _search = 1.obs;
  int get search => _search.value;
  set search(int value) => _search.value = value;
}
