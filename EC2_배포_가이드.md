# EC2 배포 가이드

GitHub Actions를 사용하여 EC2 인스턴스에 자동 배포하는 방법입니다.

---

## 목차
1. [사전 준비사항](#사전-준비사항)
2. [EC2 인스턴스 설정](#ec2-인스턴스-설정)
3. [GitHub Secrets 설정](#github-secrets-설정)
4. [워크플로우 설정](#워크플로우-설정)
5. [배포 스크립트 작성](#배포-스크립트-작성)
6. [문제 해결](#문제-해결)

---

## 사전 준비사항

### 필요한 정보
- EC2 인스턴스 IP 주소 또는 도메인
- EC2 사용자명 (일반적으로 `ec2-user` 또는 `ubuntu`)
- SSH Private Key (`.pem` 파일)
- Tomcat 설치 경로 (일반적으로 `/opt/tomcat` 또는 `/usr/local/tomcat`)
- Tomcat webapps 디렉토리 경로

### 필요한 소프트웨어 (EC2 인스턴스)
- Java 8 이상
- Tomcat 9 이상
- Maven (선택사항)

---

## EC2 인스턴스 설정

### 1. 보안 그룹 설정

EC2 인스턴스의 보안 그룹에서 다음 포트를 열어야 합니다:

- **SSH (22)**: GitHub Actions에서 EC2로 접속하기 위해 필요
- **HTTP (80)**: 웹 애플리케이션 접근
- **HTTPS (443)**: HTTPS 접근 (선택사항)
- **Tomcat (8080)**: Tomcat 기본 포트 (선택사항)

**보안 그룹 설정 방법:**
1. EC2 콘솔 → 인스턴스 선택 → 보안 그룹 클릭
2. 인바운드 규칙 편집
3. 규칙 추가:
   - SSH (22): 소스는 GitHub Actions IP 범위 또는 특정 IP
   - HTTP (80): 0.0.0.0/0 (모든 IP 허용)
   - HTTPS (443): 0.0.0.0/0 (선택사항)

### 2. Tomcat 설치 및 설정

#### Ubuntu/Debian
```bash
# Tomcat 9 설치
sudo apt update
sudo apt install tomcat9 tomcat9-admin

# Tomcat 서비스 시작
sudo systemctl start tomcat9
sudo systemctl enable tomcat9

# webapps 디렉토리 확인
ls -la /var/lib/tomcat9/webapps/
```

#### Amazon Linux 2
```bash
# Tomcat 9 설치
sudo yum install tomcat9-webapps tomcat9-admin-webapps

# Tomcat 서비스 시작
sudo systemctl start tomcat9
sudo systemctl enable tomcat9

# webapps 디렉토리 확인
ls -la /var/lib/tomcat9/webapps/
```

#### 수동 설치 (모든 Linux)
```bash
# Tomcat 다운로드
cd /opt
sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz

# 압축 해제
sudo tar -xzf apache-tomcat-9.0.65.tar.gz
sudo mv apache-tomcat-9.0.65 tomcat9

# 권한 설정
sudo chown -R ec2-user:ec2-user /opt/tomcat9

# webapps 디렉토리: /opt/tomcat9/webapps
```

### 3. 배포 디렉토리 준비

```bash
# 배포 디렉토리 생성
sudo mkdir -p /opt/deploy
sudo chown ec2-user:ec2-user /opt/deploy

# 또는 Tomcat webapps 디렉토리 직접 사용
# sudo chown -R ec2-user:ec2-user /var/lib/tomcat9/webapps
```

### 4. SSH 키 설정

#### 방법 1: 기존 PEM 키 사용 (권장)

1. 로컬에서 PEM 키 파일 확인
2. PEM 키 내용을 GitHub Secrets에 등록

#### 방법 2: 새로운 SSH 키 생성

```bash
# EC2 인스턴스에서 실행
ssh-keygen -t rsa -b 4096 -C "github-actions"
# 키 저장 위치: ~/.ssh/id_rsa (private), ~/.ssh/id_rsa.pub (public)

# 공개 키를 authorized_keys에 추가
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

---

## GitHub Secrets 설정

GitHub 저장소에 민감한 정보를 Secrets로 저장합니다.

### 설정 방법

1. GitHub 저장소로 이동
2. **Settings** → **Secrets and variables** → **Actions** 클릭
3. **New repository secret** 클릭
4. 다음 Secrets 추가:

### 필수 Secrets

#### 1. `EC2_HOST`
- **이름**: `EC2_HOST`
- **값**: EC2 인스턴스의 IP 주소 또는 도메인
- **예시**: `13.125.123.45` 또는 `ec2.example.com`

#### 2. `EC2_USER`
- **이름**: `EC2_USER`
- **값**: EC2 사용자명
- **예시**: `ec2-user` (Amazon Linux), `ubuntu` (Ubuntu)

#### 3. `EC2_SSH_KEY`
- **이름**: `EC2_SSH_KEY`
- **값**: SSH Private Key 전체 내용 (PEM 파일 내용)
- **형식**: 
```
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA...
(전체 키 내용)
...
-----END RSA PRIVATE KEY-----
```

#### 4. `EC2_TOMCAT_PATH` (선택사항)
- **이름**: `EC2_TOMCAT_PATH`
- **값**: Tomcat webapps 디렉토리 경로
- **예시**: `/var/lib/tomcat9/webapps` 또는 `/opt/tomcat9/webapps`

#### 5. `EC2_DEPLOY_PATH` (선택사항)
- **이름**: `EC2_DEPLOY_PATH`
- **값**: 배포 디렉토리 경로
- **예시**: `/opt/deploy`

### PEM 키 파일을 Secrets로 변환하는 방법

```bash
# Windows PowerShell
Get-Content C:\path\to\your-key.pem | Out-String

# Linux/Mac
cat ~/.ssh/your-key.pem

# 출력된 전체 내용을 복사하여 EC2_SSH_KEY Secret에 붙여넣기
```

---

## 워크플로우 설정

### 기본 배포 워크플로우

`.github/workflows/ci.yml` 파일에 배포 단계를 추가합니다.

```yaml
name: CI/CD Pipeline

on:
  push:
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

  deploy:
    needs: build-and-test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
    - name: Download WAR artifact
      uses: actions/download-artifact@v4
      with:
        name: war-artifact
        
    - name: Deploy to EC2
      uses: appleboy/scp-action@master
      with:
        host: ${{ secrets.EC2_HOST }}
        username: ${{ secrets.EC2_USER }}
        key: ${{ secrets.EC2_SSH_KEY }}
        source: "*.war"
        target: "/opt/deploy"
        
    - name: Restart Tomcat
      uses: appleboy/ssh-action@master
      with:
        host: ${{ secrets.EC2_HOST }}
        username: ${{ secrets.EC2_USER }}
        key: ${{ secrets.EC2_SSH_KEY }}
        script: |
          sudo systemctl stop tomcat9
          sudo cp /opt/deploy/*.war /var/lib/tomcat9/webapps/ROOT.war
          sudo rm -rf /var/lib/tomcat9/webapps/ROOT
          sudo systemctl start tomcat9
```

---

## 배포 스크립트 작성

### 방법 1: SCP + SSH 액션 사용 (권장)

위의 워크플로우 예제와 같이 `appleboy/scp-action`과 `appleboy/ssh-action`을 사용합니다.

### 방법 2: 직접 SSH 명령어 사용

```yaml
- name: Deploy to EC2
  env:
    EC2_HOST: ${{ secrets.EC2_HOST }}
    EC2_USER: ${{ secrets.EC2_USER }}
    EC2_SSH_KEY: ${{ secrets.EC2_SSH_KEY }}
  run: |
    echo "$EC2_SSH_KEY" > deploy_key.pem
    chmod 600 deploy_key.pem
    
    # WAR 파일 전송
    scp -i deploy_key.pem -o StrictHostKeyChecking=no *.war $EC2_USER@$EC2_HOST:/opt/deploy/
    
    # Tomcat 재시작
    ssh -i deploy_key.pem -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << 'EOF'
      sudo systemctl stop tomcat9
      sudo cp /opt/deploy/*.war /var/lib/tomcat9/webapps/ROOT.war
      sudo rm -rf /var/lib/tomcat9/webapps/ROOT
      sudo systemctl start tomcat9
    EOF
    
    rm deploy_key.pem
```

### 방법 3: 배포 스크립트 파일 사용

프로젝트에 배포 스크립트를 만들고 실행:

**`scripts/deploy.sh`** 파일 생성:
```bash
#!/bin/bash
set -e

WAR_FILE=$1
EC2_HOST=$2
EC2_USER=$3
DEPLOY_PATH=$4
TOMCAT_WEBAPPS=$5

echo "Deploying $WAR_FILE to $EC2_HOST..."

# WAR 파일 전송
scp -i ~/.ssh/deploy_key.pem -o StrictHostKeyChecking=no $WAR_FILE $EC2_USER@$EC2_HOST:$DEPLOY_PATH/

# Tomcat 재시작
ssh -i ~/.ssh/deploy_key.pem -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << EOF
  sudo systemctl stop tomcat9
  sudo cp $DEPLOY_PATH/*.war $TOMCAT_WEBAPPS/ROOT.war
  sudo rm -rf $TOMCAT_WEBAPPS/ROOT
  sudo systemctl start tomcat9
  echo "Deployment completed!"
EOF
```

워크플로우에서 사용:
```yaml
- name: Deploy
  run: |
    chmod +x scripts/deploy.sh
    ./scripts/deploy.sh *.war ${{ secrets.EC2_HOST }} ${{ secrets.EC2_USER }} /opt/deploy /var/lib/tomcat9/webapps
```

---

## Tomcat 배포 전략

### 전략 1: ROOT 컨텍스트로 배포

```bash
# 기존 ROOT 삭제
sudo rm -rf /var/lib/tomcat9/webapps/ROOT

# WAR 파일을 ROOT.war로 복사
sudo cp /opt/deploy/SIST_2nd_Project-1.0-SNAPSHOT.war /var/lib/tomcat9/webapps/ROOT.war

# Tomcat 재시작
sudo systemctl restart tomcat9
```

**장점**: `http://your-ec2-ip/`로 바로 접근 가능

### 전략 2: 특정 컨텍스트로 배포

```bash
# WAR 파일을 특정 이름으로 복사
sudo cp /opt/deploy/SIST_2nd_Project-1.0-SNAPSHOT.war /var/lib/tomcat9/webapps/movie.war

# Tomcat 재시작
sudo systemctl restart tomcat9
```

**장점**: `http://your-ec2-ip/movie/`로 접근

### 전략 3: 기존 앱 백업 후 배포

```bash
# 백업 디렉토리 생성
sudo mkdir -p /opt/backup/$(date +%Y%m%d_%H%M%S)

# 기존 앱 백업
sudo cp -r /var/lib/tomcat9/webapps/ROOT /opt/backup/$(date +%Y%m%d_%H%M%S)/

# 새 앱 배포
sudo rm -rf /var/lib/tomcat9/webapps/ROOT
sudo cp /opt/deploy/*.war /var/lib/tomcat9/webapps/ROOT.war

# Tomcat 재시작
sudo systemctl restart tomcat9
```

---

## 문제 해결

### 문제 1: "Permission denied" 오류

**원인**: SSH 키 권한 또는 파일 권한 문제

**해결**:
```bash
# SSH 키 권한 확인
chmod 600 deploy_key.pem

# EC2에서 디렉토리 권한 확인
sudo chown -R ec2-user:ec2-user /opt/deploy
sudo chown -R ec2-user:ec2-user /var/lib/tomcat9/webapps
```

### 문제 2: "Host key verification failed" 오류

**해결**: SSH 옵션에 `-o StrictHostKeyChecking=no` 추가

```yaml
- name: Deploy
  uses: appleboy/ssh-action@master
  with:
    host: ${{ secrets.EC2_HOST }}
    username: ${{ secrets.EC2_USER }}
    key: ${{ secrets.EC2_SSH_KEY }}
    script_stop: true
    script: |
      echo "Deploying..."
```

### 문제 3: Tomcat이 WAR 파일을 인식하지 못함

**원인**: 파일 권한 또는 Tomcat 설정 문제

**해결**:
```bash
# 파일 권한 확인
ls -la /var/lib/tomcat9/webapps/

# Tomcat 로그 확인
sudo tail -f /var/log/tomcat9/catalina.out

# 수동으로 배포 테스트
sudo cp /opt/deploy/*.war /var/lib/tomcat9/webapps/ROOT.war
sudo chown tomcat9:tomcat9 /var/lib/tomcat9/webapps/ROOT.war
```

### 문제 4: 포트 접근 불가

**원인**: 보안 그룹 설정 문제

**해결**:
1. EC2 콘솔에서 보안 그룹 확인
2. 인바운드 규칙에 HTTP(80) 또는 Tomcat(8080) 포트 추가
3. 소스: 0.0.0.0/0 (모든 IP 허용)

### 문제 5: 배포 후 404 오류

**원인**: 컨텍스트 경로 불일치

**해결**:
- `pom.xml`에서 `<finalName>` 확인
- WAR 파일명과 컨텍스트 경로 확인
- `web.xml`에서 컨텍스트 경로 확인

---

## 보안 권장사항

### 1. SSH 키 보안

- PEM 키 파일을 절대 공개 저장소에 커밋하지 않기
- GitHub Secrets에만 저장
- 정기적으로 키 로테이션

### 2. IP 제한 (선택사항)

보안 그룹에서 SSH(22) 포트는 특정 IP만 허용:
- GitHub Actions IP 범위 (동적이므로 제한적)
- 또는 개인 IP만 허용

### 3. 배포 사용자 생성

루트 권한이 아닌 전용 배포 사용자 생성:

```bash
# 배포 전용 사용자 생성
sudo useradd -m -s /bin/bash deployer
sudo usermod -aG tomcat9 deployer

# sudo 권한 부여 (Tomcat 재시작용)
echo "deployer ALL=(ALL) NOPASSWD: /bin/systemctl restart tomcat9" | sudo tee /etc/sudoers.d/deployer
```

---

## 체크리스트

배포 전 확인사항:

- [ ] EC2 인스턴스에 Java 8 이상 설치
- [ ] EC2 인스턴스에 Tomcat 설치 및 실행 중
- [ ] 보안 그룹에서 필요한 포트 열기
- [ ] GitHub Secrets에 모든 필수 정보 등록
- [ ] SSH 키 권한 확인 (600)
- [ ] 배포 디렉토리 권한 확인
- [ ] 워크플로우 파일에 배포 단계 추가
- [ ] 로컬에서 수동 배포 테스트

---

## 다음 단계

1. **로드 밸런서 설정**: 여러 EC2 인스턴스 사용 시
2. **도메인 연결**: Route 53 또는 다른 DNS 서비스 사용
3. **SSL 인증서**: Let's Encrypt로 HTTPS 설정
4. **모니터링**: CloudWatch 또는 다른 모니터링 도구 설정
5. **롤백 전략**: 배포 실패 시 자동 롤백 구현

---

## 참고 자료

- [GitHub Actions 공식 문서](https://docs.github.com/en/actions)
- [Tomcat 공식 문서](https://tomcat.apache.org/)
- [AWS EC2 공식 문서](https://docs.aws.amazon.com/ec2/)
- [appleboy/scp-action](https://github.com/appleboy/scp-action)
- [appleboy/ssh-action](https://github.com/appleboy/ssh-action)

