import 'package:common_control/common_control.dart';
import 'package:localstorage/localstorage.dart';
import 'package:zkeep/models/customer.dart';

class CustomerListController extends InfiniteController {
  CustomerListController()
      : super(
            reader: CustomerManager.find, params: 'user=$userId&order=c_name');

  TextEditingController searchTextController = TextEditingController();

  static get userId => LocalStorage('login.json').getItem('user')['id'];

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
  }

  getCustomerCount() async {
    final res = await CustomerManager.find(params: 'user=$userId');

    if (res.isNotEmpty) {
      customerTotal = res.length;

      for (int i = 0; i < res.length; i++) {
        score += res[i].extra['building']['score'];
      }
    }
  }

  search() async {
    if (searchIndex == 1) {
      params = 'order=c_name';
    } else if (searchIndex == 2) {
      params = 'order=b_name';
    } else if (searchIndex == 3) {
      params = 'order=b_score';
    } else if (searchIndex == 4) {
      params = 'order=c_checkday';
    } else if (searchIndex == 5) {
      params = 'order=c_contractday';
    }

    if (searchText != '') {
      if (params != '') {
        params += '&';
      }

      params += 'name=$searchText';
    }

    params += '&user=$userId';

    await reset();
  }
}
