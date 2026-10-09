# INC-007 — Application Service Availability

## Incident Summary
- Incident ID: INC-007
- Category: Application Availability
- Severity: Simulated training incident
- Environment: Local Ubuntu WSL environment
- Application: E-Commerce Order Management
- Port: 5000
- Final Status: Recovered and verified

## Incident Description
The Flask application was deliberately stopped as part of a controlled
availability troubleshooting exercise. A health-check request failed
because the application was not accepting connections on port 5000.

## Investigation Performed
1. Stopped the Flask application using Ctrl+C.
2. Tested the health endpoint using curl.
3. Confirmed that the connection to port 5000 failed.
4. Checked the Python application process using ps.
5. Checked port 5000 using ss.
6. Restarted the Flask application.
7. Repeated the health check and verified application recovery.
8. Confirmed the application process and listening port.

## Evidence
- While the application was stopped, curl returned:
  Connection failure on 127.0.0.1:5000.
- After recovery, the health endpoint returned HTTP 200 OK.
- Health response reported application status UP.
- Python application process was running with PID 836 at verification.
- Port 5000 was in LISTEN state on 0.0.0.0:5000.

## Root Cause Assessment
The application process had been intentionally stopped for this training
exercise. The failed health check was therefore expected. This was not
evidence of an unexpected production failure.

## Resolution
Restarted the Flask application and verified:
- Application process running
- Port 5000 listening
- Health endpoint responding with HTTP 200 OK
- Application status UP

## L1 Support Learning
- Check whether the application process is running.
- Check whether the expected port is listening.
- Test the application health endpoint.
- Correlate process, port, and HTTP response evidence.
- Verify service recovery after restarting the application.
- Record investigation steps and evidence in an incident report.

## Final Status
Recovered and verified. Controlled training exercise completed.
