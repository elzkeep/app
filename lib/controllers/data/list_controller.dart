import 'package:common_control/common_control.dart';
import 'package:zkeep/models/report.dart';

class ListController extends InfiniteController {
  ListController() : super(reader: ReportManager.search, params: '');

  TextEditingController searchTextController = TextEditingController();

  final _searchIndex = 1.obs;
  int get searchIndex => _searchIndex.value;
  set searchIndex(int value) => _searchIndex.value = value;

  final _searchText = ''.obs;
  String get searchText => _searchText.value;
  set searchText(String value) => _searchText.value = value;

  search() async {
    if (searchIndex == 1) {
      params = '';
    } else if (searchIndex == 2) {
      return;
    } else if (searchIndex == 3) {
      params = 'status=${ReportStatus.newer.index}';
    } else if (searchIndex == 4) {
      params = 'status=${ReportStatus.check.index}';
    }

    if (searchText != '') {
      if (params != '') {
        params += '&';
      }

      params += 'search=$searchText';
    }

    await reset();
  }
}
