import 'dart:io';

import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> downloadAndSharePDF(int id) async {
  final directory = await getApplicationDocumentsDirectory();
  String today = DateFormat('yyyy-MM-dd hh:mm', 'ko_KR').format(DateTime.now());
  final filePath = '${directory.path}/${today}_report.pdf';

  final file = File(filePath);

  var res = await Http.download('/api/report/download/$id');

  await file.writeAsBytes(res);

  // OpenFile.open(filePath);
  Share.shareXFiles([XFile(filePath)]);
}
