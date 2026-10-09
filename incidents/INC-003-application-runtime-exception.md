# INC-003: Application Runtime Exception

## Incident Summary
A temporary test endpoint deliberately raised a Python RuntimeError to demonstrate application exception troubleshooting.

## Impact
The test endpoint returned HTTP 500 while the exception was being simulated.

## Evidence Collected
- Temporary endpoint: GET /test-error
- Exception: RuntimeError
- Error message: Simulated application exception for INC-003
- Evidence source: Flask application logs and HTTP response

## Investigation
1. Called the temporary test endpoint.
2. Confirmed that the endpoint returned HTTP 500.
3. Reviewed the application logs for the exception and traceback.
4. Restored the original application file.
5. Checked Python syntax and verified that the order API worked again.

## Root Cause
The HTTP 500 was intentionally triggered by a test exception. This does not indicate an unresolved production defect.

## Resolution
Removed the temporary test endpoint by restoring the application backup. Verified that the normal order endpoint returned HTTP 200.

## Prevention
Use structured exception handling, useful logs, and appropriate HTTP error responses. Avoid exposing internal tracebacks to API clients.

## Exercise Type
Controlled application-exception simulation.
