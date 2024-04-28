import 'package:common_control/common_control.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/models/building.dart';
import 'package:zkeep/models/customer.dart';

class CustomerListController extends InfiniteController {
  CustomerListController()
      : super(reader: CustomerManager.find, params: 'user=$userId');

  TextEditingController searchTextController = TextEditingController();

  static final userId = LocalStorage('login.json').getItem('user')['id'];

  final _searchIndex = 1.obs;
  int get searchIndex => _searchIndex.value;
  set searchIndex(int value) => _searchIndex.value = value;

  final _searchText = ''.obs;
  String get searchText => _searchText.value;
  set searchText(String value) => _searchText.value = value;

  final _customerTotal = 0.obs;
  get customerTotal => _customerTotal.value;
  set customerTotal(value) => _customerTotal.value = value;

  final _score = 0.0.obs;
  get score => _score.value;
  set score(value) => _score.value = value;

  @override
  onInit() async {
    super.onInit();
    await getCustomerCount();
    await getBuildingScore();
  }

  getCustomerCount() async {
    final res = await CustomerManager.find(params: 'user=$userId');

    if (res.isNotEmpty) {
      customerTotal = res.length;
    }
  }

  getBuildingScore() async {
    final res = await BuildingManager.find();

    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        score += res[i].score;
      }
    }
  }

  search() async {
    if (searchIndex == 1) {
      params = '';
    } else if (searchIndex == 2) {
      // params = 'status=${ReportStatus.newer.index}';
      params = '';
    } else if (searchIndex == 3) {
      // params = 'status=${ReportStatus.ing.index}';
      params = '';
    } else if (searchIndex == 4) {
      // params = 'status=${ReportStatus.check.index}';
      params = '';
    } else if (searchIndex == 5) {
      // params = 'status=${ReportStatus.complete.index}';
      params = '';
    }

    if (searchText != '') {
      if (params != '') {
        params += '&';
      }

      params += 'search=$searchText';
    }

    if (searchIndex != 0) {
      params += 'user=$userId';
    } else {
      params += '&user=$userId';
    }

    await reset();
  }
}
