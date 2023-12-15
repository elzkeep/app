import 'package:common_control/common_control.dart';

class ViewController extends GetxController {
  final _id = 0.obs;
  int get id => _id.value;
  set id(int value) => _id.value = value;

  final _volt = 0.obs;
  int get volt => _volt.value;
  set volt(int value) => _volt.value = value;
}
