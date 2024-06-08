import 'dart:typed_data';
import 'dart:html' as html;

import 'package:common_control/common_control.dart';
import 'package:intl/intl.dart';

Future<void> downloadAndSharePDF(int id) async {
  String today = DateFormat('yyyy-MM-dd hh:mm', 'ko_KR').format(DateTime.now());

  var res = await Http.download('/api/report/download/$id');

  Uint8List bytes = res;

  // Blob 생성
  final blob = html.Blob([bytes], 'application/pdf');

  // 앵커 엘리먼트 생성 및 클릭하여 파일 다운로드
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', '${today}_report.pdf')
    ..click();
  html.Url.revokeObjectUrl(url);

  // 웹 공유 API 사용하여 링크 공유
  try {
    await html.window.navigator.share({
      'title': 'PDF Report',
      'text': 'Here is the PDF report',
      'url': url,
    });
  } catch (e) {
    print('Web share API is not supported in this browser.');
  }
}
