# 지킴E 앱 네이티브 전환 계획 (iOS SwiftUI / Android Compose)

> 2026-10-21 · 대상: 이 저장소(Flutter) → `zkeep_ios`, `zkeep_android`
> 참고 구현(같은 개발자 운영 중): `snippet_ios`, `snippet_android`, `fotstat_ios`, `gomachine`(코드 생성기)

## 0. 현황

| 항목 | 지금 | 의미 |
|---|---|---|
| 규모 | Dart 약 18,900줄. `facility_insert_screen.dart` 2,635줄, 점검 항목 13종이 `lib/screens/data/dataitem/*.dart` 에 하드코딩 | 비즈니스 로직은 작고 대부분 폼 정의·UI → 옮기기보다 재설계 대상 |
| 구조 | GetX, 경로 의존 `../../common_control`, 토큰을 `localstorage`(`login.json`)에 평문 저장 | 토큰 보관 취약, 빌드 재현성 낮음 |
| 번들 ID | iOS·Android `com.example.zkeep` | 스토어 배포 이력 없음 → 마이그레이션 부담 없음. 단 Play 에 (주)마이스터 「지킴E」(`space.zkeep.inspect`)가 있어 ID 결정 필요 (§6) |
| 인증 | `POST /api/jwt` → JWT 30일, bcrypt (2026-10 정리 완료) | refresh 토큰·`/auth/me` 는 아직 없음 |
| 업로드 | `POST /api/upload/index` (multipart `file`) → `{filename}`, 확장자 허용 목록 | 크기 제한·멱등키 없음 |
| 점검 저장 | `POST /api/dataitem/process` (점검+설비 구분 단위로 덮어쓰기) | 오프라인 동기화 단위로 쓰기 좋다 |
| 보고서 | `GET /api/report/download/:id` → 서버가 PDF 생성 (2026-10 완료) | 클라이언트는 받아서 보기·공유만 |
| 설비 | `facility.value1..25` 범용 컬럼 | 설비 폼도 스키마 기반으로 |
| 코드 생성 | `buildtool-model` 이 Go·Dart·JS 모델 생성. `gomachine/kotlin` 은 서버용(Spring) | Swift·Kotlin **클라이언트** 템플릿은 새로 |

재사용할 패턴
- **snippet_ios**: `Core/Network`(`APIClient`, `Endpoint`, `APIError`, `TokenRefreshCoordinator` actor, `MultipartFormData`), `Core/Auth`(`KeychainTokenStore`, `AuthSession`), `Features/*`, `DesignSystem/*`, fastlane `beta/ship/release/submit/promo` + Makefile + ASC API Key
- **fotstat_ios**: `LoadableViewModel`, `download()`(Content-Disposition 파일명) — 보고서 PDF 에 그대로
- **snippet_android**: 단일 모듈 `core/{network,datastore,model,data,di}` + `ui/<feature>`, 수동 DI `AppContainer`, Retrofit + kotlinx.serialization + OkHttp `AuthInterceptor`/`TokenAuthenticator`, `keystore.properties`, fastlane `internal/alpha/deploy`

## 1. 왜, 언제 네이티브인가

**장점**
- 이미 같은 패턴으로 iOS·Android 네이티브 앱을 운영 중 → 학습 비용 거의 없음, Core 계층 복사로 시작
- 현장 기능 품질: 카메라·사진 압축·서명(PencilKit)·PDF(PDFKit/PdfRenderer)·백그라운드 업로드(URLSession background / WorkManager)·오프라인 DB(SwiftData / Room)를 플랫폼 표준으로
- 부채 청산: GetX, `common_control` 경로 의존, 13종 하드코딩 폼, 평문 토큰 — 어차피 재작성 수준
- `remedi_kopo`·`hand_signature`·`localstorage` 같은 유지보수 불확실한 플러그인 의존 제거 (실제로 2026-10 빌드 복구 때 플러그인 3개가 막았다)

**단점 (1인 기준)**
- 유지비 약 1.6~1.8배 — 기능마다 두 번 구현·두 번 심사. 코드 생성·스키마 폼으로 줄일 수 있는 건 UI 밖 영역뿐
- 초기 일정: Flutter 재설계 6~8주 vs 네이티브 2종 14~16주
- Flutter 웹 빌드를 잃는다 — 관리 웹(`front`, Vue)이 따로 있어 영향은 작지만, 현장 직원이 웹으로 점검한다면 대안 필요

| 안 | 초기 비용 | 장기 유지비 | 현장 품질 | 기존 패턴 재사용 |
|---|---|---|---|---|
| A. Flutter 유지 + 재설계(스키마 폼) | 낮음 | 낮음 | 중 | 낮음 |
| **B. 네이티브 2종 (이 계획)** | 높음 | 높음 | 높음 | **높음** |
| C. KMP(공통 로직) + 네이티브 UI | 중상 | 중 | 높음 | 중 |
| D. 한 플랫폼만 네이티브 | 중 | 높음(두 기술) | 혼합 | 중 |

**권장: B안, 단 순서를 조건부로**
1. **백엔드 선행 작업·점검 스키마 API 먼저 (§5)** — 어느 클라이언트든 필요하고 Flutter 에도 바로 이득
2. 실제 사용자 단말 비율을 보고 **많은 쪽부터** MVP (국내 현장직은 Galaxy 비중이 높아 Android 우선 가능성 — 데이터로 확정. 아래 일정은 iOS 먼저 기준, 바꿔도 됨)
3. 첫 플랫폼을 파일럿 업체 1곳에서 2주 실사용 → 안정화 후 두 번째 시작 (화면 명세·스키마가 확정돼 약 60% 시간)
4. 두 플랫폼 동시 유지가 버거우면 C안(KMP)으로 공통 로직만 합칠 길을 남긴다 (§7)

## 2. 공통 설계

### 2.1 모듈 구조 (snippet 그대로)
```
zkeep_ios/Zkeep/
  App/ Core/{Network, Auth, Models/Generated, Storage(DraftStore·PhotoStore·Outbox), Sync, Schema}
  Features/{Auth, Home, Schedule, Customer, Building, Facility, Inspection, Report, MyPage, Join}
  DesignSystem/ (primary #ED5C42, title #3490B2)   fastlane/ Makefile
zkeep_android/app/src/main/java/<패키지>/
  core/{network, datastore, model/generated, db(Room), sync(WorkManager), schema, di/AppContainer}
  ui/{auth, home, schedule, customer, building, facility, inspection, report, mypage, join, components, theme}
```
단일 모듈로 시작 (1인 규모에서 멀티모듈 이득 없음). ViewModel: iOS `@Observable` + `LoadableViewModel`, Android `ViewModel` + `StateFlow<UiState>`.

### 2.2 API 클라이언트·모델 생성
- `gomachine` 에 클라이언트 템플릿 두 개: `views/swift/model.jet`(Codable struct + 정수 enum·한글 라벨), `views/kotlin-client/model.jet`(`@Serializable data class` + enum)
- `model.json` 의 `method`(GetByLoginid 등)·표준 CRUD 는 `Endpoint`(Swift)·Retrofit interface(Kotlin)로 생성, `controllers/api/*` 커스텀은 수기
- 산출물은 각 앱 `Generated/` 에 커밋 (빌드 시점 의존 회피). `back/Makefile` `model` 타깃에 추가
- 주의: Dart 는 enum 을 int 인덱스로 직렬화 — 생성 enum 도 **서버 정수값과 같은 순서**, 모르는 값은 `.unknown`. 날짜 `yyyy-MM-dd HH:mm:ss` 는 한곳에서
- 공통 헤더: `Authorization: Bearer`, `X-App-Version`, `X-App-Platform`, 쓰기에 `Idempotency-Key`

### 2.3 인증
- 서버: `POST /api/auth/refresh`, `POST /api/auth/logout`, `GET /api/auth/me` 추가 (§5). `/auth/` 경로의 401 은 refresh 하지 않는 snippet 규칙 재사용
- iOS `KeychainTokenStore`(`kSecAttrAccessibleAfterFirstUnlock`), `TokenRefreshCoordinator` — 서버가 거부할 때만 로그아웃
- Android: 고객 정보를 다루는 B2B 앱이라 **Android Keystore AES-GCM 으로 암호화해 DataStore 에** (EncryptedSharedPreferences 는 deprecated). `TokenAuthenticator` 는 snippet 복사

### 2.4 오프라인·임시저장 (현장 음영지역)
- **점검표 작성은 로컬 우선** — 입력마다 로컬 DB 저장, 서버 전송은 Outbox
- `InspectionDraft(reportId, topcategory, schemaVersion, answers, updatedAt, syncState)`, `PhotoAsset(localPath, draftId, itemKey, uploadState, serverFilename)`, `OutboxOp(id, kind, payload, attempt, lastError)`
- 동기화: ① 사진 업로드 → 서버 파일명 ② answers 의 사진 키 치환 ③ `POST /api/dataitem/process` (점검+구분 단위 덮어쓰기라 재시도 안전)
- 트리거: 포그라운드·네트워크 복구·수동 「지금 전송」·백그라운드(BGProcessingTask / WorkManager)
- 캐시: 오늘·이번 주 일정, 담당 고객·건물·설비, 점검 스키마를 로그인 직후·아침 첫 실행에 미리
- 충돌: 서버 `report` 가 draft 기준 시각보다 새로우면 확인 (1차는 last-write-wins + 경고). UI 에 「전송 대기 N건」

### 2.5 사진·서명·PDF
- 사진: iOS `PhotosPicker` + 카메라, Android Photo Picker + `TakePicture`(FileProvider, CAMERA 권한 불필요). 긴 변 1600px·JPEG 0.7, 실패 시 지수 백오프 5회
- 서명: iOS PencilKit(`drawingPolicy = .anyInput`) → PNG, Android Compose `Canvas` + `pointerInput` → PNG.
  지금 서버는 서명을 **SVG 문자열**로 받아 PDF 에 래스터화한다 → PNG 업로드 파일명으로 바꾸면 서버 PDF 쪽도 이미지 경로 처리 추가
- PDF: 서버 생성본을 받아 iOS `PDFView` / Android `PdfRenderer`, 공유는 `ShareLink` / `ACTION_SEND`. 서명 완료 전에는 비활성

### 2.6 스키마 기반 점검 폼 (13종 하드코딩 제거)
지금 `low.dart` 등은 `Dataitem(data: Data(type, title, category, order), items: [Item(type: select/text/status, title, unit, extra:{select, default, visible, end})])` — 이미 스키마 모양이라 JSON 으로 옮기면 된다.
```json
{ "category": 1, "name": "저압", "version": 3,
  "sections": [
    { "key": "low.voltage", "title": "전압 및 전류 계측값", "type": "single",
      "items": [
        { "key": "main", "kind": "select", "title": "Main 전압/전류", "options": ["전압","380v/220v","220v"], "default": 1, "bind": "value" },
        { "key": "a", "kind": "number", "title": "A상", "unit": "V", "visibleWhen": {"main": 1}, "bind": "content" } ]},
    { "key": "low.mccb", "title": "배선용 차단기 적정성", "type": "multi", "items": [{ "key": "status", "kind": "status" }] } ] }
```
- `kind`: `text | number | select | status(적합/부적합/요주의/해당없음 + 사유·조치·사진) | photo | signature`, `visibleWhen` = 지금의 `extra.visible`, `multi` = 반복 그룹
- `bind` 로 기존 `item` 컬럼(`value`, `content`, `status`, `reason` …)에 매핑 → **서버 DB·관리 웹·보고서 PDF 변경 없음**
- 서버 PDF 의 선택지 라벨표(`back/controllers/api/reportlabels.go`, 지금은 앱 코드에서 추출)도 이 스키마로 대체
- 설비 등록(`facility.value1..25`)도 같은 렌더러로 → 2,635줄 화면이 JSON + 렌더러로
- 렌더러: iOS `SchemaFormView`, Android `SchemaForm()`. 같은 JSON fixture 로 두 플랫폼 스냅샷 테스트

## 3. 화면 매핑과 우선순위

| Flutter 화면 | iOS | Android | 우선 |
|---|---|---|---|
| login | `LoginView` | `LoginScreen` | **P0** |
| main (오늘 일정·캘린더·통계) | `HomeView` (차트 Swift Charts) | `HomeScreen` (snippet 캘린더·차트 패턴) | **P0** 일정 / P1 차트 |
| data/list | `ReportListView` (필터·동기화 상태) | `ReportListScreen` | **P0** |
| data/write + dataitem 13종 | `InspectionFormView` + `SchemaFormView` | `InspectionFormScreen` + `SchemaForm` | **P0** |
| data/view (결과·서명·PDF) | `ReportDetailView` + `SignatureSheet` + `PDFPreviewView` | 동일 | **P0** |
| customer list/view/detail | `CustomerListView`, `CustomerDetailView` | 동일 | **P0** 조회 |
| customer insert/update (주소검색) | `CustomerEditView` + `AddressSearchView`(다음 우편번호 WebView) | 동일 | P1 |
| facility view / insert | `FacilityDetailView` / `FacilityEditView`(스키마) | 동일 | P1 |
| write (점검일정 등록) | `ScheduleEditView` | 동일 | P1 |
| mypage / edit / 이력·자격증 | `MyPageView`, `ProfileEditView`, `CareerListView`, `LicenseEditView` | 동일 | P1 / P2 |
| join (6개) | `JoinFlow` | `JoinNavGraph` | P2 (웹 가입으로 대체 검토) |
| (신규) 전송 대기함·설정·탈퇴·강제 업데이트 | `OutboxView`, `SettingsView` | snippet `ui/update` | **P0** 탈퇴·대기함 |

**MVP(P0)**: 로그인 → 오늘 일정 → 고객·건물 조회 → 점검표(스키마·사진·오프라인 draft) → 서명 → 제출 → 보고서 PDF 보기·공유 + 회원 탈퇴. 가입은 MVP 에서 빼고 관리자 계정 발급으로 대체.

## 4. 일정 (1인, 주 단위)

| 주 | 단계 | 작업 | 완료 기준 |
|---|---|---|---|
| W1–2 | **M0 백엔드** | §5 의 1~3, 스키마 JSON 13종 추출·검수 | login→refresh→upload→process 흐름 통과, 기존 Flutter·웹 정상 |
| W2 | 코드 생성 | gomachine `swift`·`kotlin-client` 템플릿 | 전체 테이블 생성·컴파일, enum 정수값 테스트 |
| W3 | **M1 iOS 골격** | 프로젝트·snippet Core 이식, 로그인/자동로그인, fastlane `beta` | TestFlight 내부 빌드로 로그인 |
| W4 | 조회 | 홈·점검 목록·고객/건물, 읽기 캐시 | 비행기 모드에서 오늘 일정·고객 표시 |
| W5–6 | **M2 점검표** | 스키마 렌더러, draft, 사진, Outbox·SyncEngine | 13종 fixture 렌더, 오프라인 작성 → 복구 후 자동 전송 → 웹에서 동일 데이터 |
| W7 | 서명·보고서 | 서명 2종, 상태 전이, PDF, 탈퇴 | PDF 에 입력값·사진·서명 반영 |
| W8 | **M3 파일럿** | 버그·접근성·크래시 수집 | 2주간 데이터 유실 0, 크래시프리 99%+ |
| W9–12 | **M4 Android MVP** | snippet_android 골격, 같은 fixture 렌더러, Room·WorkManager, fastlane `internal` | iOS 와 같은 MVP 시나리오 통과 |
| W13–15 | **M5 P1** (양쪽) | 일정 등록, 고객 등록(주소검색), 설비(스키마), 마이페이지, 차트 | Flutter 기능 동등 → Flutter 동결 |
| W16 | 출시 | 메타데이터·심사 | 양 스토어 출시 (P2 는 후속) |

버퍼 2~3주 별도. Android 먼저라면 W3–8 과 W9–12 의 플랫폼만 바꾼다.

## 5. 백엔드 선행 작업 (`back`)

| # | 작업 | 상태 |
|---|---|---|
| 1 | POST 로그인, bcrypt, JWT 키 필수·만료 단축 | ✅ 2026-10 (back#7) |
| 2 | refresh 토큰(회전형, `token` 테이블)·`/auth/refresh`·`/auth/logout`·`/auth/me`, 401/403 구분 | 할 일 |
| 3 | 업로드: 크기 제한(10MB), `Idempotency-Key` | 확장자 허용 목록만 ✅ |
| 4 | 점검 스키마 API `GET /api/inspection/schema?since=` + `dataitem/process` 에 `schemaVersion` | 할 일 |
| 5 | 보고서 PDF 실제 생성 | ✅ 2026-10 (back#5). 서명 PNG 지원은 추가 |
| 6 | 회원 탈퇴 | ✅ 2026-10 (back#9) |
| 7 | `X-App-Version` 최소 버전 응답, 목록 `updatedSince`(증분 캐시) | 할 일 |

## 6. 배포

- **번들 ID** — `com.example.zkeep` 은 쓸 수 없다. Play 의 「지킴E」(`space.zkeep.inspect`, (주)마이스터)와 같은 제품이면 그 ID 로 업데이트, 아니면 새 ID(예: `space.zkeep.app` — 도메인 `zkeep.space` 역순). 표시명 「지킴E」
- iOS: 자동 서명, Team ID 확인(현재 Flutter 프로젝트 `CA54Q56PML`), ASC API Key 는 `fastlane/.env`, `.p8` 커밋 금지
- fastlane iOS: `ios-fastlane-release` 스킬(golden = `snippet_ios/fastlane/Fastfile`)로 `beta/ship/release/submit/promo`
- Android: 새 업로드 키스토어 + `keystore.properties`(gitignore), Play App Signing, snippet 의 `internal/alpha/deploy` 레인. 개인 개발자 계정의 신규 앱은 「테스터 12명·14일 비공개 테스트」 요건 확인
- B2B 배포: Apple **Unlisted App Distribution** 검토. 심사용 **데모 계정·샘플 데이터** 필수
- 메타데이터: `fastlane/metadata/ko/`(이름·부제 「전기안전관리 점검 업무」·설명·키워드·개인정보처리방침·지원 URL), 스크린샷 6.9"/6.5", 개인정보 라벨·Play 데이터 보안(이름·연락처·사진·사용자 콘텐츠)
- 권한 문구: 카메라 「점검 현장의 설비 사진을 찍어 점검표에 첨부하기 위해 카메라를 사용합니다.」, 사진 보관함(PhotosPicker 만 쓰면 생략 가능). Android 는 Photo Picker·TakePicture 로 런타임 권한 없음
- 회원 탈퇴: 앱 안에서 (App Store 5.1.1(v)) — 서버 API 는 준비됨

## 7. 리스크와 대안

| 리스크 | 영향 | 대응 |
|---|---|---|
| 두 플랫폼 유지비 | 기능 속도 저하 | 스키마 폼으로 UI 변경을 서버 JSON 으로 흡수, 코드 생성, 동일 fixture 테스트. 계속 버거우면 KMP |
| 스키마 이전 오류 (13종 + 설비 25필드) | 기존 데이터·PDF 불일치 | `bind` 명시, 과거 점검 10건을 신·구 앱으로 재입력해 DB diff |
| 오프라인 동기화 유실 | 현장 신뢰 하락 (가장 치명적) | local-first, Outbox 멱등키, 「전송 대기」 노출, 로그아웃 전 미전송 경고, 파일럿 유실 0 확인 |
| 토큰 정책 전환 | 기존 사용자 로그아웃 | refresh 도입 시 구 토큰 유예 |
| 다음 우편번호 WebView 정책 변경 | 주소검색 불가 | 서버 프록시로 행안부 도로명주소 API 대체 경로 |
| 스토어 심사 (B2B·로그인 필수) | 출시 지연 | 데모 계정·심사 메모·Unlisted |
| 저사양 단말 | 사진 처리 OOM | 다운샘플 디코드, minSdk 26 / iOS 17 |

**C안 — Kotlin Multiplatform**: 생성 모델·Ktor 클라이언트·토큰 refresh·스키마 파싱/`visibleWhen`·검증·Outbox/동기화·SQLDelight 를 공유 (앱 로직 40~50%), UI 는 SwiftUI·Compose 각각.
비용은 iOS 빌드에 Gradle·KMP 가 끼고 snippet_ios 패턴(URLSession·Keychain·actor)을 그대로 못 쓰는 것. M4 시점에 「같은 버그를 두 번 고친」 사례가 동기화·스키마에 몰리면 그 두 영역만 `shared` 로 추출. 처음부터 KMP 는 비권장.

**A안 — Flutter 재설계**: §5 백엔드 작업 + §2.6 스키마 폼만 Flutter 에 적용해도 하드코딩·보안 문제 대부분 해결. 일정·인력상 네이티브를 미뤄야 하면 비용 대비 효과가 가장 크다 — 「백엔드·스키마 먼저」 순서가 이 대안을 열어 둔다.

## 핵심 파일
- `back/router/auth.go`, `back/router/signup.go` — 로그인·토큰
- `back/controllers/api/reportpdf.go`, `reportlabels.go` — 보고서 PDF (스키마로 대체될 라벨표)
- `back/model.json.example`, `gomachine/views/` — 클라이언트 템플릿 추가 위치
- `app/lib/screens/data/dataitem/`, `app/lib/screens/facility/facility_insert_screen.dart` — 스키마 추출 원본
- `snippet_ios/Snippet/Core/Network/APIClient.swift`, `snippet_android/.../core/network/TokenAuthenticator.kt`, `snippet_ios/fastlane/Fastfile` — 기준 구현
