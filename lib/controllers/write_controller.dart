import 'package:common_control/common_control.dart';

class WriteController extends GetxController {
  final _period = 0.obs;
  final _ordinal = 0.obs;
  final _date = DateTime.now().obs;
  final _time = TimeOfDay.now().obs;

  int get period => _period.value;
  set period(int value) => _period.value = value;
  int get ordinal => _ordinal.value;
  set ordinal(int value) => _ordinal.value = value;

  DateTime get date => _date.value;
  set date(DateTime value) => _date.value = value;
  TimeOfDay get time => _time.value;
  set time(TimeOfDay value) => _time.value = value;

  final _search = ''.obs;
  String get search => _search.value;
  set search(String value) => _search.value = value;

  final _customer = ''.obs;
  String get customer => _customer.value;
  set customer(String value) => _customer.value = value;

  final _items = [].obs;
  get items => _items;
  set items(value) => _items.value = value;

  @override
  onInit() {
    super.onInit();

    items.add('감일초등학교');
    items.add('고덕평생교육원');
    items.add('광암아리수정수장');
    items.add('강일 리버파크 10단지');
    items.add('강일하수처리장');
    items.add('단샘초등학교');
    items.add('동산중학교');
    items.add('도봉초등학교');
    items.add('목감푸르지오아파트');
    items.add('덕천초등학교');
    items.add('나이키빌');
    items.add('학익신동아8차아파트');
    items.add('영종스카이스타');
    items.add('잠실엘타워');
    items.add('연수1차현대');
    items.add('잠실포레디움');
  }
}
