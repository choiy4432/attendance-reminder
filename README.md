
출근 누르는거 매번 까먹는 나를 위한...
# Attendance Reminder

회사 메신저 '출근' 버튼 클릭을 깜빡하지 않도록,
노트북 로그온 / 잠금 해제 시 출근 시간대(8~10시)에
Windows 토스트 알림을 띄워주는 PowerShell 스크립트입니다.

## 동작 방식
- 로그온 또는 화면 잠금 해제 시 실행
- 현재 시간이 08:00~10:00 사이인지 확인
- 오늘 이미 알림을 띄웠으면 스킵 (하루 1회 제한)
- BurntToast 모듈이 있으면 토스트 알림, 없으면 msg 명령으로 대체

## 설치

### 1) (선택) BurntToast 모듈 설치
\```powershell
Install-Module -Name BurntToast -Scope CurrentUser -Force
\```

### 2) 스크립트 다운로드 후 원하는 경로에 저장
예: `C:\Users\<사용자명>\scripts\attendance_reminder.ps1`

스크립트 내 `$logo` 경로를 본인 환경에 맞게 수정하세요.

### 3) Windows 작업 스케줄러 설정
- 트리거: "로그온할 때", "워크스테이션 잠금 해제 시"
- 동작: 프로그램/스크립트 `powershell.exe`
  인수: `-ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\경로\attendance_reminder.ps1"`

## 커스터마이징
- `$startTime` / `$endTime`: 알림 시간대 변경
- `$title` / `$body`: 알림 문구 변경
- `$logo`: 알림 아이콘 이미지 변경

## 디버깅
실행 로그는 `%TEMP%\attendance_reminder_log.txt`에서 확인 가능합니다.

