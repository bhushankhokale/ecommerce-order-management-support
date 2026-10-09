# INC-002: Database Connectivity Failure

## Incident Summary
The application could not connect to MySQL when configured to use port 3307.

## Impact
The order API returned HTTP 500 because the application could not establish a database connection.

## Evidence Collected
- Configured database port during the test: 3307
- MySQL service: Active
- Verified MySQL listener: 127.0.0.1:3306
- Error: MySQL error 2003, connection refused on port 3307
- API tested: GET /orders/8

## Investigation
1. Reviewed the database connection error in application.log.
2. Checked the MySQL service status.
3. Confirmed that MySQL was listening on port 3306.
4. Tested the API with the incorrect port configuration.

## Root Cause
The controlled test used a database port that was not listening. This was a deliberately introduced configuration error, not evidence of a production outage.

## Resolution
Restored the original database configuration using the backup and restarted the Flask application. The order API subsequently returned HTTP 200.

## Prevention
Validate database host and port settings during deployment checks. Confirm connectivity before investigating SQL queries or application business logic.

## Exercise Type
Controlled configuration-failure simulation.
