# Flutter 아키텍처 및 상태 관리

## 🏛️ 애플리케이션 아키텍처

### 관심사의 분리
MVC/MVVM과 유사한 관심사의 분리를 목표로 하며, 정의된 Model, View, ViewModel/Controller 역할을 갖습니다.

### 논리적 계층 구조

```
lib/
├── main.dart
├── core/                    # 공유 클래스, 유틸리티, 확장
│   ├── constants/
│   ├── utils/
│   ├── extensions/
│   └── errors/
├── data/                    # 데이터 계층
│   ├── models/             # 데이터 모델 클래스
│   ├── repositories/       # 데이터 소스 추상화
│   └── services/           # API 클라이언트, 외부 서비스
├── domain/                  # 비즈니스 로직
│   ├── entities/           # 비즈니스 엔티티
│   └── use_cases/          # 비즈니스 로직 클래스
└── presentation/            # 프레젠테이션 계층
    ├── screens/            # 화면 위젯
    ├── widgets/            # 재사용 가능한 위젯
    ├── themes/             # 테마 정의
    └── view_models/        # MVVM 사용 시
```

### 기능 기반 조직 (대규모 프로젝트)

```
lib/
├── features/
│   ├── authentication/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── profile/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── settings/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── core/
```

이는 탐색성과 확장성을 향상시킵니다.

## 🔄 상태 관리

### 2025년 권장 상태 관리 솔루션

상태 관리 선택은 앱의 복잡도와 요구사항에 따라 달라집니다. 2025년 기준 권장 순서:

**1. Riverpod 3.0** - 중소~대규모 앱의 표준 (적극 권장) ⭐  
**2. Bloc** - 엔터프라이즈/대규모 앱, 엄격한 아키텍처 필요 시  
**3. Provider** - 초보자, 소규모 앱 (Flutter 공식 추천)  
**4. Flutter 내장 솔루션** - 매우 간단한 로컬 상태, 학습 목적  

### 1. Riverpod 3.0 (적극 권장) ⭐

**왜 Riverpod인가?**
- ✅ 컴파일 타임 안전성 - 런타임 오류 대신 컴파일 시점에 오류 발견
- ✅ BuildContext 불필요 - 어디서나 접근 가능
- ✅ 자동 리소스 정리 - 메모리 누수 방지
- ✅ 뛰어난 테스트 가능성 - Mock과 Override 쉬움
- ✅ DevTools 통합 - 디버깅 용이
- ✅ Hot Reload 친화적

**의존성 추가:** (MCP `pub` 도구 사용)
```bash
pub add flutter_riverpod
pub add riverpod_annotation
pub add dev:riverpod_generator
pub add dev:build_runner
pub add dev:riverpod_lint  # 선택사항
```

**기본 사용법:**

```dart
// 1. ProviderScope로 앱 감싸기
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// 2. Provider 정의 (간단한 상태)
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;
  
  void increment() => state++;
  void decrement() => state--;
}

// 3. 위젯에서 사용
class CounterWidget extends ConsumerWidget {
  const CounterWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    
    return Column(
      children: [
        Text('Count: $count'),
        ElevatedButton(
          onPressed: () => ref.read(counterProvider.notifier).increment(),
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

**비동기 데이터 처리:**

```dart
// API 호출이 있는 Provider
@riverpod
class UserList extends _$UserList {
  @override
  Future<List<User>> build() async {
    // 초기 데이터 로드
    return _fetchUsers();
  }
  
  Future<void> addUser(User user) async {
    // 낙관적 업데이트
    final previousState = state.valueOrNull ?? [];
    state = AsyncValue.data([...previousState, user]);
    
    try {
      await _apiClient.createUser(user);
    } catch (e, stack) {
      // 실패 시 롤백
      state = AsyncValue.data(previousState);
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<List<User>> _fetchUsers() async {
    final response = await _apiClient.getUsers();
    return response;
  }
}

// AsyncValue로 로딩/에러 상태 처리
class UserListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userListAsync = ref.watch(userListProvider);
    
    return userListAsync.when(
      data: (users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) => UserTile(users[index]),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

**Family Provider (매개변수가 있는 Provider):**

```dart
@riverpod
Future<User> user(UserRef ref, String userId) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUser(userId);
}

// 사용
class UserDetailWidget extends ConsumerWidget {
  final String userId;
  
  const UserDetailWidget({required this.userId});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider(userId));
    
    return userAsync.when(
      data: (user) => Text(user.name),
      loading: () => const CircularProgressIndicator(),
      error: (e, s) => Text('Error: $e'),
    );
  }
}
```

**코드 생성:**
```bash
# Provider 코드 생성
dart run build_runner build --delete-conflicting-outputs

# Watch 모드 (개발 중)
dart run build_runner watch --delete-conflicting-outputs
```

### 2. Bloc (엔터프라이즈급 앱)

**사용 시기**: 대규모 팀, 엄격한 아키텍처, 복잡한 비즈니스 로직

```bash
pub add flutter_bloc
```

```dart
// Event
abstract class CounterEvent {}
class Increment extends CounterEvent {}
class Decrement extends CounterEvent {}

// State
class CounterState {
  final int count;
  const CounterState(this.count);
}

// Bloc
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    on<Increment>((event, emit) => emit(CounterState(state.count + 1)));
    on<Decrement>((event, emit) => emit(CounterState(state.count - 1)));
  }
}

// Widget
class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Column(
            children: [
              Text('Count: ${state.count}'),
              ElevatedButton(
                onPressed: () => context.read<CounterBloc>().add(Increment()),
                child: const Text('Increment'),
              ),
            ],
          );
        },
      ),
    );
  }
}
```

### 3. Provider (초보자/소규모 앱)

**사용 시기**: Flutter를 처음 배우는 경우, 간단한 앱

```bash
pub add provider
```

```dart
// ChangeNotifier
class CounterModel extends ChangeNotifier {
  int _count = 0;
  
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners();
  }
}

// 앱에 제공
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: MyApp(),
    ),
  );
}

// 위젯에서 사용
class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CounterModel>(
      builder: (context, counter, child) {
        return Column(
          children: [
            Text('Count: ${counter.count}'),
            ElevatedButton(
              onPressed: counter.increment,
              child: const Text('Increment'),
            ),
          ],
        );
      },
    );
  }
}
```

### 4. Flutter 내장 솔루션 (간단한 로컬 상태)

**ValueNotifier (단일 값):**

```dart
final ValueNotifier<int> _counter = ValueNotifier<int>(0);

ValueListenableBuilder<int>(
  valueListenable: _counter,
  builder: (context, value, child) {
    return Text('Count: $value');
  },
);

// 값 업데이트
_counter.value++;
```

**ChangeNotifier (복잡한 상태):**

```dart
class UserModel extends ChangeNotifier {
  User? _user;
  
  User? get user => _user;
  
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

ListenableBuilder(
  listenable: userModel,
  builder: (context, child) {
    return Text('User: ${userModel.user?.name}');
  },
);
```

**Future + FutureBuilder:**

```dart
late final Future<User> _userFuture;

@override
void initState() {
  super.initState();
  _userFuture = fetchUser();  // 한 번만 호출
}

FutureBuilder<User>(
  future: _userFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    return Text('User: ${snapshot.data?.name}');
  },
);
```

**Stream + StreamBuilder:**

```dart
StreamBuilder<List<Message>>(
  stream: messageStream,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return MessageList(messages: snapshot.data!);
    }
    return const CircularProgressIndicator();
  },
);
```

### 의존성 주입

**Riverpod 방식 (권장):**

```dart
// Repository Provider
@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserRepository(apiClient);
}

// ViewModel이 자동으로 의존성 주입받음
@riverpod
class UserList extends _$UserList {
  @override
  Future<List<User>> build() async {
    final repository = ref.watch(userRepositoryProvider);
    return repository.getUsers();
  }
}
```

**수동 생성자 주입 (내장 솔루션):**

```dart
class UserRepository {
  final ApiClient _apiClient;
  
  UserRepository(this._apiClient);
  
  Future<User> getUser(String id) => _apiClient.fetchUser(id);
}

class UserViewModel extends ChangeNotifier {
  final UserRepository _repository;
  
  UserViewModel(this._repository);
}

// 사용
final apiClient = ApiClient();
final repository = UserRepository(apiClient);
final viewModel = UserViewModel(repository);
```

### 5. Flutter Signals (2024년 신규 - 실험적) 🆕

**2024년 말 도입된 네이티브 반응형 시스템**

**장점:**
- ✅ 패키지 불필요 - Flutter 네이티브
- ✅ 매우 경량 - 최소한의 오버헤드
- ✅ 초보자 친화적 - 간단한 API
- ✅ 자동 UI 업데이트

**단점:**
- ⚠️ 비동기 지원 제한적
- ⚠️ 복잡한 아키텍처에 부적합
- ⚠️ 아직 성숙 단계 - 작은 커뮤니티
- ⚠️ 베스트 프랙티스 부족

**사용 시기**: MVP, 간단한 프로토타입, 학습 목적

**의존성 추가:** (MCP `pub` 도구 사용)
```bash
pub add signals
```

**기본 사용법:**

```dart
import 'package:signals/signals_flutter.dart';

// Signal 생성 (반응형 변수)
final counter = signal(0);

// Computed Signal (파생 값)
final doubled = computed(() => counter.value * 2);

// Effect (부수 효과)
effect(() {
  print('Counter changed: ${counter.value}');
});

// Widget에서 사용
class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SignalBuilder - 자동 업데이트
        SignalBuilder(
          builder: (context) {
            return Text('Count: ${counter.value}');
          },
        ),
        SignalBuilder(
          builder: (context) {
            return Text('Doubled: ${doubled.value}');
          },
        ),
        ElevatedButton(
          onPressed: () => counter.value++,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

**리스트 관리:**

```dart
// ListSignal
final todos = listSignal<String>([]);

// 항목 추가
todos.add('Buy milk');
todos.addAll(['Buy eggs', 'Buy bread']);

// 항목 제거
todos.removeAt(0);

// Widget
SignalBuilder(
  builder: (context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(todos[index]));
      },
    );
  },
);
```

**맵 관리:**

```dart
final userSettings = mapSignal<String, dynamic>({
  'theme': 'dark',
  'notifications': true,
});

// 업데이트
userSettings['theme'] = 'light';

// Widget
SignalBuilder(
  builder: (context) {
    final theme = userSettings['theme'];
    return Text('Current theme: $theme');
  },
);
```

**비동기 처리 (제한적):**

```dart
// FutureSignal (간단한 비동기)
final userFuture = futureSignal<User>(
  () => fetchUser(),
);

SignalBuilder(
  builder: (context) {
    final future = userFuture.value;
    
    return future.when(
      data: (user) => Text(user.name),
      loading: () => CircularProgressIndicator(),
      error: (error, _) => Text('Error: $error'),
    );
  },
);
```

**주의사항:**
```dart
// ❌ 나쁜 예: build 메서드 외부에서 직접 읽기
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final count = counter.value;  // 반

## 📊 데이터 흐름

### 데이터 구조 정의

```dart
// 불변 데이터 클래스
class User {
  final String id;
  final String name;
  final String email;
  
  const User({
    required this.id,
    required this.name,
    required this.email,
  });
  
  // JSON 직렬화
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
```

### Repository 패턴으로 데이터 소스 추상화

```dart
// Abstract Repository
abstract class UserRepository {
  Future<User> getUser(String id);
  Future<List<User>> getUsers();
  Future<void> updateUser(User user);
}

// Implementation
class UserRepositoryImpl implements UserRepository {
  final ApiClient _apiClient;
  
  UserRepositoryImpl(this._apiClient);
  
  @override
  Future<User> getUser(String id) async {
    final json = await _apiClient.get('/users/$id');
    return User.fromJson(json);
  }
  
  @override
  Future<List<User>> getUsers() async {
    final jsonList = await _apiClient.get('/users');
    return (jsonList as List)
        .map((json) => User.fromJson(json))
        .toList();
  }
  
  @override
  Future<void> updateUser(User user) async {
    await _apiClient.put('/users/${user.id}', user.toJson());
  }
}
```

## 🧭 라우팅

### GoRouter (권장)

선언적 네비게이션, 딥 링킹, 웹 지원을 위해 `go_router` 패키지를 사용합니다.

```dart
// 1. 의존성 추가 (MCP pub 도구 사용)
// pub add go_router

// 2. 라우터 구성
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: 'details/:id',
          builder: (context, state) {
            final String id = state.pathParameters['id']!;
            return DetailScreen(id: id);
          },
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
  // 에러 핸들링
  errorBuilder: (context, state) => ErrorScreen(error: state.error),
  // 리디렉션 (인증 등)
  redirect: (context, state) {
    final isLoggedIn = /* 로그인 상태 체크 */;
    final isGoingToLogin = state.matchedLocation == '/login';
    
    if (!isLoggedIn && !isGoingToLogin) {
      return '/login';
    }
    if (isLoggedIn && isGoingToLogin) {
      return '/';
    }
    return null;
  },
);

// 3. MaterialApp에서 사용
MaterialApp.router(
  routerConfig: _router,
  title: 'My App',
);

// 4. 네비게이션
context.go('/details/123');           // 스택 교체
context.push('/profile');             // 스택에 추가
context.pop();                        // 뒤로 가기
```

### Navigator (간단한 네비게이션)

딥 링크가 필요 없는 수명이 짧은 화면(대화 상자, 임시 뷰)에 사용:

```dart
// 화면 푸시
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const DetailScreen(),
  ),
);

// 뒤로 가기
Navigator.pop(context);

// 결과와 함께 뒤로 가기
Navigator.pop(context, 'result');

// 결과 받기
final result = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SelectionScreen(),
  ),
);
```

## 🎯 모범 사례 요약

1. **계층 분리**: Presentation, Domain, Data 계층을 명확히 분리
2. **상태 관리**: 복잡도에 맞는 적절한 솔루션 선택
3. **의존성 주입**: 수동 생성자 주입으로 명시적 의존성 관리
4. **데이터 추상화**: Repository 패턴으로 데이터 소스 추상화
5. **라우팅**: go_router로 선언적 네비게이션 구현
6. **테스트 가능성**: 추상화와 의존성 주입으로 테스트 용이성 확보
