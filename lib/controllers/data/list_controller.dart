import 'package:common_control/common_control.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/models/report.dart';

class ListController extends InfiniteController {
  ListController()
      : super(reader: ReportManager.search, params: 'user=$userId');

  TextEditingController searchTextController = TextEditingController();

  static get userId => LocalStorage('login.json').getItem('user')['id'];

  final _searchIndex = 1.obs;
  int get searchIndex => _searchIndex.value;
  set searchIndex(int value) => _searchIndex.value = value;

  final _searchText = ''.obs;
  String get searchText => _searchText.value;
  set searchText(String value) => _searchText.value = value;

  search() async {
    if (searchIndex == 1) {
      params = 'status=${ReportStatus.newer.index}';
    } else if (searchIndex == 2) {
      return;
    } else if (searchIndex == 3) {
      params = 'status=${ReportStatus.newer.index}';
    } else if (searchIndex == 4) {
      params = 'status=${ReportStatus.complete.index}';
    }

    if (searchText != '') {
      if (params != '') {
        params += '&';
      }

      params += 'search=$searchText';
    }

    params += '&user=$userId';

    await reset();
  }
}
