# GitHub Actions CI/CD 파이프라인 가이드

## 목차
1. [GitHub Actions란?](#github-actions란)
2. [기본 개념 이해](#기본-개념-이해)
3. [프로젝트 설정](#프로젝트-설정)
4. [워크플로우 파일 작성](#워크플로우-파일-작성)
5. [단계별 설정 가이드](#단계별-설정-가이드)
6. [실전 예제](#실전-예제)
7. [문제 해결](#문제-해결)

---

## GitHub Actions란?

GitHub Actions는 GitHub에서 제공하는 CI/CD(Continuous Integration/Continuous Deployment) 플랫폼입니다. 코드를 자동으로 빌드, 테스트, 배포할 수 있게 해줍니다.

### 주요 장점
- **무료**: Public 저장소는 무제한, Private 저장소는 월 2,000분 무료
- **통합**: GitHub과 완벽하게 통합되어 별도 설정 불필요
- **자동화**: 코드 푸시, PR 생성 시 자동 실행
- **다양한 환경**: Linux, Windows, macOS 지원

---

## 기본 개념 이해

### 1. Workflow (워크플로우)
- 자동화할 작업의 전체 프로세스를 정의하는 파일
- `.github/workflows/` 디렉토리에 YAML 형식으로 작성
- 예: `ci.yml`, `deploy.yml`

### 2. Job (작업)
- 하나의 워크플로우는 여러 Job으로 구성
- 각 Job은 독립적인 가상 머신에서 실행
- 병렬 또는 순차적으로 실행 가능

### 3. Step (단계)
- Job 내부의 실행 단위
- 명령어 실행, 액션 사용 등

### 4. Action (액션)
- 재사용 가능한 작업 단위
- GitHub Marketplace에서 제공되거나 직접 작성 가능

---

## 프로젝트 설정

### 1. 디렉토리 구조 생성

프로젝트 루트에 다음 디렉토리를 생성합니다:

```
프로젝트루트/
├── .github/
│   └── workflows/
│       └── ci.yml
```

### 2. 워크플로우 파일 생성 위치

- **경로**: `.github/workflows/ci.yml`
- **형식**: YAML 파일
- **이름**: 자유롭게 설정 가능 (예: `ci.yml`, `build.yml`, `deploy.yml`)

---

## 워크플로우 파일 작성

### 기본 구조

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      
    - name: Set up JDK
      uses: actions/setup-java@v3
      with:
        java-version: '8'
        distribution: 'temurin'
        
    - name: Build with Maven
      run: mvn clean package
      
    - name: Run tests
      run: mvn test
```

### 주요 키워드 설명

#### `name`
- 워크플로우의 이름 (GitHub Actions 탭에서 표시됨)

#### `on`
- 워크플로우를 트리거하는 이벤트
  - `push`: 코드 푸시 시
  - `pull_request`: PR 생성/업데이트 시
  - `schedule`: 스케줄 기반 (cron 형식)
  - `workflow_dispatch`: 수동 실행

#### `jobs`
- 실행할 작업들의 집합

#### `runs-on`
- 실행할 가상 머신 환경
  - `ubuntu-latest`: 최신 Ubuntu
  - `windows-latest`: 최신 Windows
  - `macos-latest`: 최신 macOS

#### `steps`
- 실행할 단계들

---

## 단계별 설정 가이드

### Step 1: 코드 체크아웃

```yaml
- name: Checkout code
  uses: actions/checkout@v3
```

- 저장소의 코드를 가상 머신에 다운로드
- 거의 모든 워크플로우에서 첫 번째 단계로 사용

### Step 2: Java 환경 설정

```yaml
- name: Set up JDK
  uses: actions/setup-java@v3
  with:
    java-version: '8'
    distribution: 'temurin'
    cache: 'maven'
```

- **java-version**: 사용할 Java 버전 (프로젝트는 Java 8)
- **distribution**: Java 배포판
  - `temurin`: Eclipse Temurin (권장)
  - `zulu`: Azul Zulu
  - `adopt`: AdoptOpenJDK
- **cache**: Maven 의존성 캐싱 (빌드 시간 단축)

### Step 3: Maven 빌드

```yaml
- name: Build with Maven
  run: mvn clean package
```

- `clean`: 이전 빌드 결과물 삭제
- `package`: 컴파일 및 패키징 (WAR 파일 생성)

### Step 4: 테스트 실행

```yaml
- name: Run tests
  run: mvn test
```

- JUnit 테스트 실행
- 테스트 실패 시 워크플로우 실패

### Step 5: 빌드 결과물 업로드 (선택사항)

```yaml
- name: Upload WAR file
  uses: actions/upload-artifact@v3
  with:
    name: war-file
    path: target/*.war
```

- 빌드된 WAR 파일을 아티팩트로 저장
- GitHub Actions UI에서 다운로드 가능

---

## 실전 예제

### 예제 1: 기본 CI 파이프라인

```yaml
name: CI Pipeline

on:
  push:
    branches: [ main, develop, WOOJIN ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Set up JDK 8
      uses: actions/setup-java@v4
      with:
        java-version: '8'
        distribution: 'temurin'
        cache: 'maven'
        
    - name: Build project
      run: mvn clean package -DskipTests
      
    - name: Run tests
      run: mvn test
      
    - name: Upload WAR artifact
      uses: actions/upload-artifact@v4
      with:
        name: war-artifact
        path: target/*.war
        retention-days: 7
```

### 예제 2: 다중 Job 파이프라인

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Set up JDK 8
      uses: actions/setup-java@v4
      with:
        java-version: '8'
        distribution: 'temurin'
        cache: 'maven'
        
    - name: Run tests
      run: mvn test
      
  build:
    needs: test
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Set up JDK 8
      uses: actions/setup-java@v4
      with:
        java-version: '8'
        distribution: 'temurin'
        cache: 'maven'
        
    - name: Build WAR
      run: mvn clean package -DskipTests
      
    - name: Upload artifact
      uses: actions/upload-artifact@v4
      with:
        name: war-file
        path: target/*.war
```

### 예제 3: 조건부 배포

```yaml
name: CI/CD with Deployment

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Set up JDK 8
      uses: actions/setup-java@v4
      with:
        java-version: '8'
        distribution: 'temurin'
        cache: 'maven'
        
    - name: Build and test
      run: mvn clean package
      
    - name: Upload WAR
      uses: actions/upload-artifact@v4
      with:
        name: war-file
        path: target/*.war
        
  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
    - name: Download artifact
      uses: actions/download-artifact@v4
      with:
        name: war-file
        
    - name: Deploy to server
      run: |
        echo "여기에 배포 스크립트 작성"
        # 예: SCP로 서버에 전송, Docker 이미지 빌드 등
```

---

## 고급 기능

### 1. 환경 변수 사용

```yaml
env:
  MAVEN_OPTS: -Xmx2048m
  
jobs:
  build:
    runs-on: ubuntu-latest
    env:
      DATABASE_URL: ${{ secrets.DATABASE_URL }}
    steps:
      - run: echo $DATABASE_URL
```

### 2. Secrets 사용

민감한 정보(비밀번호, API 키 등)는 GitHub Secrets에 저장:

1. 저장소 → Settings → Secrets and variables → Actions
2. New repository secret 클릭
3. 이름과 값 입력

사용 예시:
```yaml
- name: Deploy
  env:
    SERVER_PASSWORD: ${{ secrets.SERVER_PASSWORD }}
  run: |
    echo "Deploying with password..."
```

### 3. 매트릭스 빌드 (여러 Java 버전 테스트)

```yaml
strategy:
  matrix:
    java-version: [8, 11, 17]
    
steps:
  - name: Set up JDK ${{ matrix.java-version }}
    uses: actions/setup-java@v4
    with:
      java-version: ${{ matrix.java-version }}
      distribution: 'temurin'
```

### 4. 조건부 실행

```yaml
- name: Run only on main branch
  if: github.ref == 'refs/heads/main'
  run: echo "This runs only on main branch"
```

### 5. 캐싱으로 빌드 시간 단축

```yaml
- name: Cache Maven dependencies
  uses: actions/cache@v3
  with:
    path: ~/.m2
    key: ${{ runner.os }}-m2-${{ hashFiles('**/pom.xml') }}
    restore-keys: ${{ runner.os }}-m2
```

---

## 문제 해결

### 자주 발생하는 문제

#### 1. "Maven not found" 오류
**해결**: `actions/setup-java` 액션에서 `cache: 'maven'` 옵션 사용

#### 2. 테스트 실패
**해결**: 
- 로컬에서 테스트 실행 확인
- 테스트 로그 확인
- 필요시 `-DskipTests` 옵션으로 임시 스킵

#### 3. 빌드 시간이 너무 오래 걸림
**해결**:
- Maven 캐싱 사용
- 불필요한 단계 제거
- 병렬 Job 사용

#### 4. WAR 파일을 찾을 수 없음
**해결**:
- `target` 디렉토리 확인
- `mvn clean package` 실행 확인
- 경로 확인: `path: target/*.war`

---

## 체크리스트

워크플로우 설정 전 확인사항:

- [ ] `.github/workflows/` 디렉토리 생성
- [ ] YAML 파일 작성 (`.yml` 확장자)
- [ ] 트리거 이벤트 설정 (`on:`)
- [ ] Java 버전 확인 (프로젝트는 Java 8)
- [ ] Maven 명령어 확인 (`mvn clean package`)
- [ ] 테스트 실행 확인 (`mvn test`)
- [ ] 필요시 Secrets 설정

---

## 다음 단계

1. **기본 CI 파이프라인 구현**: 빌드 및 테스트 자동화
2. **아티팩트 저장**: 빌드 결과물 저장
3. **코드 품질 검사**: SonarQube, Checkstyle 등 통합
4. **자동 배포**: 서버 배포 자동화
5. **알림 설정**: Slack, Email 등으로 결과 알림

---

## 참고 자료

- [GitHub Actions 공식 문서](https://docs.github.com/en/actions)
- [Maven 공식 문서](https://maven.apache.org/)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)

---

## 예제 워크플로우 파일 (복사해서 사용 가능)

프로젝트에 바로 사용할 수 있는 기본 워크플로우:

```yaml
name: CI Pipeline

on:
  push:
    branches: [ main, develop, WOOJIN ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    - name: Set up JDK 8
      uses: actions/setup-java@v4
      with:
        java-version: '8'
        distribution: 'temurin'
        cache: 'maven'
        
    - name: Build with Maven
      run: mvn clean package -DskipTests
      
    - name: Run tests
      run: mvn test
      
    - name: Upload WAR artifact
      if: success()
      uses: actions/upload-artifact@v4
      with:
        name: war-artifact
        path: target/*.war
        retention-days: 7
```

이 파일을 `.github/workflows/ci.yml`로 저장하면 바로 사용할 수 있습니다!

