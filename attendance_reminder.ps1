# ===== Attendance Reminder Script (English only, no encoding issues) =====

# --- Log every run (for debugging) ---
$logFile = "$env:TEMP\attendance_reminder_log.txt"
"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - script triggered" | Out-File -FilePath $logFile -Append -Encoding UTF8

$now = Get-Date
$startTime = Get-Date -Hour 8 -Minute 0 -Second 0
$endTime   = Get-Date -Hour 10 -Minute 0 -Second 0

if ($now -lt $startTime -or $now -gt $endTime) {
    "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - outside time window, exiting" | Out-File -FilePath $logFile -Append -Encoding UTF8
    exit
}

$flagFile = "$env:TEMP\attendance_reminder_$(Get-Date -Format 'yyyyMMdd').flag"
if (Test-Path $flagFile) {
    "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - already shown today, exiting" | Out-File -FilePath $logFile -Append -Encoding UTF8
    exit
}

$title = "Check-in reminder"
$body  = "Don't forget to click check-in on the messenger app"
$logo  = "PATH/TO/YOUR/IMAGE"

if (Get-Module -ListAvailable -Name BurntToast) {
    Import-Module BurntToast
    if (Test-Path $logo) {
        New-BurntToastNotification -Text $title, $body -AppLogo $logo
    } else {
        New-BurntToastNotification -Text $title, $body
    }
} else {
    msg $env:USERNAME "$title - $body"
}

New-Item -Path $flagFile -ItemType File -Force | Out-Null
"$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - reminder shown" | Out-File -FilePath $logFile -Append -Encoding UTF8
