import 'package:common_control/common_control.dart';
import 'package:zkeep/models/report.dart';

class ListController extends InfiniteController {
  ListController() : super(reader: ReportManager.find, params: '');

  final _search = 1.obs;
  int get search => _search.value;
  set search(int value) => _search.value = value;
}
