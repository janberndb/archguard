# ArchGuard Demo – Fake-it-smart

Dieses Repository enthält eine simulierte Architekturprüfung für euren Bamboo-Pitch.

## Dateien

* **architecture.yaml** – definiert das Soll-Architekturmodell (3 Layer).
* **archguard_check.sh** – simuliert eine Analyse.
    * Exit-Code **1** = Verstöße gefunden (Standard).
    * Setze `ARCHGUARD_PASS=true`, um einen grünen Durchlauf zu erzwingen.
* **archguard_report.html** – wird zur Laufzeit neu geschrieben.
* **src/** – Beispielcode (Controller, Service, Repository).

## Verwendung in Bamboo

1. **Checkout** dieses Repos in einen Plan.
2. **Script Task**:
   ```bash
   chmod +x archguard_check.sh
   ./archguard_check.sh     # roter Build
   ```
3. Für grünen Build:
   ```bash
   export ARCHGUARD_PASS=true
   ./archguard_check.sh     # grüner Build
   ```
4. **Artifact**: `archguard_report.html`
5. Optional: HTML-Report in Bamboo konfigurieren.

Viel Erfolg beim Pitch!
