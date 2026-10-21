import 'package:common_control/common_control.dart';
import 'package:zkeep/models/company.dart';
import 'package:zkeep/models/department.dart';

// 회원가입 전용 공개 API (back/router/signup.go). 생성 모델이 아니라 수기 파일.
// 비로그인 상태에서 사용자·업체 API 를 직접 부르던 것을 대신한다 — 레벨·승인 상태는 서버가 정한다.
class SignupManager {
  static List<dynamic> _items(dynamic result) {
    if (result == null || result['code'] != 'ok' || result['items'] == null) {
      return [];
    }
    return result['items'] as List<dynamic>;
  }

  // 가입할 수 있는 점검업체 (id, name)
  static Future<List<Company>> companies() async {
    final result = await Http.get('/api/signup/companies');
    return _items(result)
        .map((e) => Company(id: e['id'] as int, name: e['name'] as String))
        .toList();
  }

  // 업체의 팀 (id, name)
  static Future<List<Department>> departments(int company) async {
    final result =
        await Http.get('/api/signup/departments', {'company': company});
    return _items(result)
        .map((e) => Department(id: e['id'] as int, name: e['name'] as String))
        .toList();
  }

  // 이미 쓰이는 값인지 — {loginid: bool, email: bool, companyno: bool}
  static Future<Map<String, dynamic>> check(
      {String loginid = '', String email = '', String companyno = ''}) async {
    final result = await Http.post('/api/signup/check',
        {'loginid': loginid, 'email': email, 'companyno': companyno});
    if (result == null) {
      return {};
    }
    return Map<String, dynamic>.from(result);
  }

  // 기존 점검업체에 직원으로 가입 (승인 대기). 실패하면 오류 메시지, 성공하면 null
  static Future<String?> user(
      Map<String, dynamic> user, List<Map<String, dynamic>> licenses) async {
    final result =
        await Http.post('/api/signup/user', {'user': user, 'licenses': licenses});
    if (result == null) {
      return '가입에 실패했습니다';
    }
    if (result['code'] != 'ok') {
      return (result['message'] ?? '가입에 실패했습니다') as String;
    }
    return null;
  }

  // 점검업체 + 관리자 계정
  static Future<String?> company(Map<String, dynamic> company,
      Map<String, dynamic> user, List<Map<String, dynamic>> licenses) async {
    final result = await Http.post('/api/signup/company',
        {'company': company, 'user': user, 'licenses': licenses});
    if (result == null) {
      return '가입에 실패했습니다';
    }
    if (result['code'] != 'ok') {
      return (result['message'] ?? '가입에 실패했습니다') as String;
    }
    return null;
  }
}
