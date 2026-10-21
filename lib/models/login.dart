import 'package:zkeep/models/user.dart';
import 'package:common_control/common_control.dart';
import 'package:flutter/foundation.dart';

class LoginManager {
  // 결과: 성공이면 user.extra['token'] 이 있는 User, 실패면 빈 User (message 는 extra['message'])
  // 비밀번호가 URL·접근 로그에 남지 않게 POST JSON 으로 보낸다 (서버는 GET /api/jwt 를 막음)
  static Future<User> login(String loginid, String passwd) async {
    try {
      var result =
          await Http.post('/api/jwt', {'loginid': loginid, 'passwd': passwd});

      if (result == null || result['code'] != 'ok') {
        // User() 의 기본 extra 는 const 라 새 맵으로 넘긴다
        return User(extra: {'message': result?['message'] ?? ''});
      }

      final token = result['token'];
      final user = User.fromJson(result['user']);
      user.extra["token"] = token;
      return user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return User();
  }
}
