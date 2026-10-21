# 지킴E 앱 출시 체크리스트

코드에서 끝낸 것과, 계정·결정이 필요해 남은 것을 나눠 둔다. (2026-10-21)

## 끝난 것 (release/prep)

- 앱 이름 `지킴E` — iOS `CFBundleDisplayName`, Android `android:label`, 웹 manifest·title
- 앱 아이콘 — `assets/icon/app_icon.png`(1024, 불투명)에서 iOS·Android·웹 아이콘 전부 생성
  - ⚠️ 원본 로고(`assets/imgs/nlogo.png`)가 312px 라 확대한 **임시 아이콘**. 고해상도 원본(벡터/1024 이상)으로 교체 필요
  - 교체 방법: `assets/icon/app_icon.png` 를 바꾸고 각 크기 파일을 다시 만든다 (flutter_launcher_icons 또는 직접 리사이즈)
- iOS 권한 문구 한국어 (카메라·사진 보관함), 쓰지 않는 마이크 권한 제거
- iOS 최소 버전 13.0 (Flutter 3.44 요구), Podfile `platform :ios, '13.0'`
- Android 릴리스 서명: `android/key.properties` 가 있으면 그 키로, 없으면 디버그 키(로컬 확인용)
- 앱 내 회원 탈퇴 (마이페이지 → 회원 탈퇴, 서버 `POST /api/account/withdraw`) — App Store 5.1.1(v)·Play 계정 삭제 정책
- 빌드 산출물(`ios/build`) 추적 해제

## 결정 필요

### 1. 번들 ID / applicationId
지금 `com.example.zkeep` — **Play 는 `com.example.*` 를 받지 않고**, 출시 후에는 바꿀 수 없다.

- Play 스토어에 (주)마이스터의 「지킴E」(`space.zkeep.inspect`)가 이미 있다. 같은 제품이면 그 ID 로 업데이트 배포,
  다른 제품이면 새 ID(예: `space.zkeep.app`)로
- 바꿀 곳: `android/app/build.gradle`(`namespace`, `applicationId`), `android/app/src/main/kotlin/.../MainActivity.kt` 패키지 경로,
  `ios/Runner.xcodeproj/project.pbxproj`(`PRODUCT_BUNDLE_IDENTIFIER` 3곳)

### 2. 배포 방식
B2B 업무 앱이라 일반 공개 대신 Apple **Unlisted App Distribution**(링크로만 설치) / Play 비공개 트랙도 검토.

## 계정·자료가 필요한 것

- [ ] Apple Developer 팀 (`DEVELOPMENT_TEAM` 현재 `CA54Q56PML` — 맞는지 확인), App Store Connect 앱 생성
- [ ] Android 업로드 키 생성 후 **안전한 곳에 백업** (잃으면 업데이트 불가, Play App Signing 사용 권장)
  ```sh
  keytool -genkey -v -keystore ~/zkeep-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
  # android/key.properties (git 제외)
  storeFile=/Users/<you>/zkeep-upload.jks
  storePassword=...
  keyAlias=upload
  keyPassword=...
  ```
- [ ] 개인정보처리방침 URL (수집: 이름·연락처·이메일·주소·사진·서명·위치 아님), 지원 URL
- [ ] 스토어 설명·스크린샷(iPhone 6.9"/6.5", Android 폰), 키워드
- [ ] App Store 개인정보 라벨 / Play 데이터 보안 양식
- [ ] 심사용 **데모 계정**(점검업체 1곳 + 샘플 고객·건물·점검) — 로그인 필수 앱이라 없으면 반려
- [ ] 운영 서버 주소 확인: 앱은 `--dart-define=API_BASE_URL=https://zkeep.space` 로 빌드 (Makefile)

## 빌드

```sh
flutter build apk --release --dart-define=API_BASE_URL=https://zkeep.space      # Play 업로드는 appbundle
flutter build appbundle --release --dart-define=API_BASE_URL=https://zkeep.space
flutter build ipa --release --dart-define=API_BASE_URL=https://zkeep.space
```

## 출시 전 확인

- 서버 PR 배포 순서: elzkeep/back #3 → #5 → #7 → #9 (+ 운영 DB 에 `view.sql` 뷰 적용, `JWT_SECRET` 설정)
- 로그인은 `POST /api/jwt` 로 바뀌었으므로 **구버전 앱은 로그인 불가** — 새 앱과 서버를 함께 배포
- 실기기에서: 로그인 → 오늘 점검 → 점검표 작성(사진·서명) → 보고서 PDF 공유 → 주소검색 → 회원 탈퇴
