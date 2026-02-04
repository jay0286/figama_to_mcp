# Flutter 테스팅 가이드

## 🧪 테스팅 개요

### 테스트 유형
1. **단위 테스트**: 개별 함수, 메서드, 클래스 테스트
2. **위젯 테스트**: UI 컴포넌트 테스트
3. **통합 테스트**: 전체 앱 또는 큰 부분의 엔드투엔드 테스트

### 테스트 실행

> **중요**: 명령줄 대신 Dart MCP 도구를 사용하세요!

```bash
# MCP 도구 사용 (권장)
run_tests                                    # 모든 테스트
run_tests test/models/user_test.dart         # 특정 파일

# 명령줄 (MCP 사용 불가 시에만)
flutter test
flutter test --coverage
```

## 📝 단위 테스트

### 기본 구조 (Arrange-Act-Assert)

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator', () {
    test('adds two numbers correctly', () {
      // Arrange (준비)
      final calculator = Calculator();
      
      // Act (실행)
      final result = calculator.add(2, 3);
      
      // Assert (검증)
      expect(result, 5);
    });
    
    test('subtracts two numbers correctly', () {
      final calculator = Calculator();
      final result = calculator.subtract(5, 3);
      expect(result, 2);
    });
  });
}
```

### 비동기 테스트

```dart
test('fetches user data', () async {
  // Arrange
  final repository = UserRepository();
  
  // Act
  final user = await repository.getUser('123');
  
  // Assert
  expect(user.id, '123');
  expect(user.name, isNotEmpty);
});

test('handles fetch error', () async {
  final repository = UserRepository();
  
  // expectLater로 비동기 오류 검증
  expect(
    () => repository.getUser('invalid'),
    throwsA(isA<UserNotFoundException>()),
  );
});
```

### setUp과 tearDown

```dart
void main() {
  late UserRepository repository;
  late ApiClient apiClient;
  
  setUp(() {
    // 각 테스트 전에 실행
    apiClient = FakeApiClient();
    repository = UserRepository(apiClient);
  });
  
  tearDown(() {
    // 각 테스트 후에 실행
    apiClient.dispose();
  });
  
  test('fetches user', () async {
    final user = await repository.getUser('123');
    expect(user.id, '123');
  });
}
```

### package:checks 사용 (권장)

```dart
// pub add dev:checks (MCP pub 도구 사용)

import 'package:checks/checks.dart';
import 'package:flutter_test/flutter_test.dart';

test('user has correct properties', () {
  final user = User(
    id: '123',
    name: 'John Doe',
    email: 'john@example.com',
  );
  
  // checks로 더 표현력 있는 assertions
  check(user).has((u) => u.id, 'id').equals('123');
  check(user).has((u) => u.name, 'name').equals('John Doe');
  check(user).has((u) => u.email, 'email').contains('@');
  
  // 리스트 검증
  final users = [user1, user2, user3];
  check(users).length.equals(3);
  check(users).any((u) => u.name.equals('John'));
});
```

## 🎨 위젯 테스트

### 기본 위젯 테스트

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments', (WidgetTester tester) async {
    // Arrange: 위젯 빌드
    await tester.pumpWidget(
      const MaterialApp(
        home: CounterWidget(),
      ),
    );
    
    // Assert: 초기 상태 확인
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    
    // Act: 버튼 탭
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();  // 위젯 재빌드
    
    // Assert: 업데이트된 상태 확인
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
```

### Finder 사용

```dart
testWidgets('finds widgets by type and key', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text('Title', key: Key('title')),
            ElevatedButton(
              onPressed: () {},
              child: Text('Click me'),
            ),
          ],
        ),
      ),
    ),
  );
  
  // 텍스트로 찾기
  expect(find.text('Title'), findsOneWidget);
  
  // 타입으로 찾기
  expect(find.byType(ElevatedButton), findsOneWidget);
  
  // Key로 찾기
  expect(find.byKey(Key('title')), findsOneWidget);
  
  // 아이콘으로 찾기
  expect(find.byIcon(Icons.add), findsNothing);
  
  // 위젯으로 찾기
  expect(find.byWidget(Text('Title')), findsOneWidget);
});
```

### 스크롤 테스트

```dart
testWidgets('scrolls through list', (tester) async {
  final items = List.generate(100, (i) => 'Item $i');
  
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(items[index]));
          },
        ),
      ),
    ),
  );
  
  // 초기 상태
  expect(find.text('Item 0'), findsOneWidget);
  expect(find.text('Item 50'), findsNothing);
  
  // 스크롤
  await tester.scrollUntilVisible(
    find.text('Item 50'),
    500.0,
  );
  
  // 스크롤 후
  expect(find.text('Item 50'), findsOneWidget);
});
```

### 상태 관리 테스트

```dart
testWidgets('ChangeNotifier updates UI', (tester) async {
  final model = CounterModel();
  
  await tester.pumpWidget(
    MaterialApp(
      home: ListenableBuilder(
        listenable: model,
        builder: (context, child) {
          return Text('${model.count}');
        },
      ),
    ),
  );
  
  expect(find.text('0'), findsOneWidget);
  
  // 상태 변경
  model.increment();
  await tester.pump();
  
  expect(find.text('1'), findsOneWidget);
});
```

### 폼 입력 테스트

```dart
testWidgets('submits form with valid data', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: LoginForm(),
    ),
  );
  
  // 텍스트 입력
  await tester.enterText(
    find.byKey(Key('email')),
    'test@example.com',
  );
  await tester.enterText(
    find.byKey(Key('password')),
    'password123',
  );
  
  // 버튼 탭
  await tester.tap(find.byType(ElevatedButton));
  await tester.pumpAndSettle();  // 모든 애니메이션 완료까지 대기
  
  // 결과 확인
  expect(find.text('Login Successful'), findsOneWidget);
});
```

## 🔗 통합 테스트

### integration_test 설정

```yaml
# pubspec.yaml
dev_dependencies:
  integration_test:
    sdk: flutter
  flutter_test:
    sdk: flutter
```

### 통합 테스트 작성

```dart
// integration_test/app_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('end-to-end test', () {
    testWidgets('complete user flow', (tester) async {
      // 앱 시작
      app.main();
      await tester.pumpAndSettle();
      
      // 로그인 화면
      expect(find.text('Login'), findsOneWidget);
      await tester.enterText(find.byKey(Key('email')), 'user@test.com');
      await tester.enterText(find.byKey(Key('password')), 'password');
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();
      
      // 홈 화면
      expect(find.text('Welcome'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      
      // 새 항목 추가
      await tester.enterText(find.byKey(Key('title')), 'New Item');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      
      // 결과 확인
      expect(find.text('New Item'), findsOneWidget);
    });
  });
}
```

### 통합 테스트 실행

> **중요**: MCP `run_tests` 도구를 사용하세요!

```bash
# MCP 도구 사용 (권장)
run_tests integration_test/app_test.dart

# 명령줄 (특정 디바이스 지정 시)
flutter test integration_test/app_test.dart -d chrome
flutter test integration_test/app_test.dart -d macos
```

## 🎭 Mock과 Fake

### Fake 구현 (권장)

```dart
// 실제 구현
abstract class UserRepository {
  Future<User> getUser(String id);
  Future<void> saveUser(User user);
}

// Fake 구현 (테스트용)
class FakeUserRepository implements UserRepository {
  final Map<String, User> _users = {};
  
  @override
  Future<User> getUser(String id) async {
    final user = _users[id];
    if (user == null) {
      throw UserNotFoundException();
    }
    return user;
  }
  
  @override
  Future<void> saveUser(User user) async {
    _users[user.id] = user;
  }
  
  // 테스트 헬퍼
  void addUser(User user) {
    _users[user.id] = user;
  }
}

// 테스트에서 사용
test('loads user from repository', () async {
  final repository = FakeUserRepository();
  repository.addUser(User(id: '123', name: 'Test'));
  
  final viewModel = UserViewModel(repository);
  await viewModel.loadUser('123');
  
  expect(viewModel.user?.name, 'Test');
});
```

### Mockito 사용 (필요시)

```dart
// pub add dev:mockito (MCP pub 도구 사용)
// pub add dev:build_runner

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

// 1. Mock 생성을 위한 어노테이션
@GenerateMocks([UserRepository])
void main() {}

// 2. 코드 생성
// dart run build_runner build

// 3. 테스트에서 사용
import 'user_test.mocks.dart';

test('handles repository error', () async {
  final repository = MockUserRepository();
  
  // Mock 동작 정의
  when(repository.getUser('123'))
      .thenThrow(NetworkException());
  
  final viewModel = UserViewModel(repository);
  await viewModel.loadUser('123');
  
  // 검증
  expect(viewModel.error, isNotNull);
  verify(repository.getUser('123')).called(1);
});
```

## 📊 테스트 커버리지

### 커버리지 생성

```bash
# MCP run_tests 도구로 테스트 실행 후 커버리지 생성
run_tests  # 테스트 먼저 실행

# 커버리지 데이터 생성 (명령줄)
flutter test --coverage

# HTML 리포트 생성 (genhtml 필요)
genhtml coverage/lcov.info -o coverage/html

# 브라우저에서 보기
open coverage/html/index.html
```

### coverage 패키지 사용

```yaml
# pubspec.yaml
dev_dependencies:
  test_coverage: ^2.0.0
```

## 🎯 테스팅 모범 사례

### 1. Given-When-Then 패턴

```dart
test('user login with valid credentials', () async {
  // Given (준비)
  final authService = FakeAuthService();
  final viewModel = LoginViewModel(authService);
  authService.addUser(User(email: 'test@test.com', password: 'pass'));
  
  // When (실행)
  await viewModel.login('test@test.com', 'pass');
  
  // Then (검증)
  expect(viewModel.isLoggedIn, true);
  expect(viewModel.error, isNull);
});
```

### 2. 테스트 격리

```dart
// ❌ 나쁜 예: 전역 상태 공유
var globalCounter = 0;

test('increments counter', () {
  globalCounter++;
  expect(globalCounter, 1);
});

test('increments counter again', () {
  globalCounter++;
  expect(globalCounter, 1);  // 실패! globalCounter는 2
});

// ✅ 좋은 예: 각 테스트 격리
test('increments counter', () {
  var counter = 0;
  counter++;
  expect(counter, 1);
});

test('increments counter again', () {
  var counter = 0;
  counter++;
  expect(counter, 1);  // 성공!
});
```

### 3. 의미 있는 테스트 이름

```dart
// ❌ 나쁜 예
test('test1', () {});
test('user test', () {});

// ✅ 좋은 예
test('returns user when valid id is provided', () {});
test('throws exception when user is not found', () {});
test('updates UI when user data changes', () {});
```

### 4. 하나의 개념만 테스트

```dart
// ❌ 나쁜 예: 여러 개념 테스트
test('user operations', () {
  final user = createUser();
  expect(user.name, 'John');
  
  updateUser(user, name: 'Jane');
  expect(user.name, 'Jane');
  
  deleteUser(user);
  expect(findUser(user.id), isNull);
});

// ✅ 좋은 예: 각 개념을 별도 테스트
test('creates user with correct name', () {
  final user = createUser();
  expect(user.name, 'John');
});

test('updates user name', () {
  final user = createUser();
  updateUser(user, name: 'Jane');
  expect(user.name, 'Jane');
});

test('deletes user', () {
  final user = createUser();
  deleteUser(user);
  expect(findUser(user.id), isNull);
});
```

## ✅ 테스팅 체크리스트

✅ 단위 테스트로 비즈니스 로직 커버  
✅ 위젯 테스트로 UI 컴포넌트 검증  
✅ 통합 테스트로 주요 사용자 흐름 확인  
✅ Mock보다 Fake 선호  
✅ Given-When-Then 패턴 사용  
✅ 각 테스트 격리  
✅ 의미 있는 테스트 이름  
✅ 하나의 개념만 테스트  
✅ 높은 테스트 커버리지 목표 (80%+)  
✅ setUp/tearDown으로 중복 제거  
