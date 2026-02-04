# Flutter 코드 품질 및 모범 사례

## 📏 코드 품질 기준

### 코드 구조
- 유지보수 가능한 코드 구조
- 관심사의 분리 (UI 로직 ↔ 비즈니스 로직)
- 단일 책임 원칙

### 명명 규칙

```dart
// ✅ 좋은 예
class UserRepository {}                 // PascalCase for classes
const maxRetryCount = 3;                // lowerCamelCase for constants
void fetchUserData() {}                 // camelCase for functions
final userName = 'John';                // camelCase for variables
enum UserStatus { active, inactive }   // camelCase for enums

// ❌ 나쁜 예
class user_repository {}                // snake_case 사용 안 함
const MAX_RETRY_COUNT = 3;              // UPPER_CASE 피하기
void FetchUserData() {}                 // PascalCase 사용 안 함
final user_name = 'John';               // snake_case 사용 안 함

// 파일명: snake_case
// user_repository.dart
// login_screen.dart
// app_constants.dart
```

### 함수 작성 원칙

```dart
// ✅ 좋은 예: 짧고 단일 목적
Future<User> fetchUser(String id) async {
  final response = await _apiClient.get('/users/$id');
  return User.fromJson(response);
}

int calculateTotal(List<int> numbers) =>
    numbers.fold(0, (sum, number) => sum + number);

// ❌ 나쁜 예: 너무 길고 여러 책임
Future<void> processUserDataAndSendEmail(String id) async {
  // 데이터 가져오기
  final response = await _apiClient.get('/users/$id');
  final user = User.fromJson(response);
  
  // 데이터 처리
  final processedData = _processData(user);
  
  // 데이터베이스 저장
  await _database.save(processedData);
  
  // 이메일 발송
  await _emailService.send(user.email, 'Welcome');
  
  // 로그 기록
  _logger.info('User processed: ${user.id}');
}
```

### 오류 처리

```dart
// ✅ 좋은 예: 구체적인 오류 처리
Future<User> fetchUser(String id) async {
  try {
    final response = await _apiClient.get('/users/$id');
    return User.fromJson(response);
  } on NetworkException catch (e) {
    throw UserFetchException('Network error: ${e.message}');
  } on JsonException catch (e) {
    throw UserFetchException('Invalid data format: ${e.message}');
  } catch (e) {
    throw UserFetchException('Unknown error: $e');
  }
}

// 커스텀 예외
class UserFetchException implements Exception {
  final String message;
  UserFetchException(this.message);
  
  @override
  String toString() => 'UserFetchException: $message';
}

// ❌ 나쁜 예: 조용히 실패
Future<User?> fetchUser(String id) async {
  try {
    final response = await _apiClient.get('/users/$id');
    return User.fromJson(response);
  } catch (e) {
    return null;  // 오류 정보 손실
  }
}
```

### 로깅

```dart
import 'dart:developer' as developer;

// ✅ 좋은 예: 구조화된 로깅
void processOrder(Order order) {
  developer.log(
    'Processing order',
    name: 'app.orders',
    time: DateTime.now(),
  );
  
  try {
    // 주문 처리
  } catch (e, s) {
    developer.log(
      'Order processing failed',
      name: 'app.orders',
      level: 1000, // SEVERE
      error: e,
      stackTrace: s,
    );
  }
}

// ❌ 나쁜 예: print 사용
void processOrder(Order order) {
  print('Processing order: ${order.id}');  // 피하기
}
```

## 🎯 Dart 모범 사례

### Null 안전성

```dart
// ✅ 좋은 예: null 안전성 활용
String getUserName(User? user) {
  return user?.name ?? 'Guest';
}

void processUser(User? user) {
  if (user != null) {
    print(user.name);  // 안전하게 접근
  }
}

// late 사용 (초기화 보장 시)
class UserService {
  late final UserRepository repository;
  
  void initialize(UserRepository repo) {
    repository = repo;
  }
}

// ❌ 나쁜 예: bang(!) 연산자 남용
String getUserName(User? user) {
  return user!.name;  // null이면 런타임 에러
}
```

### Async/Await

```dart
// ✅ 좋은 예: 적절한 async/await
Future<List<User>> fetchUsers() async {
  try {
    final response = await _apiClient.get('/users');
    return (response as List)
        .map((json) => User.fromJson(json))
        .toList();
  } catch (e) {
    rethrow;
  }
}

// 병렬 처리
Future<void> loadData() async {
  final results = await Future.wait([
    fetchUsers(),
    fetchPosts(),
    fetchComments(),
  ]);
  
  final users = results[0] as List<User>;
  final posts = results[1] as List<Post>;
  final comments = results[2] as List<Comment>;
}

// ❌ 나쁜 예: await 없이 Future 반환
Future<User> getUser(String id) {
  return _repository.fetchUser(id);  // async 불필요
}
```

### 패턴 매칭

```dart
// ✅ 좋은 예: 패턴 매칭 활용
String getStatusMessage(UserStatus status) {
  return switch (status) {
    UserStatus.active => 'User is active',
    UserStatus.inactive => 'User is inactive',
    UserStatus.banned => 'User is banned',
  };
}

// if-case 패턴
void processResponse(Object response) {
  if (response case {'status': 'success', 'data': var data}) {
    print('Success: $data');
  } else if (response case {'status': 'error', 'message': var msg}) {
    print('Error: $msg');
  }
}
```

### 레코드 사용

```dart
// ✅ 좋은 예: 레코드로 여러 값 반환
(int, String) getUserInfo(User user) {
  return (user.age, user.name);
}

// 사용
final (age, name) = getUserInfo(user);
print('$name is $age years old');

// Named records
({int count, List<User> users}) getPaginatedUsers(int page) {
  return (
    count: totalCount,
    users: userList,
  );
}

final result = getPaginatedUsers(1);
print('Found ${result.count} users');
```

### 화살표 함수

```dart
// ✅ 좋은 예: 간단한 한 줄 함수
int double(int x) => x * 2;

String greet(String name) => 'Hello, $name!';

List<int> getEvenNumbers(List<int> numbers) =>
    numbers.where((n) => n.isEven).toList();

// 여러 줄은 일반 함수 구문 사용
User createUser(String name, String email) {
  final user = User(name: name, email: email);
  _logUserCreation(user);
  return user;
}
```

## 🔧 Flutter 모범 사례

### 위젯 조합

```dart
// ✅ 좋은 예: 작은 위젯으로 분해
class UserCard extends StatelessWidget {
  final User user;
  
  const UserCard({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _UserAvatar(user: user),
          _UserName(user: user),
          _UserEmail(user: user),
        ],
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  final User user;
  
  const _UserAvatar({required this.user});
  
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(user.avatarUrl),
    );
  }
}

// ❌ 나쁜 예: 큰 build 메서드
class UserCard extends StatelessWidget {
  final User user;
  
  const UserCard({super.key, required this.user});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          Text(
            user.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          ),
          // ... 더 많은 위젯
        ],
      ),
    );
  }
}
```

### Const 생성자 활용

```dart
// ✅ 좋은 예: const 사용으로 성능 최적화
class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Title'),
        SizedBox(height: 16),
        Icon(Icons.star),
      ],
    );
  }
}

// 동적 데이터와 const 혼합
Widget build(BuildContext context) {
  return Column(
    children: [
      const Text('Static Title'),
      Text(dynamicValue),  // 동적 값
      const SizedBox(height: 16),
    ],
  );
}
```

### Build 메서드 성능

```dart
// ✅ 좋은 예: build 외부에서 처리
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late final Future<List<User>> _usersFuture;
  
  @override
  void initState() {
    super.initState();
    _usersFuture = fetchUsers();  // 여기서 한 번만 호출
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _usersFuture,
      builder: (context, snapshot) {
        // UI 구성
      },
    );
  }
}

// ❌ 나쁜 예: build 안에서 비동기 작업
Widget build(BuildContext context) {
  return FutureBuilder<List<User>>(
    future: fetchUsers(),  // 매번 새로 호출됨!
    builder: (context, snapshot) {
      // UI 구성
    },
  );
}
```

### Isolate 활용

```dart
import 'dart:convert';
import 'package:flutter/foundation.dart';

// ✅ 좋은 예: 무거운 작업을 isolate로
Future<List<User>> parseUsers(String jsonString) async {
  return compute(_parseUsersInIsolate, jsonString);
}

List<User> _parseUsersInIsolate(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => User.fromJson(json)).toList();
}

// ❌ 나쁜 예: UI 스레드에서 무거운 작업
Future<List<User>> parseUsers(String jsonString) async {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => User.fromJson(json)).toList();
}
```

## 📦 패키지 관리

### 의존성 추가

> **중요**: 명령줄 대신 Dart MCP `pub` 도구를 사용하세요! pubspec.yaml 직접 수정 금지!

```bash
# MCP pub 도구 사용 (권장)
pub add http                     # 일반 의존성
pub add dev:build_runner         # 개발 의존성 (dev: 접두사)
pub add override:pkg:1.0.0       # 의존성 재정의
pub remove package_name          # 의존성 제거
pub get                          # 의존성 설치
pub upgrade                      # 의존성 업데이트
pub outdated                     # 오래된 의존성 확인
```

### pubspec.yaml 구성

```yaml
name: my_app
description: A Flutter application
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # 상태 관리
  # provider: ^6.0.0  # 필요시에만
  
  # 네트워킹
  http: ^1.1.0
  
  # 로컬 저장소
  shared_preferences: ^2.2.0
  
  # 라우팅
  go_router: ^12.0.0
  
  # UI
  google_fonts: ^6.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  build_runner: ^2.4.0
  json_serializable: ^6.7.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
  fonts:
    - family: CustomFont
      fonts:
        - asset: assets/fonts/CustomFont-Regular.ttf
```

## 🔍 Lint 규칙

### analysis_options.yaml

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true

linter:
  rules:
    # 스타일
    prefer_single_quotes: true
    require_trailing_commas: true
    
    # 오류 방지
    avoid_print: true
    avoid_returning_null_for_void: true
    cancel_subscriptions: true
    close_sinks: true
    
    # 성능
    prefer_const_constructors: true
    prefer_const_literals_to_create_immutables: true
    
    # 가독성
    always_put_required_named_parameters_first: true
    directives_ordering: true
    
    # 문서화
    public_member_api_docs: false  # 필요시 true
```

## 📊 데이터 직렬화

### JSON Serializable

```dart
// 1. 의존성 추가 (MCP pub 도구 사용)
// pub add json_annotation
// pub add dev:build_runner
// pub add dev:json_serializable

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

// 2. 모델 정의
@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final String id;
  final String firstName;  // JSON: first_name
  final String lastName;   // JSON: last_name
  final String email;
  
  @JsonKey(name: 'profile_image')
  final String? profileImageUrl;
  
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? tempData;  // 직렬화 제외
  
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profileImageUrl,
    this.tempData,
  });
  
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// 3. 코드 생성
// dart run build_runner build --delete-conflicting-outputs
```

## 🎯 모범 사례 체크리스트

✅ 의미 있는 이름 사용 (약어 피하기)  
✅ 함수는 20줄 미만, 단일 책임  
✅ null 안전성 완전 활용  
✅ 적절한 오류 처리  
✅ logging 패키지로 로깅  
✅ const 생성자 적극 사용  
✅ ListView.builder 사용  
✅ build 메서드에서 비용 큰 작업 피하기  
✅ 위젯 조합으로 분해  
✅ 80자 줄 길이 준수  
