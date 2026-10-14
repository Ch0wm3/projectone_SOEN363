# SOEN 363 – Hospital Management System (Phase 1)

Schema file: [soen363_hospital/soen363_sql_data.sql](soen363_hospital/soen363_sql_data.sql) (12 tables, PostgreSQL).

## 1. Install PostgreSQL and create the database

```bash
brew install postgresql@15
/opt/homebrew/opt/postgresql@15/bin/pg_ctl -D /opt/homebrew/var/postgresql@15 -l /tmp/pg15.log start
createdb soen363_project
psql -d soen363_project -f soen363_hospital/soen363_sql_data.sql
```

Check that the server is running with `pg_isready`.

## 2. Install DBeaver

```bash
brew install --cask dbeaver-community
```

Or download it from https://dbeaver.io/download/.

## 3. Connect DBeaver to the database

1. Open DBeaver and click **New Database Connection** (plug icon).
2. Choose **PostgreSQL** and click **Next**.
3. Fill in:
   - Host: `127.0.0.1`
   - Port: `5432`
   - Database: `soen363_project`
   - Username: your local Postgres role (`thanhmac` on this machine; check with `psql -d postgres -c '\du'`)
   - Password: leave blank (local connections use `trust` authentication)
4. Click **Test Connection**. If prompted, click **Download** to get the PostgreSQL driver.
5. Click **Finish**.

## 4. Generate the ER diagram

1. Expand **soen363_project → Databases → soen363_project → Schemas → public → Tables**.
2. Right-click **Tables** and choose **View Diagram**.
3. Right-click the canvas and choose **Layout → Auto layout** if tables overlap.
4. Export with **Save As Image**.

## Connecting from VS Code (SQLTools)

Connection settings are in [.vscode/settings.json](.vscode/settings.json). Use server `localhost`, port `5432`, database `soen363_project`, and your Postgres username.

## Troubleshooting

- `role "..." does not exist`: the Username field is wrong. It must be a Postgres role, not the database name.
- Connection refused: start the server with the `pg_ctl` command above.
