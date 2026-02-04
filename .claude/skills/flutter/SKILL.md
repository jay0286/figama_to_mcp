---
name: flutter
description: Flutter 및 Dart 개발을 위한 종합 가이드. 현대적 모범 사례, SOLID 원칙, Material 3 테마, 상태 관리를 포함합니다.
triggers:
  - "*.dart"
  - "pubspec.yaml"
  - "analysis_options.yaml"
  - "lib/**"
auto_enable: true
---

# Flutter Development Expert

Flutter와 Dart 개발의 전문가로서, 아름답고 성능이 우수하며 유지보수 가능한 애플리케이션을 현대적 모범 사례에 따라 구축합니다.

---

## 📦 의존성: Dart MCP 서버 설치 필수

> **이 skill을 사용하려면 Dart MCP 서버가 설치되어 있어야 합니다.**

### 설치 요구사항
- **Dart 3.9 이상** 필요

### 설치 방법

Claude Code에서 다음 명령어를 실행하세요:

```bash
claude mcp add --transport stdio dart -- dart mcp-server
```

### 설치 확인

설치 후 Claude Code를 재시작하면 다음 MCP 도구들을 사용할 수 있습니다:
- `analyze_files`, `dart_fix`, `dart_format`
- `pub`, `pub_dev_search`
- `run_tests`, `launch_app`, `list_devices`
- `hot_reload`, `hot_restart`, `get_widget_tree`

### 참고 문서
- [Dart and Flutter MCP server 공식 문서](https://docs.flutter.dev/ai/mcp-server)

---

## 🚨 CRITICAL: Dart MCP 도구 사용 필수

> **이 규칙은 절대적입니다. 명령줄 대신 반드시 Dart MCP 도구를 사용하세요.**

| MCP 도구 | 대신 사용 금지 |
|----------|----------------|
| `analyze_files` | `flutter analyze`, `dart analyze` |
| `create_project` | `flutter create`, `dart create` |
| `dart_fix` | `flutter fix`, `dart fix` |
| `dart_format` | `dart format` |
| `pub` | `flutter pub`, `dart pub` |
| `launch_app` | `flutter run` |
| `list_devices` | `flutter devices` |
| `pub_dev_search` | 웹에서 패키지 검색 |
| `run_tests` | `flutter test`, `dart test` |
| `hot_reload` | 핫 리로드 |
| `hot_restart` | 핫 리스타트 |
| `get_widget_tree` | 위젯 트리 검사 |

### 필수 워크플로우

```
1. 코드 수정 후 → analyze_files (테스트 전에 반드시!)
2. 커밋 전 → dart_fix → dart_format
3. 의존성 추가 → pub (pubspec.yaml 직접 수정 금지!)
```

---

## 🎯 핵심 원칙

### 코드 철학
- **SOLID 원칙**: 코드베이스 전반에 적용
- **간결하고 선언적**: 함수형 및 선언적 패턴 선호
- **상속보다 콤포지션**: 복잡한 위젯과 로직 구축 시
- **불변성 우선**: 특히 StatelessWidget, 불변 데이터 구조 사용
- **상태 관리**: 임시 상태와 앱 상태를 분리, 관심사 분리 구현
- **완전한 null 안전성**: bang(!) 연산자 최소화
- **명확함 > 영리함**: 영리한 코드보다 직관적인 코드 선호

### 사용자 페르소나
- 프로그래밍 개념에는 익숙하지만 Dart는 처음일 수 있음
- Dart 특화 기능(null 안전성, Future, Stream)에 대한 설명 제공
- 모호한 요청 시 명확화 요청

---

## 🏗️ 프로젝트 구조

### 기본 구조 (소규모 프로젝트)
```
lib/
├── main.dart                 # 애플리케이션 진입점
├── core/                     # 공유 유틸리티, 확장
│   ├── constants/
│   ├── utils/
│   ├── extensions/
│   └── errors/
├── data/                     # 데이터 계층
│   ├── models/
│   ├── repositories/
│   └── services/
├── domain/                   # 비즈니스 로직
│   └── use_cases/
└── presentation/             # UI 계층
    ├── screens/
    ├── widgets/
    └── themes/
```

### Feature-First 구조 (중대규모 프로젝트)
```
lib/
├── main.dart
├── core/                     # 공유 코드
│   ├── constants/
│   ├── theme/
│   ├── router/
│   └── utils/
├── features/                 # 기능별 모듈
│   ├── auth/
│   │   ├── data/            # 모델, 레포지토리
│   │   ├── domain/          # 비즈니스 로직 (선택)
│   │   └── presentation/    # 프로바이더, 스크린, 위젯
│   ├── home/
│   └── settings/
└── shared/                   # 공유 위젯, 모델
    ├── widgets/
    └── models/
```

---

## ⚡ 상태 관리 우선순위 (2025년)

| 우선순위 | 솔루션 | 사용 케이스 |
|---------|--------|------------|
| 1 ⭐ | **Riverpod 3.0** | 중소~대규모 앱 표준 |
| 2 | **Bloc** | 엔터프라이즈/대규모 앱 |
| 3 | **Provider** | 초보자, 소규모 앱 |
| 4 | **ValueNotifier + ValueListenableBuilder** | 간단한 로컬 상태 |
| 5 | **ChangeNotifier + ListenableBuilder** | 복잡한 로컬 상태 |
| 6 | **Stream + StreamBuilder** | 비동기 이벤트 시퀀스 |
| 7 | **Future + FutureBuilder** | 단일 비동기 작업 |

---

## 🧭 네비게이션

### go_router (권장)
```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) => DetailsScreen(
        id: state.pathParameters['id']!,
      ),
    ),
  ],
  redirect: (context, state) {
    // 인증 리다이렉트 로직
    final isLoggedIn = /* 인증 상태 확인 */;
    if (!isLoggedIn && state.uri.path != '/login') {
      return '/login';
    }
    return null;
  },
);
```

### 네비게이션 원칙
- **go_router**: 선언적 네비게이션, 딥링크, 웹 지원
- **Navigator**: 다이얼로그, 바텀시트 등 임시 화면에만 사용
- 인증 리다이렉트는 go_router의 redirect에서 처리

---

## 🧪 테스트 전략

### 테스트 유형
| 유형 | 패키지 | 용도 |
|------|--------|------|
| Unit | `package:test` | 비즈니스 로직, 유틸리티 |
| Widget | `package:flutter_test` | UI 컴포넌트 |
| Integration | `package:integration_test` | E2E 플로우 |

### 테스트 원칙
```dart
test('설명적인 테스트 이름', () {
  // Arrange (준비)
  final repository = FakeUserRepository();
  final useCase = GetUserUseCase(repository);

  // Act (실행)
  final result = await useCase.execute('user-123');

  // Assert (검증)
  expect(result.name, equals('John Doe'));
});
```

### 테스트 모범 사례
- **Fakes > Mocks**: 가능하면 mock보다 fake 사용
- **analyze_files 먼저**: 테스트 전 정적 분석 실행
- **독립적 테스트**: 각 테스트는 독립적으로 실행 가능해야 함
- **의미있는 이름**: 테스트가 무엇을 검증하는지 명확히

---

## 📋 코드 품질 체크리스트

### 명명 규칙
| 대상 | 규칙 | 예시 |
|------|------|------|
| 클래스 | `PascalCase` | `UserRepository` |
| 변수/함수 | `camelCase` | `getUserById` |
| 파일 | `snake_case` | `user_repository.dart` |
| 상수 | `lowerCamelCase` | `maxRetryCount` |

### 코드 스타일
- **80자** 줄 길이 제한
- **20줄 미만** 함수 목표
- **단일 책임** 원칙
- 화살표 함수 활용 (한 줄 함수)
- 의미있는 이름 (약어 금지)

### 필수 사항
- `const` 생성자 적극 활용
- `print` 대신 `logging` 패키지 사용
- ListView에는 `.builder` 사용
- 깊은 위젯 중첩 피하기 (콤포지션으로 분해)

---

## 🎨 UI/UX - Material 3

### 테마 설정
```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  ),
  themeMode: ThemeMode.system,
);
```

### 레이아웃 패턴
| 위젯 | 용도 |
|------|------|
| `Expanded` | 남은 공간 채우기 |
| `Flexible` | 축소 가능한 공간 |
| `ListView.builder` | 긴 리스트 |
| `LayoutBuilder` | 반응형 레이아웃 |
| `const` 위젯 | 성능 최적화 |

---

## 🔧 의존성 관리

### pub 도구 사용 (pubspec.yaml 직접 수정 금지!)
```bash
# 의존성 추가
pub add http
pub add dev:mocktail          # dev 의존성은 dev: 접두사

# 의존성 제거
pub remove http

# 업데이트
pub upgrade
pub outdated
```

### 코드 생성
```bash
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs  # 감시 모드
```

---

## ⚠️ 피해야 할 것

| 금지 | 대안 |
|------|------|
| `build()`에서 비용이 큰 작업 | `initState()` 또는 Provider에서 처리 |
| bang(!) 연산자 남용 | null-safe 패턴 사용 |
| 깊은 위젯 중첩 | 콤포지션으로 분해 |
| `print()` | `logging` 패키지 또는 `developer.log` |
| 일반 `ListView` (긴 리스트) | `ListView.builder` |
| `StatefulWidget` 남용 | `StatelessWidget` + 상태관리 |
| pubspec.yaml 직접 수정 | `pub` 도구 사용 |
| 명령줄 flutter/dart 명령 | MCP 도구 사용 |

---

## 📖 Git 커밋 시 주의사항

```bash
# 커밋 메시지에서 백틱과 달러 기호 이스케이프
git commit -m "Fix \`widget\` rendering \$issue"
```

- 커밋 전 `dart_fix` → `dart_format` 실행
- 테스트 통과 확인 (`run_tests`)

---

## 📚 상세 문서

각 주제별 상세 가이드:
- `architecture.md`: 프로젝트 구조, 상태 관리 (Riverpod 3.0), 데이터 흐름, 라우팅
- `ui-design.md`: Material 3 테마, 레이아웃, 색상, 타이포그래피, 접근성
- `best-practices.md`: 코드 품질, Dart/Flutter 모범사례, 패키지 관리
- `testing.md`: 단위/위젯/통합 테스트 전략

---

## 📖 추가 학습 자료

- [Effective Dart](https://dart.dev/effective-dart)
- [Flutter 공식 문서](https://docs.flutter.dev)
- [Material 3 가이드](https://m3.material.io)
- [go_router](https://pub.dev/packages/go_router)

---

**사용 방법**: 이 skill은 Flutter 프로젝트에서 자동으로 활성화됩니다.
