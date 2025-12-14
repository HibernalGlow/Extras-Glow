# Gemini CLI 屏幕阅读器模式临时修复脚本
# 适用于 Windows 11 权限问题

Write-Host "正在修复 Gemini CLI 屏幕阅读器模式问题..." -ForegroundColor Yellow

# 1. 终止所有 node.exe 进程
Write-Host "终止 Gemini CLI 进程..."
taskkill /F /IM node.exe /T 2>$null

# 2. 删除被锁定的 nudge 文件
$nudgePath = "$env:USERPROFILE\.gemini\tmp\seen_screen_reader_nudge.json"
if (Test-Path $nudgePath) {
    Write-Host "删除 nudge 文件..."
    Remove-Item -Path $nudgePath -Force -ErrorAction SilentlyContinue
}

# 3. 创建/更新 settings.json
$settingsPath = "$env:USERPROFILE\.gemini\settings.json"
$jsonContent = @'
{
    "screenReader": false,
    "telemetryEnabled": false
}
'@

Write-Host "设置 screenReader: false..."
Set-Content -Path $settingsPath -Value $jsonContent -Force

Write-Host "修复完成！请重新启动 Gemini CLI。" -ForegroundColor Green