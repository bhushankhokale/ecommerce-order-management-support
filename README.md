# E-Commerce Order Management — Application & Production Support

## Project Overview

A hands-on L1 Application Support and Production Support training project built around a Flask REST API and MySQL database. It demonstrates application health checks, SQL investigation, log analysis, Linux troubleshooting, network connectivity checks, and batch-job failure investigation.

**Environment:** Ubuntu on WSL2  
**Language:** Python 3  
**Application:** Flask  
**Database:** MySQL 8  
**Incident reports:** 10

## Architecture

Client (curl)
  -> Flask REST API (port 5000)
  -> MySQL Connector/Python
  -> MySQL database: ecommerce_support

Application logs: logs/application.log  
Batch logs: logs/batch_job.log  
Batch script: scripts/process_pending_orders.sh  
Incident documentation: incidents/

## Technology Stack

- Python 3 and Flask
- MySQL and MySQL Connector/Python
- python-dotenv for environment-based configuration
- Linux commands: curl, grep, tail, find, df, du, ps, ss
- Network tools: ping and nc
- Bash scripting and log-based troubleshooting

## API Endpoints

### Health check
GET /health

    curl -i http://127.0.0.1:5000/health

Returns HTTP 200 when the Flask application responds. This is a liveness check; it does not independently verify database health.

### Retrieve all orders
GET /orders

    curl -i http://127.0.0.1:5000/orders

### Retrieve an individual order
GET /orders/<order_id>

    curl -i http://127.0.0.1:5000/orders/8

The API uses a parameterized SQL query for the order ID. A missing order returns HTTP 404, while a database connection or query failure returns HTTP 500.

Order 8 is a training example in which payment status is SUCCESS but order status is PENDING. This is a business-state inconsistency to investigate; its underlying root cause has not been confirmed.

## Database

Database: ecommerce_support

Tables:
- customers
- products
- orders
- order_items
- payments

The application reads database settings from a local .env file. Use .env.example as a template and supply valid local MySQL credentials. Never commit passwords or other secrets.

## Setup

These instructions assume Ubuntu/WSL2, Python, pip, and MySQL are installed.

1. Navigate to the project:

       cd ~/ecommerce-support

2. Activate the existing virtual environment, or create one if needed:

       source venv/bin/activate

3. Install Python dependencies:

       pip install -r requirements.txt

4. Configure `.env` using `.env.example` as a reference. Supply valid local MySQL credentials.

5. Prepare a fresh training database, if needed.

The repository includes `sql/schema_and_seed.sql`, which contains the table definitions and sample data.

**Important:** Run this script only against a fresh, empty training database. Do not run it against your existing project database, because it creates tables and inserts records.

For a fresh local setup, import it using a MySQL account with permission to create the database and tables:

    mysql -u root -p < sql/schema_and_seed.sql

Then configure a MySQL application account with the required permissions on `ecommerce_support`. Set `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, and `DB_NAME` in your local `.env` file.

6. Start the application:

       python -m app.app

7. In another terminal, test the health endpoint:

       curl -i http://127.0.0.1:5000/health

## Batch Job Exercise

Script: scripts/process_pending_orders.sh  
Input: scripts/batch_data/pending_orders.csv

Run:

    ./scripts/process_pending_orders.sh
    echo "Exit code: $?"

Review logs:

    cat logs/batch_job.log

The script checks whether the input file exists, counts CSV data rows, logs the result, and returns a success or failure exit code. It does not update MySQL orders and is not integrated with AutoSys or another enterprise scheduler.

## Incident Scenarios

| ID | Scenario |
|---|---|
| INC-001 | Payment successful but order pending |
| INC-002 | Database connection failure due to an incorrect port |
| INC-003 | Application runtime exception |
| INC-004 | Payment gateway timeout |
| INC-005 | Slow API response |
| INC-006 | Disk-space investigation |
| INC-007 | Application service availability |
| INC-008 | Batch-job failure |
| INC-009 | Deployment validation exercise |
| INC-010 | Network connectivity troubleshooting |

See the individual Markdown reports in the incidents/ directory for evidence, investigation steps, findings, and follow-up actions.

These are local training exercises using seeded data, historical log entries, or deliberately introduced faults. They are not claims of real production incidents. Unconfirmed root causes are identified as such.

## Useful Troubleshooting Commands

Application and API:

    curl -i http://127.0.0.1:5000/health
    curl -i http://127.0.0.1:5000/orders/8

Processes and ports:

    ps -ef | grep '[p]ython -m app.app'
    ss -ltnp

MySQL connectivity:

    sudo systemctl status mysql
    nc -zv 127.0.0.1 3306

Log analysis:

    tail -n 50 logs/application.log
    grep -n -i 'error' logs/application.log
    grep -n -i 'warning' logs/application.log
    tail -n 50 logs/batch_job.log

Disk usage:

    df -h
    du -sh .

## Current Limitations

- Local training environment; not deployed to production.
- Flask's development server is used.
- No real payment-gateway integration.
- The batch script counts CSV rows but does not process database orders.
- AutoSys, Splunk, and enterprise ITSM tools are not integrated.
- Automated unit and integration tests remain to be added.
- The health endpoint does not test database readiness.

## Learning Outcomes

- Application availability checks and API validation
- SQL-based order and payment investigation
- Linux process, port, network, and disk troubleshooting
- Application and batch-log analysis
- Python exception investigation
- Environment-based configuration
- Incident documentation and escalation
- Evidence-based root-cause investigation

