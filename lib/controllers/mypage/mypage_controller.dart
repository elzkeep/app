import 'package:common_control/common_control.dart';

class MypageController extends GetxController {
  final _search = 1.obs;
  int get search => _search.value;
  set search(int value) => _search.value = value;
}
