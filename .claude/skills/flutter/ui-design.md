# Flutter UI 디자인 및 테마

## 🎨 Material 3 테마 모범 사례

### ColorScheme.fromSeed() 활용

단일 시드 색상에서 조화로운 색상 팔레트를 생성합니다.

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
  themeMode: ThemeMode.system,  // system, light, dark
);
```

### 중앙 집중식 테마 정의

```dart
// themes/app_theme.dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    
    // 컴포넌트별 테마
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
    ),
  );
  
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    // ... 동일한 컴포넌트 테마
  );
}
```

### ThemeExtension으로 커스텀 디자인 토큰

표준 ThemeData에 없는 커스텀 스타일을 정의합니다.

```dart
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
  });

  final Color? success;
  final Color? warning;
  final Color? danger;
  final Color? info;

  @override
  ThemeExtension<AppColors> copyWith({
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
  }) {
    return AppColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      info: info ?? this.info,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) return this;
    return AppColors(
      success: Color.lerp(success, other.success, t),
      warning: Color.lerp(warning, other.warning, t),
      danger: Color.lerp(danger, other.danger, t),
      info: Color.lerp(info, other.info, t),
    );
  }
}

// ThemeData에 등록
theme: ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    AppColors(
      success: Color(0xFF4CAF50),
      warning: Color(0xFFFF9800),
      danger: Color(0xFFF44336),
      info: Color(0xFF2196F3),
    ),
  ],
),

// 사용
final appColors = Theme.of(context).extension<AppColors>()!;
Container(
  color: appColors.success,
  child: Text('Success'),
);
```

### WidgetStateProperty로 상태별 스타일링

```dart
ElevatedButton(
  style: ButtonStyle(
    backgroundColor: WidgetStateProperty.resolveWith<Color>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) {
          return Colors.green;
        }
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey;
        }
        return Colors.blue;
      },
    ),
    foregroundColor: WidgetStateProperty.all(Colors.white),
  ),
  onPressed: () {},
  child: const Text('Button'),
);
```

## 📐 레이아웃 모범 사례

### Row와 Column에서 오버플로우 방지

```dart
// ❌ 나쁜 예 - 오버플로우 발생 가능
Row(
  children: [
    Text('Very long text that might overflow'),
    Text('Another long text'),
  ],
);

// ✅ 좋은 예 - Expanded 사용
Row(
  children: [
    Expanded(
      child: Text('Very long text that might overflow'),
    ),
    Expanded(
      child: Text('Another long text'),
    ),
  ],
);

// ✅ Flexible 사용 (필요시에만 확장)
Row(
  children: [
    Flexible(
      child: Text('This shrinks if needed'),
    ),
    const Icon(Icons.star),
  ],
);

// ✅ Wrap 사용 (다음 줄로 이동)
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: [
    Chip(label: Text('Tag 1')),
    Chip(label: Text('Tag 2')),
    Chip(label: Text('Tag 3')),
  ],
);
```

### 스크롤 가능한 콘텐츠

```dart
// 단일 자식 스크롤
SingleChildScrollView(
  child: Column(
    children: [
      // 고정 크기 콘텐츠
    ],
  ),
);

// 긴 리스트 - 항상 .builder 사용
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text(items[index]),
    );
  },
);

// 그리드
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return Card(child: Text(items[index]));
  },
);
```

### 반응형 레이아웃

```dart
// LayoutBuilder로 사용 가능한 공간에 따라 결정
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      // 태블릿/데스크톱 레이아웃
      return Row(
        children: [
          Expanded(flex: 1, child: Sidebar()),
          Expanded(flex: 2, child: MainContent()),
        ],
      );
    } else {
      // 모바일 레이아웃
      return Column(
        children: [
          MainContent(),
        ],
      );
    }
  },
);

// MediaQuery로 화면 정보 얻기
final size = MediaQuery.of(context).size;
final isLandscape = size.width > size.height;
final isTablet = size.shortestSide >= 600;
```

### Stack으로 위젯 레이어링

```dart
Stack(
  children: [
    // 배경
    Container(color: Colors.blue),
    
    // 절대 위치
    Positioned(
      top: 16,
      right: 16,
      child: Icon(Icons.close),
    ),
    
    // 정렬
    Align(
      alignment: Alignment.center,
      child: Text('Centered'),
    ),
    
    // 하단에 고정
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BottomAppBar(),
    ),
  ],
);
```

## 🎨 색상 스키마 모범 사례

### WCAG 대비 비율
- **일반 텍스트**: 최소 4.5:1
- **큰 텍스트** (18pt 또는 14pt 볼드): 최소 3:1

### 60-30-10 규칙
- **60%**: Primary/Neutral 색상 (지배적)
- **30%**: Secondary 색상
- **10%**: Accent 색상

### 예시 팔레트

```dart
class AppPalette {
  // Primary
  static const primary = Color(0xFF0D47A1);        // 진한 파란색
  static const primaryLight = Color(0xFF5472D3);
  static const primaryDark = Color(0xFF002171);
  
  // Secondary
  static const secondary = Color(0xFF1976D2);      // 중간 파란색
  static const secondaryLight = Color(0xFF63A4FF);
  static const secondaryDark = Color(0xFF004BA0);
  
  // Accent
  static const accent = Color(0xFFFFC107);         // 앰버
  
  // Neutral
  static const textPrimary = Color(0xFF212121);    // 거의 검정
  static const textSecondary = Color(0xFF757575);  // 회색
  static const background = Color(0xFFFAFAFA);     // 거의 흰색
  static const surface = Color(0xFFFFFFFF);        // 흰색
  
  // Semantic
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFF9800);
  static const error = Color(0xFFF44336);
  static const info = Color(0xFF2196F3);
}
```

## 📝 타이포그래피 모범 사례

### 폰트 선택
- 1-2개의 폰트 패밀리로 제한
- 가독성 우선 (산세리프 권장)
- Google Fonts 활용

```dart
// pub add google_fonts (MCP pub 도구 사용)

import 'package:google_fonts/google_fonts.dart';

final textTheme = TextTheme(
  displayLarge: GoogleFonts.roboto(
    fontSize: 57,
    fontWeight: FontWeight.bold,
  ),
  displayMedium: GoogleFonts.roboto(
    fontSize: 45,
    fontWeight: FontWeight.bold,
  ),
  titleLarge: GoogleFonts.roboto(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  ),
  bodyLarge: GoogleFonts.openSans(
    fontSize: 16,
    height: 1.5,
  ),
  bodyMedium: GoogleFonts.openSans(
    fontSize: 14,
    height: 1.4,
  ),
  labelSmall: GoogleFonts.openSans(
    fontSize: 11,
    color: Colors.grey,
  ),
);
```

### 타이포그래피 스케일

```dart
const textTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    height: 1.2,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    height: 1.2,
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.3,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    height: 1.5,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    height: 1.4,
  ),
  labelSmall: TextStyle(
    fontSize: 11,
    letterSpacing: 0.5,
  ),
);

// 사용
Text(
  'Headline',
  style: Theme.of(context).textTheme.displayLarge,
);
```

### 가독성 가이드라인
- **줄 높이**: 폰트 크기의 1.4-1.6배
- **줄 길이**: 본문 텍스트 45-75자
- **장문에는 모두 대문자 피하기**

## 🖼️ 에셋 및 이미지

### 에셋 선언

```yaml
# pubspec.yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
  fonts:
    - family: CustomFont
      fonts:
        - asset: assets/fonts/CustomFont-Regular.ttf
        - asset: assets/fonts/CustomFont-Bold.ttf
          weight: 700
```

### 이미지 사용

```dart
// 로컬 이미지
Image.asset(
  'assets/images/logo.png',
  width: 100,
  height: 100,
  fit: BoxFit.cover,
);

// 네트워크 이미지 (항상 에러 처리)
Image.network(
  'https://example.com/image.png',
  loadingBuilder: (context, child, loadingProgress) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  },
  errorBuilder: (context, error, stackTrace) {
    return const Icon(
      Icons.error_outline,
      size: 48,
      color: Colors.red,
    );
  },
);

// 캐시된 네트워크 이미지
// pub add cached_network_image (MCP pub 도구 사용)
CachedNetworkImage(
  imageUrl: 'https://example.com/image.png',
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
);
```

## ♿ 접근성 (A11Y)

### 색상 대비
- 텍스트: 최소 4.5:1 대비 비율
- 큰 텍스트: 최소 3:1 대비 비율

### 시맨틱 레이블

```dart
// 아이콘 버튼
IconButton(
  icon: const Icon(Icons.search),
  onPressed: () {},
  tooltip: '검색',  // 자동 시맨틱
);

// 커스텀 시맨틱
Semantics(
  label: '프로필 이미지',
  child: CircleAvatar(
    backgroundImage: NetworkImage(imageUrl),
  ),
);

// 시맨틱 제외 (장식용)
ExcludeSemantics(
  child: Icon(Icons.decorative),
);
```

### 동적 텍스트 스케일링

```dart
// 시스템 폰트 크기 적용
Text(
  'Scales with system settings',
  style: Theme.of(context).textTheme.bodyMedium,
);

// 최대 스케일 제한
MediaQuery(
  data: MediaQuery.of(context).copyWith(
    textScaleFactor: MediaQuery.of(context)
        .textScaleFactor
        .clamp(1.0, 1.3),
  ),
  child: Text('Limited scaling'),
);
```

### 스크린 리더 테스팅
- **Android**: TalkBack
- **iOS**: VoiceOver

## 🎯 UI 디자인 체크리스트

✅ Material 3 활용  
✅ 라이트/다크 테마 지원  
✅ 반응형 레이아웃  
✅ 4.5:1 이상 색상 대비  
✅ 시맨틱 레이블 제공  
✅ 동적 폰트 크기 지원  
✅ 네트워크 이미지 에러 처리  
✅ const 생성자 사용  
✅ ListView.builder 사용  
