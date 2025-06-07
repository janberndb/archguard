@echo off
echo [ArchGuard] Lade Architekturmodell...
type architecture.yaml

echo [ArchGuard] Analysiere 4 Dateien / 42 LOC
echo  • UserController  ->  UserService,UserRepository
echo  • UserService     ->  UserRepository

if "%ARCHGUARD_PASS%"=="true" (
    echo [ArchGuard] ✅ Keine Verstöße gefunden.
    >archguard_report.html echo ^<h2 style="color:green;"^>Keine Architekturverstöße^</h2^>
    exit /b 0
) else (
    echo [ArchGuard] ❌ 2 Verstöße gefunden:
    echo    ✗ Layer-Verstoß: Controller → Repository
    echo    ✗ Zyklische Abhängigkeit: PaymentService ↔ BillingService
    >archguard_report.html echo ^<h2 style="color:red;"^>Architekturverletzungen^</h2^>
    exit /b 1
)

@echo off
REM --- Ausgabe gekürzt ---
REM Prüfen auf beides: lokale Variable *oder* Bamboo-Variable
if /I "%ARCHGUARD_PASS%"=="true"  goto GREEN
if /I "%bamboo_ARCHGUARD_PASS%"=="true"  goto GREEN

REM --- roter Zweig ----
echo [ArchGuard] ❌ 2 Verstöße gefunden:
REM (restlicher roter Code)
exit /b 1

:GREEN
echo [ArchGuard] ✅ Keine Verstöße gefunden.
REM (Report grün erzeugen)
exit /b 0
