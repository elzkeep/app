import 'package:zkeep/routers/customer.dart';
import 'package:zkeep/routers/data.dart';
import 'package:zkeep/routers/index.dart';
import 'package:zkeep/routers/mypage.dart';

getPages() {
  return index() + data() + mypage() + customer();
}
