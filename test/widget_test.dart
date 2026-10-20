import 'package:flutter_test/flutter_test.dart';
import 'package:zkeep/models/report.dart';
import 'package:zkeep/models/reportstatusextension.dart';

void main() {
  test('ReportStatus는 서버 status 값 순서와 일치한다', () {
    expect(ReportStatus.values[0], ReportStatus.none);
    expect(ReportStatus.values[1], ReportStatus.newer);
    expect(ReportStatus.values[2], ReportStatus.ing);
    expect(ReportStatus.values[3], ReportStatus.check);
    expect(ReportStatus.values[4], ReportStatus.complete);
  });

  test('ReportStatus label은 한글 상태명을 반환한다', () {
    expect(ReportStatus.newer.label, '신규');
    expect(ReportStatus.ing.label, '점검중');
    expect(ReportStatus.check.label, '작성완료');
    expect(ReportStatus.complete.label, '점검완료');
  });
}
