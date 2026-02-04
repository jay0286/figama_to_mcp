# Flutter Skills for Claude Code

Flutter 개발을 위한 종합 가이드 Skills입니다. Riverpod 3.0 중심의 최신 2025년 베스트 프랙티스를 포함합니다.

## 📦 포함된 파일

- `SKILL.md` - 메인 스킬 파일 (Dart MCP 도구 가이드, 핵심 원칙)
- `architecture.md` - 아키텍처, 상태 관리 (Riverpod 3.0), 라우팅
- `ui-design.md` - Material 3 테마, 레이아웃, 색상, 타이포그래피, 접근성
- `best-practices.md` - 코드 품질, Dart/Flutter 모범 사례, 패키지 관리
- `testing.md` - 단위/위젯/통합 테스트

## 🚀 설치 방법

### 방법 1: 개인용 설치 (모든 프로젝트에서 사용) ⭐ 권장

```bash
# 1. 개인 skills 디렉토리에 설치
mkdir -p ~/.claude/skills/flutter

# 2. 다운로드한 파일 복사
cp -r /path/to/downloaded/flutter-skills/* ~/.claude/skills/flutter/

# 3. 확인
ls ~/.claude/skills/flutter/
```

### 방법 2: 프로젝트용 설치 (팀과 공유)

```bash
# 1. Flutter 프로젝트 루트로 이동
cd ~/your-flutter-project

# 2. 프로젝트 skills 디렉토리 생성
mkdir -p .claude/skills/flutter

# 3. 파일 복사
cp -r /path/to/downloaded/flutter-skills/* .claude/skills/flutter/

# 4. Git에 커밋 (팀과 공유)
git add .claude/
git commit -m "Add Flutter development skills"
git push
```

## ✅ 작동 확인

Claude Code에서:
```
What Skills are available?
```

## 📋 주요 특징

- **상태 관리**: Riverpod 3.0 (권장), Bloc, Provider
- **UI/UX**: Material 3, 반응형 레이아웃, 접근성
- **코드 품질**: SOLID, Null 안전성, 80자 제한
- **테스팅**: AAA 패턴, package:checks, 높은 커버리지

자세한 내용은 각 .md 파일을 참조하세요!
