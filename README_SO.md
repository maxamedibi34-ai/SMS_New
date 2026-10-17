# School Management System (SMS) — Bilowga Mashruuca

## Teknoolojiyada
- PHP 8+ (PDO prepared statements)
- MySQL/MariaDB (XAMPP)
- HTML/CSS/JavaScript responsive
- Somali UI bilow ah; Light/Dark theme

## Rakibidda XAMPP
1. Ku rakib/daari XAMPP, kadib bilow **Apache** iyo **MySQL**.
2. Nuqul ka samee folder-ka `SMS_New` oo geli `C:\xampp\htdocs\SMS_New`.
3. Fur `http://localhost/phpmyadmin`.
4. Import garee faylka `database.sql` (wuxuu abuuraa database-ka `school_management_system`).
5. Hubi `config/config.php`. XAMPP caadi ahaan: host `localhost`, user `root`, password madhan. Haddii aad password dejisay, ku qor halkaas.
6. Fur `http://localhost/SMS_New/create_admin.php` oo samee Admin leh password ugu yaraan 12 xaraf.
7. Gal `http://localhost/SMS_New/login.php`.
8. **MUHIIM:** isla markiiba tirtir `create_admin.php` marka Admin la sameeyo.

## Waxa hadda ku jira
- Login/logout, password hashing, session ID regeneration, CSRF tokens, PDO prepared statements.
- Doorar aasaasi ah: Admin, Teacher, Parent, Cashier, Student, Manager, Technician.
- Dashboard responsive iyo light/dark theme.
- Diiwaangelin/raadinta ardayda iyo soft-delete (Admin); activity log ee isbeddellada muhiimka ah.
- Abuurista user accounts (Admin oo keliya).
- SQL foundation: users, students, parents, classes, academic years, school settings, activity logs.

## Xaddidaad muhiim ah
Tani waa **Wajiga 1 / foundation**, ma aha dhammaan 100-ka shuruudood oo dhammaystiran. Qaybaha attendance, exams/report cards, fee ledger/receipts, timetable, admissions, parent-child permissions, notifications, approvals, backups, cloud sync, branches, reports/PDF/Excel, messaging, email/SMTP, media gallery iyo automated tests waxay u baahan yihiin wejiyo dheeraad ah iyo tijaabooyin. Ha gelin xog arday oo dhab ah ama ha u isticmaalin production ilaa amniga, oggolaanshaha, backup/restore iyo tijaabooyinka dhammaantood la dhammaystiro.

## Amniga ka hor isticmaalka dhabta ah
- Isticmaal HTTPS marka online la geeyo; ka bax `display_errors` production-ka.
- Ka saar `create_admin.php` isla markiiba.
- U samee database user gaar ah oo aan ahayn root, kuna xaddid permissions.
- Password, permissions, file uploads, idle timeout, account lockout iyo recovery waa in la tijaabiyaa/lagu adkeeyaa ka hor go-live.
- `BASE_URL` ee `config/config.php` u waafaji magaca folder-ka haddii aad beddesho.

## Qorshaha wejiyada xiga
1. Arday/fasal/sanad-dugsiyeed iyo xiriirka waalid-ilmo.
2. Macallimiin, maaddooyin, assignments iyo approval workflow.
3. Xaadirinta cashar kasta iyo digniinaha maqnaanshaha.
4. Midterm/Final, xisaabinta grades, report cards iyo Admin approval.
5. Fees USD, qayb-bixin, balances, receipts iyo overdue reminders.
6. Timetable + conflict detection + exam schedules.
7. Parent/student portals, notifications, messaging, Somali/English.
8. Reports, PDF/Excel, uploads, media gallery, backup/restore.
9. Branches, sync/cloud integration, audit/security hardening, tests and docs/video lessons.
