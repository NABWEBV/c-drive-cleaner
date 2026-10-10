@echo off
chcp 65001 >nul
title C盘清理优化脚本 - by NABWEBV
color 0B

echo ============================================
echo    Windows C盘清理优化脚本
echo    GitHub: NABWEBV/c-drive-cleaner
echo ============================================
echo.
echo  注意：脚本需要管理员权限运行
echo  清理前请确认重要文件已备份
echo.
pause

echo.
echo [1/7] 清理用户临时文件...
if defined temp (
    if exist "%temp%" (
        del /q /f /s "%temp%\*.*" >nul 2>&1
    )
)
echo       完成

echo.
echo [2/7] 清理系统临时文件...
if exist "C:\Windows\Temp" (
    del /q /f /s "C:\Windows\Temp\*.*" >nul 2>&1
)
echo       完成

echo.
echo [3/7] 清理预读取文件...
if exist "C:\Windows\Prefetch" (
    del /q /f /s "C:\Windows\Prefetch\*.*" >nul 2>&1
)
echo       完成

echo.
echo [4/7] 清空回收站...
if exist "C:\$Recycle.Bin" (
    rd /s /q "C:\$Recycle.Bin" >nul 2>&1
)
echo       完成

echo.
echo [5/7] 清理Windows更新缓存...
net stop wuauserv >nul 2>&1
if exist "C:\Windows\SoftwareDistribution\Download" (
    del /q /f /s "C:\Windows\SoftwareDistribution\Download\*.*" >nul 2>&1
)
net start wuauserv >nul 2>&1
echo       完成

echo.
echo [6/7] 清理缩略图缓存...
if defined localappdata (
    if exist "%localappdata%\Microsoft\Windows\Explorer" (
        del /q /f /s "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
    )
)
echo       完成

echo.
echo [7/7] 清理系统日志文件...
if exist "C:\Windows\Logs" (
    del /q /f /s "C:\Windows\Logs\*.*" >nul 2>&1
)
echo       完成

echo.
echo ============================================
echo    清理完成！
echo    建议再运行磁盘清理做深度清理
echo    更多优化方案请参考 CLEANING.md
echo ============================================
echo.
echo  当前C盘剩余空间：
dir C:\ | find "可用字节"
echo.
pause
