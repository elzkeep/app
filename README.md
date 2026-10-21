# zkeep app

지킴E 현장 점검 앱 — 점검자가 오늘 일정 확인, 점검표 작성(사진·서명), 설비 등록, 보고서 PDF 공유. Flutter 3.44 + GetX.
프로젝트 전체 설명은 [back/docs/PROJECT.md](https://github.com/elzkeep/back/blob/main/docs/PROJECT.md).

```sh
# common_control(공용 위젯·HTTP)을 이 저장소 옆 ../../common_control 에 두고
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:9303
flutter build apk --release --dart-define=API_BASE_URL=https://zkeep.space
```

- `lib/screens/data/dataitem/*` 점검 항목 정의 13종 (서버 PDF 의 선택지 라벨도 여기서 추출)
- `lib/components/kopo` 주소검색(다음 우편번호), `lib/models/signup.dart` 가입 API
- 출시 체크리스트: [docs/RELEASE.md](docs/RELEASE.md) · 네이티브 전환 계획: [docs/NATIVE_PLAN.md](docs/NATIVE_PLAN.md)
