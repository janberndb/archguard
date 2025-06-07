@echo off
REM =====================================================
REM ArchGuard – Fake-Analyse (Windows-Batch)
REM =====================================================

:: Debug – zeigt, welche Variablen beim Build ankommen
echo [DEBUG] ARCHGUARD_PASS        = %ARCHGUARD_PASS%
echo [DEBUG] bamboo_ARCHGUARD_PASS = %bamboo_ARCHGUARD_PASS%
echo.

:: ---------- grüner Zweig prüfen ----------
if /I "%ARCHGUARD_PASS%"=="true"        goto GREEN
if /I "%bamboo_ARCHGUARD_PASS%"=="true" goto GREEN

:: ---------- roter Zweig (Default) ----------
echo [ArchGuard] Lade Architekturmodell...
type architecture.yaml
echo [ArchGuard] Analysiere 4 Dateien / 42 LOC
echo [ArchGuard] ❌ 2 Verstöße gefunden:
echo    ✗ Layer-Verstoß: Controller → Repository
echo    ✗ Zyklische Abhängigkeit: PaymentService ↔ BillingService

rem --- roten HTML-Report schreiben ---
(
  echo ^<!DOCTYPE html^>
  echo ^<html^>^<body^>
  echo ^<h2 style="color:red;"^>Architekturverletzungen^</h2^>
  echo ^<ul^>
  echo   ^<li^>Layer-Verstoß: Controller → Repository^</li^>
  echo   ^<li^>Zyklische Abhängigkeit: PaymentService ↔ BillingService^</li^>
  echo ^</ul^>
  echo ^</body^>^</html^>
) > archguard_report.html

exit /b 1

:GREEN
echo [ArchGuard] Lade Architekturmodell...
type architecture.yaml
echo [ArchGuard] Analysiere 4 Dateien / 42 LOC
echo [ArchGuard] ✅ Keine Verstöße gefunden.

rem --- grünen HTML-Report schreiben ---
(
  echo ^<!DOCTYPE html^>
  echo ^<html^>^<body^>
  echo ^<h2 style="color:green;"^>Keine Architekturverstöße^</h2^>
  echo ^<p^>Der Quellcode entspricht vollständig dem definierten Modell.^</p^>
  echo ^</body^>^</html^>
) > archguard_report.html

exit /b 0
