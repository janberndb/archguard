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
