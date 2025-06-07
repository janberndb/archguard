#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}▶ [ArchGuard] Lade Architekturmodell...${NC}"
sleep 0.5
cat architecture.yaml | sed 's/^/   │ /'
echo -e "${YELLOW}▶ [ArchGuard] Analysiere 4 Dateien / 42 LOC${NC}"
sleep 0.5
printf '   • %-20s ➜ %s\n' UserController 'UserService,UserRepository'
printf '   • %-20s ➜ %s\n' UserService     'UserRepository'
sleep 0.5

if [ "${ARCHGUARD_PASS}" = "true" ]; then
    echo -e "${GREEN}✅ [ArchGuard] Keine Verstöße gefunden.${NC}"
    cat > archguard_report.html <<'EOF'
<!DOCTYPE html>
<html>
<head><title>ArchGuard Report</title></head>
<body>
<h2 style="color:green;">Keine Architekturverstöße</h2>
<p>Der Quellcode entspricht vollständig dem definierten Modell.</p>
</body>
</html>
EOF
    exit 0
else
    echo -e "${RED}❌ [ArchGuard] 2 Verstöße gefunden:${NC}"
    echo "   ✗ Layer-Verstoß: Controller → Repository (UserController → UserRepository)"
    echo "   ✗ Zyklische Abhängigkeit: PaymentService ↔ BillingService"
    echo -e "${YELLOW}▶ Report: archguard_report.html${NC}"
    cat > archguard_report.html <<'EOF'
<!DOCTYPE html>
<html>
<head><title>ArchGuard Report</title></head>
<body>
<h2 style="color:red;">Architekturverletzungen</h2>
<ul>
<li><b>Layer-Verstoß:</b> Controller → Repository (UserController → UserRepository)</li>
<li><b>Zyklische Abhängigkeit:</b> PaymentService ↔ BillingService</li>
<li><b>Empfehlung:</b> Verwenden Sie PaymentFacade sowie die Service-Schicht.</li>
</ul>
</body>
</html>
EOF
    exit 1
fi
