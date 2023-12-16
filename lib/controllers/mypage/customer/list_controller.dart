import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';

class ListController extends InfiniteController {
  ListController() : super(reader: CompanyManager.find, params: '');

  final _search = 1.obs;
  int get search => _search.value;
  set search(int value) => _search.value = value;
}
